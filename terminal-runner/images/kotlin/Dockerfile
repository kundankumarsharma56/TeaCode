# Sandbox image for Kotlin: Temurin JDK + the official JetBrains compiler, version and SHA-256 pinned.
FROM eclipse-temurin:21-jdk-alpine
ARG KOTLIN_VERSION=2.4.21
ARG KOTLIN_SHA256=7cc140e76daf416a0424a5557f99afd7ca89ebd463ea1101261e3e01c33e75cd
RUN apk add --no-cache bash curl unzip \
 && curl -fsSL -o /tmp/kotlin.zip "https://github.com/JetBrains/kotlin/releases/download/v${KOTLIN_VERSION}/kotlin-compiler-${KOTLIN_VERSION}.zip" \
 && echo "${KOTLIN_SHA256}  /tmp/kotlin.zip" | sha256sum -c - \
 && unzip -q /tmp/kotlin.zip -d /opt \
 && rm /tmp/kotlin.zip \
 && apk del curl unzip
ENV PATH="/opt/kotlinc/bin:${PATH}"