#!/usr/bin/env bash

docker run --name impexp -it \
   --rm \
   -v /d/repo/git/docker/3dcitydb-impexp/git/share/:/share \
 tumgis/3dcitydb-importer-exporter \
  "$@"

# Link CDB rail
# docker run --name impexp -it \
#    --rm \
#    -v /d/repo/git/docker/3dcitydb-impexp/git/share/:/share \
#    --link cdbrail \
#  tumgis/3dcitydb-importer-exporter \
#   "$@"
