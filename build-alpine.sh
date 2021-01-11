#!/usr/bin/env bash

# OpenJDK
# DOCKER_BUILDKIT=1 \
# docker build -f Dockerfile.alpine \
#     -t tumgis/3dcitydb-importer-exporter:alpine \
#     --build-arg impexp_version=master \
#   .

# OpenJDK - nocache
DOCKER_BUILDKIT=1 \
docker build -f Dockerfile.alpine \
    -t tumgis/3dcitydb-importer-exporter:alpine \
    --no-cache \
    --build-arg impexp_version=master \
  .
