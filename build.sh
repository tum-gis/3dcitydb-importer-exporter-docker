#!/usr/bin/env bash

# docker build -t impexp:master \
#       --build-arg impexp_version=bbox_cli \
#     .

# Oracle JVM
# docker build -t tumgis/3dcitydb-importer-exporter:oracle-jvm \
#       --build-arg impexp_version=cli-rework \
#     .

# OpenJDK
docker build -t tumgis/3dcitydb-importer-exporter:cli-rework \
      --build-arg impexp_version=cli-rework \
    .

# OpenJDK - nocache
# docker build -t tumgis/3dcitydb-importer-exporter:cli-rework \
#       --no-cache \
#       --build-arg impexp_version=cli-rework \
#     .


# Alpine ######################################################################
#docker build -f Dockerfile.alpine -t tumgis/3dcitydb-importer-exporter:alpine .