# The runner is a control plane only. Untrusted code runs in disposable containers
# created on a separate rootless Docker daemon, never in this Node process.
FROM node:22-alpine
ENV NODE_ENV=production
WORKDIR /opt/terminal-runner
COPY package.json package-lock.json ./
RUN npm ci --omit=dev --no-audit --no-fund && addgroup -S runner && adduser -S runner -G runner
COPY server.js runner.js ./
USER runner
EXPOSE 3000
HEALTHCHECK --interval=15s --timeout=3s --start-period=15s --retries=3 CMD node -e "fetch('http://127.0.0.1:3000/healthz').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"
CMD ["node", "server.js"]
