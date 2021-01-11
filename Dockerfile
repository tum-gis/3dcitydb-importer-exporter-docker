# 3DCityDB Importer/Exporter Dockerfile #######################################
#   Official website    https://www.3dcitydb.net
#   GitHub              https://github.com/3dcitydb/importer-exporter
###############################################################################

# Fetch & build stage #########################################################
# Base image
ARG buildstage_tag='11.0.9-slim'
FROM openjdk:${buildstage_tag} AS buildstage

# Settings
ARG impexp_version='master'
ENV IMPEXP_VERSION=${impexp_version}
ARG BUILD_PACKAGES='git'
WORKDIR /build_tmp

# Install build packages
RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends $BUILD_PACKAGES

# Fetch source
RUN set -x && \
  git clone -b "${IMPEXP_VERSION}" --depth 1 https://github.com/3dcitydb/importer-exporter.git /build_tmp

# Build
RUN set -x && \
  chmod u+x ./gradlew && ./gradlew installDockerDist

# Move dist
RUN set -x && \
  mkdir -p /impexp && \
  mv impexp-client/build/install/3DCityDB-Importer-Exporter-Docker/* /impexp

# Create version info file
COPY gitinfo.sh /build_tmp
RUN set -x && \
  chmod u+x /build_tmp/gitinfo.sh && \
  /build_tmp/gitinfo.sh /versioninfo.txt && \
  cat /versioninfo.txt

# Cleanup
RUN set -x && \
  apt-get purge -y --auto-remove $BUILD_PACKAGES && \
  rm -rf /build_tmp /impexp/contribs/collada2gltf/*osx* /impexp/contribs/collada2gltf/*windows* \
    /impexp/license /impexp/**/*.md /impexp/**/*.txt /impexp/**/*.bat \
    /var/lib/apt/lists/*

# Runtime stage ###############################################################
ARG runtimestage_tag='11.0.9-jre-slim'
FROM openjdk:11-jre-slim AS runtimestage
COPY --from=buildstage /impexp /impexp
COPY --from=buildstage /versioninfo.txt /versioninfo.txt
WORKDIR /impexp

RUN set -x && \
  mkdir -p /share/config /share/data && \
  chmod -v u+x /impexp/bin/* /impexp/contribs/collada2gltf/COLLADA2GLTF*linux/COLLADA2GLTF-bin && \
  ln -vs /impexp/bin/impexp /usr/bin/impexp

# Copy entrypoint script
COPY impexp.sh /impexp/bin/

ENTRYPOINT [ "./bin/impexp.sh" ]

# Labels ######################################################################
LABEL maintainer="Bruno Willenborg"
LABEL maintainer.email="b.willenborg(at)tum.de"
LABEL maintainer.organization="Chair of Geoinformatics, Technical University of Munich (TUM)"
LABEL source.repo="https://github.com/tum-gis/3dcitydb-importer-exporter-docker"
