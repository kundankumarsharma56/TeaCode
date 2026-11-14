package com.teacode.service;

import com.teacode.dto.UserResponse;
import com.teacode.entity.User;
import com.teacode.entity.UserAvatar;
import com.teacode.exception.BadRequestException;
import com.teacode.exception.NotFoundException;
import com.teacode.exception.UnauthorizedException;
import com.teacode.repository.UserAvatarRepository;
import com.teacode.repository.UserRepository;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.security.SecureRandom;
import java.time.Clock;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.HexFormat;
import java.util.Iterator;
import java.util.Set;
import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import org.springframework.stereotype.Service;
import org.springframework.transaction.support.TransactionTemplate;

/**
 * Avatar upload. The browser-supplied content type and file name are never trusted: the bytes are
 * sniffed, decoded as a real image within size limits, cropped to a square, scaled and re-encoded as PNG
 * (which drops all metadata and any trailing or embedded payload).
 */
@Service
public class AvatarService {

    public static final int MAX_BYTES = 2 * 1024 * 1024;
    static final int MAX_SIDE = 4096;
    static final int MIN_SIDE = 32;
    static final int OUTPUT_SIDE = 256;
    private static final Set<String> FORMATS = Set.of("png", "jpeg", "webp");
    private static final SecureRandom RANDOM = new SecureRandom();

    private final UserRepository users;
    private final UserAvatarRepository avatars;
    private final UserViewService views;
    private final RateLimiter limiter;
    private final TransactionTemplate tx;
    private final Clock clock;

    public AvatarService(UserRepository users, UserAvatarRepository avatars, UserViewService views,
                         RateLimiter limiter, TransactionTemplate tx, Clock clock) {
        this.users = users;
        this.avatars = avatars;
        this.views = views;
        this.limiter = limiter;
        this.tx = tx;
        this.clock = clock;
        ImageIO.setUseCache(false);
    }

    public UserResponse upload(long userId, byte[] bytes) {
        limiter.check("avatar-upload", Long.toString(userId), 10, Duration.ofHours(1));
        byte[] png = sanitize(bytes);
        String key = HexFormat.of().formatHex(randomBytes(16));
        LocalDateTime now = LocalDateTime.now(clock.withZone(ZoneOffset.UTC));
        return tx.execute(status -> {
            User user = users.findById(userId).orElseThrow(() -> new UnauthorizedException("Not signed in."));
            // Same primary key: this replaces any previous upload.
            avatars.saveAndFlush(new UserAvatar(userId, key, "image/png", png, now));
            user.setAvatarPreference("CUSTOM");
            return views.view(users.saveAndFlush(user));
        });
    }

    /** Removes the uploaded image; the provider image (if any) becomes active again. Idempotent. */
    public UserResponse remove(long userId) {
        return tx.execute(status -> {
            User user = users.findById(userId).orElseThrow(() -> new UnauthorizedException("Not signed in."));
            avatars.deleteById(userId);
            avatars.flush();
            user.setAvatarPreference("PROVIDER");
            return views.view(users.saveAndFlush(user));
        });
    }

    public UserAvatar find(String key) {
        return avatars.findByAvatarKey(key).orElseThrow(() -> new NotFoundException("Not found."));
    }

    // ---------------------------------------------------------------- image handling

    static byte[] sanitize(byte[] bytes) {
        if (bytes == null || bytes.length == 0) {
            throw new BadRequestException("Choose an image file.");
        }
        if (bytes.length > MAX_BYTES) {
            throw new BadRequestException("The image must be 2 MB or smaller.");
        }
        if (!looksLikeSupportedImage(bytes)) {
            throw new BadRequestException("Only PNG, JPEG or WebP images are accepted.");
        }
        try (ImageInputStream in = ImageIO.createImageInputStream(new ByteArrayInputStream(bytes))) {
            Iterator<ImageReader> readers = ImageIO.getImageReaders(in);
            if (!readers.hasNext()) {
                throw new BadRequestException("The file is not a valid image.");
            }
            ImageReader reader = readers.next();
            try {
                if (!FORMATS.contains(reader.getFormatName().toLowerCase())) {
                    throw new BadRequestException("Only PNG, JPEG or WebP images are accepted.");
                }
                reader.setInput(in, true, true);
                // Dimensions are checked from the header before decoding pixels (decompression-bomb guard).
                int w = reader.getWidth(0);
                int h = reader.getHeight(0);
                if (w < MIN_SIDE || h < MIN_SIDE || w > MAX_SIDE || h > MAX_SIDE) {
                    throw new BadRequestException("The image must be between " + MIN_SIDE + " and " + MAX_SIDE + " pixels on each side.");
                }
                BufferedImage src = reader.read(0);
                return encodeSquare(src);
            } finally {
                reader.dispose();
            }
        } catch (IOException | RuntimeException e) {
            if (e instanceof BadRequestException bre) {
                throw bre;
            }
            throw new BadRequestException("The file is not a valid image.");
        }
    }

    /** Magic-byte check: PNG, JPEG or WebP (RIFF....WEBP). */
    static boolean looksLikeSupportedImage(byte[] b) {
        boolean png = b.length > 8 && (b[0] & 0xFF) == 0x89 && b[1] == 'P' && b[2] == 'N' && b[3] == 'G';
        boolean jpeg = b.length > 3 && (b[0] & 0xFF) == 0xFF && (b[1] & 0xFF) == 0xD8 && (b[2] & 0xFF) == 0xFF;
        boolean webp = b.length > 12 && b[0] == 'R' && b[1] == 'I' && b[2] == 'F' && b[3] == 'F'
                && b[8] == 'W' && b[9] == 'E' && b[10] == 'B' && b[11] == 'P';
        return png || jpeg || webp;
    }

    private static byte[] encodeSquare(BufferedImage src) throws IOException {
        int side = Math.min(src.getWidth(), src.getHeight());
        int x = (src.getWidth() - side) / 2;
        int y = (src.getHeight() - side) / 2;
        BufferedImage out = new BufferedImage(OUTPUT_SIDE, OUTPUT_SIDE, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g = out.createGraphics();
        try {
            g.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
            g.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_QUALITY);
            g.drawImage(src, 0, 0, OUTPUT_SIDE, OUTPUT_SIDE, x, y, x + side, y + side, null);
        } finally {
            g.dispose();
        }
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        if (!ImageIO.write(out, "png", bos)) {
            throw new IOException("PNG writer unavailable");
        }
        return bos.toByteArray();
    }

    private static byte[] randomBytes(int n) {
        byte[] b = new byte[n];
        RANDOM.nextBytes(b);
        return b;
    }
}
