package com.teacode.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import com.teacode.exception.BadRequestException;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.Arrays;
import javax.imageio.ImageIO;
import org.junit.jupiter.api.Test;

class AvatarServiceTest {

    private static byte[] image(int w, int h, String format) throws Exception {
        BufferedImage img = new BufferedImage(w, h, format.equals("jpg") ? BufferedImage.TYPE_INT_RGB : BufferedImage.TYPE_INT_ARGB);
        for (int x = 0; x < w; x++) {
            for (int y = 0; y < h; y++) {
                img.setRGB(x, y, 0xFF3366CC);
            }
        }
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        ImageIO.write(img, format, out);
        return out.toByteArray();
    }

    @Test
    void reencodesPngAsSquare256Png() throws Exception {
        byte[] out = AvatarService.sanitize(image(300, 200, "png"));
        BufferedImage decoded = ImageIO.read(new ByteArrayInputStream(out));
        assertThat(decoded.getWidth()).isEqualTo(AvatarService.OUTPUT_SIDE);
        assertThat(decoded.getHeight()).isEqualTo(AvatarService.OUTPUT_SIDE);
        assertThat(out[1]).isEqualTo((byte) 'P'); // PNG signature
    }

    @Test
    void acceptsJpeg() throws Exception {
        assertThat(AvatarService.sanitize(image(64, 64, "jpg"))).isNotEmpty();
    }

    @Test
    void dropsTrailingPayloadAppendedAfterTheImage() throws Exception {
        byte[] png = image(64, 64, "png");
        byte[] withPayload = Arrays.copyOf(png, png.length + 20);
        System.arraycopy("<script>alert(1)</script>".getBytes(), 0, withPayload, png.length, 20);
        byte[] out = AvatarService.sanitize(withPayload);
        assertThat(new String(out, java.nio.charset.StandardCharsets.ISO_8859_1)).doesNotContain("<script>");
    }

    @Test
    void rejectsNonImagesWhateverTheyClaimToBe() {
        assertThatThrownBy(() -> AvatarService.sanitize("<svg xmlns='http://www.w3.org/2000/svg'/>".getBytes()))
                .isInstanceOf(BadRequestException.class);
        assertThatThrownBy(() -> AvatarService.sanitize("GIF89a....".getBytes())).isInstanceOf(BadRequestException.class);
        assertThatThrownBy(() -> AvatarService.sanitize(new byte[0])).isInstanceOf(BadRequestException.class);
        assertThatThrownBy(() -> AvatarService.sanitize(null)).isInstanceOf(BadRequestException.class);
    }

    @Test
    void rejectsTruncatedOrCorruptImages() throws Exception {
        byte[] png = image(64, 64, "png");
        assertThatThrownBy(() -> AvatarService.sanitize(Arrays.copyOf(png, 40))).isInstanceOf(BadRequestException.class);
    }

    @Test
    void rejectsTooSmallAndOversizedFiles() throws Exception {
        assertThatThrownBy(() -> AvatarService.sanitize(image(16, 16, "png"))).isInstanceOf(BadRequestException.class);
        byte[] big = new byte[AvatarService.MAX_BYTES + 1];
        big[0] = (byte) 0x89; big[1] = 'P'; big[2] = 'N'; big[3] = 'G';
        assertThatThrownBy(() -> AvatarService.sanitize(big)).isInstanceOf(BadRequestException.class);
    }
}
