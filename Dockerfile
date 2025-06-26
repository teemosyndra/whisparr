# syntax=docker/dockerfile:1

FROM ubuntu:22.04

# This ARG is set automatically by Buildx during multi-arch builds
ARG TARGETARCH
ARG UPSTREAM_IMAGE
ARG UPSTREAM_DIGEST

EXPOSE 6969
ARG IMAGE_STATS
ENV IMAGE_STATS=${IMAGE_STATS} WEBUI_PORTS="6969/tcp,6969/udp"

RUN apt-get update && apt-get install -y libsqlite3-0 libicu70

ARG VERSION
ARG SBRANCH
ARG PACKAGE_VERSION=${VERSION}


# Example: download binary for the correct architecture
RUN mkdir "${APP_DIR}/bin" && \
    if [ "$TARGETARCH" = "amd64" ]; then \
      curl -fsSL "https://whisparr.servarr.com/v1/update/${SBRANCH}/updatefile?version=${VERSION}&os=linuxmusl&runtime=netcore&arch=x64" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 ; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
      curl -fsSL "https://whisparr.servarr.com/v1/update/${SBRANCH}/updatefile?version=${VERSION}&os=linuxmusl&runtime=netcore&arch=arm64" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 ; \
    fi && \
    rm -rf "${APP_DIR}/bin/Whisparr.Update" && \
    echo -e "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=${SBRANCH}" > "${APP_DIR}/package_info" && \
    chmod -R u=rwX,go=rX "${APP_DIR}"
    
# RUN mkdir "${APP_DIR}/bin" && \
#     curl -fsSL "https://whisparr.servarr.com/v1/update/${SBRANCH}/updatefile?version=${VERSION}&os=linuxmusl&runtime=netcore&arch=x64" | tar xzf - -C "${APP_DIR}/bin" --strip-components=1 && \
#     rm -rf "${APP_DIR}/bin/Whisparr.Update" && \
#     echo -e "PackageVersion=${PACKAGE_VERSION}\nPackageAuthor=[hotio](https://github.com/hotio)\nUpdateMethod=Docker\nBranch=${SBRANCH}" > "${APP_DIR}/package_info" && \
#     chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
