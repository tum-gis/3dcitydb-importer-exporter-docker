#!/usr/bin/env bash

# docker build -t impexp:master \
#       --build-arg impexp_version=bbox_cli \
#     .

docker build -t tumgis/3dcitydb-importer-exporter:cli-rework \
      --build-arg impexp_version=cli-rework \
    .
