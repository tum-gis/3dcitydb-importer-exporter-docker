#!/usr/bin/env bash

# docker run --name impexp -it \
#     -e PROJECT_XML= \
#     -e \
# impexp:master

# docker run --name impexp -it \
#   --rm \
#   -v /d/docker/impexp/:/share/ \
# impexp:new -version

# docker run --name impexp -it \
#   --rm \
#   -v /d/docker/impexp/:/share/ \
# impexp:new -config /share/config/config.xml -testConnection

# docker run --name impexp -it \
#    --rm \
#    -v /d/docker/impexp/:/share/ \
#  impexp:new -config /share/config/config.xml -kmlExport /share/data/ab/hans.kml

# docker run --name impexp -it \
#    --rm \
#    -v /d/docker/impexp/:/share/ \
#  impexp:new -config /share/config/config.xml -kmlExport /share/data/hans/hans.kml

# docker run --name impexp -it \
#   --rm \
#   -v /d/docker/impexp/:/share/ \
# impexp:new /bin/bash

# echo
# read -rsn1 -p 'Press ENTER to quit.'
# echo

docker run --name impexp -it \
   --rm \
   -v /d/repo/git/docker/3dcitydb-impexp/git/out/:/share/data/ \
 tumgis/3dcitydb-importer-exporter:cli-rework \
  "$@"
