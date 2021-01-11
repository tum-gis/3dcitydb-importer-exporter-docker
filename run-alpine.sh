#!/usr/bin/env bash

docker run --name impexp -i -t \
    --rm \
    -v /d/repos/docker/3dcitydb-impexp/share/:/share \
  tumgis/3dcitydb-importer-exporter:alpine "$@"

# Link cdbrail
# docker run --name impexp -i -t \
#     --rm \
#     -v /d/repo/git/docker/3dcitydb-impexp/git/share/:/share \
#     --link cdbrail \
#   tumgis/3dcitydb-importer-exporter:alpine "$@"