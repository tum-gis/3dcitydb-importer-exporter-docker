#!/usr/bin/env bash

rm -r -f -v share/data/export/*

# docker run --name impexp -it \
#    --rm \
#    -v /d/repo/git/docker/3dcitydb-impexp/git/share/:/share \
#  tumgis/3dcitydb-importer-exporter:export-vis-cli \
#   "$@"

# Link CDB rail
docker run --name impexp -it \
   --rm \
   -v /d/repo/git/docker/3dcitydb-impexp/git/share/:/share \
   --link cdbrail \
 tumgis/3dcitydb-importer-exporter:export-vis-cli \
  "$@"
