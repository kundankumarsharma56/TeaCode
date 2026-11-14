# syntax=docker/dockerfile:1
FROM node:22-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
# Public, non-secret legal/contact values are baked in at build time (see .env.example)
ARG VITE_LEGAL_ENTITY_NAME
ARG VITE_LEGAL_ADDRESS
ARG VITE_PRIVACY_CONTACT_EMAIL
ARG VITE_SUPPORT_EMAIL
ARG VITE_HOSTING_PROVIDER
ARG VITE_EMAIL_PROVIDER
ARG VITE_RETENTION_NOTE
# Firebase web config: public identifiers, not secrets (the API key only identifies the project; see docs/firebase-setup.md)
ARG VITE_FIREBASE_API_KEY
ARG VITE_FIREBASE_AUTH_DOMAIN
ARG VITE_FIREBASE_PROJECT_ID
ARG VITE_FIREBASE_APP_ID
RUN npm run build

# Unprivileged nginx: runs as a non-root user and listens on 8080
FROM nginxinc/nginx-unprivileged:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx/security-headers.conf nginx/proxy-common.conf /etc/nginx/snippets/
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD wget -q -O /dev/null http://127.0.0.1:8080/healthz || exit 1
