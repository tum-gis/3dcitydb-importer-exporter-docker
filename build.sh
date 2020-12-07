#!/usr/bin/env bash

# Oracle JVM - no cache
# DOCKER_BUILDKIT=1 \
# docker build -t tumgis/3dcitydb-importer-exporter:oracle-jvm \
#     --build-arg impexp_version=master \
#     --no-cache \
#   .

# Oracle JVM
# DOCKER_BUILDKIT=1 \
# docker build -t tumgis/3dcitydb-importer-exporter:oracle-jvm \
#     --build-arg impexp_version=master \
#   .

# OpenJDK - master - no cache
DOCKER_BUILDKIT=1 \
docker build -t tumgis/3dcitydb-importer-exporter:export-vis-cli \
    --build-arg impexp_version=export-vis-cli \
    --no-cache \
  .

# OpenJDK - master
# DOCKER_BUILDKIT=1 \
# docker build -t tumgis/3dcitydb-importer-exporter:master \
#     --build-arg impexp_version=export-vis-cli \
#   .
