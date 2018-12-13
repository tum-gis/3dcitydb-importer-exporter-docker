# 3DCityDB Importer/Exporter Dockerfile #######################################
#   Official website    https://www.3dcitydb.net
#   GitHub              https://github.com/3dcitydb/importer-exporter
###############################################################################
# Base image
ARG baseimage_tag='11'
FROM openjdk:${baseimage_tag}

# Labels ######################################################################
LABEL maintainer="Bruno Willenborg"
LABEL maintainer.email="b.willenborg(at)tum.de"
LABEL maintainer.organization="Chair of Geoinformatics, Technical University of Munich (TUM)"
LABEL source.repo="https://github.com/tum-gis/3dcitydb-importer-exporter-docker"

# Setup PostGIS and 3DCityDB ##################################################
ARG impexp_version='master'
ENV IMPEXPVERSION=${impexp_version}

ARG BUILD_PACKAGES='git'

# Setup build and runtime deps
RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends $BUILD_PACKAGES

# Clone 3DCityDB
RUN set -x && \
  mkdir -p build_tmp && \
  git clone -b "${IMPEXPVERSION}" --depth 1 https://github.com/3dcitydb/importer-exporter.git build_tmp

# Build ImpExp
RUN set -x && \
  cd build_tmp && \
  chmod u+x ./gradlew && \
  ./gradlew installDist && \
  mv impexp-client/build/install/3DCityDB-Importer-Exporter/ ../impexp && \  
  cd .. && \
  mkdir /impexp/config

# Cleanup
RUN set -x && \
  rm -rf build_tmp && \
  apt-get purge -y --auto-remove $BUILD_PACKAGES && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT [ "/impexp/bin/3DCityDB-Importer-Exporter",  "-shell", "-config", "/share/config/config.xml" ]
