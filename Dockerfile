# 3DCityDB Importer/Exporter Dockerfile #######################################
#   Official website    https://www.3dcitydb.net
#   GitHub              https://github.com/3dcitydb/importer-exporter
###############################################################################
# Base image
ARG buildstage_tag='11-slim'
FROM openjdk:${buildstage_tag} AS buildstage

# Labels ######################################################################
LABEL maintainer="Bruno Willenborg"
LABEL maintainer.email="b.willenborg(at)tum.de"
LABEL maintainer.organization="Chair of Geoinformatics, Technical University of Munich (TUM)"
LABEL source.repo="https://github.com/tum-gis/3dcitydb-importer-exporter-docker"

# Setup PostGIS and 3DCityDB ##################################################
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
  chmod u+x ./gradlew && ./gradlew installDist

# Move dist
RUN set -x && \
  mkdir -p /impexp && \
  mv impexp-client/build/install/3DCityDB-Importer-Exporter/* /impexp

# Cleanup
RUN set -x && \
  apt-get purge -y --auto-remove $BUILD_PACKAGES && \
  rm -rf /build_tmp /impexp/samples /impexp/3dcitydb /impexp/3d-web-map-client \
    /impexp/contribs/collada2gltf/*osx* /impexp/contribs/collada2gltf/*windows* \
    /impexp/license /impexp/templates /impexp/**/*.md /impexp/**/*.txt /impexp/**/*.bat \
    /var/lib/apt/lists/*

# Runtime stage
ARG runtimestage_tag='11-jre-slim'
FROM openjdk:11-jre-slim
COPY --from=buildstage /impexp /impexp

RUN set -x && \
  mkdir -p /share/config /share/data && \
  chmod -v u+x /impexp/bin/* /impexp/contribs/collada2gltf/COLLADA2GLTF*linux/COLLADA2GLTF-bin

# Copy entrypoint script
COPY impexp.sh /impexp/bin/
COPY impexp-opts.txt /share/config/

WORKDIR /impexp
ENTRYPOINT [ "./bin/impexp.sh" ]
