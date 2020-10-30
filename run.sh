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
   -e "JAVA_OPTS=-XX:+PrintFlagsFinal -Xmx1024m -XX:ActiveProcessorCount=4" \
   -v /d/repo/git/docker/3dcitydb-impexp/git/share/:/share/ \
 tumgis/3dcitydb-importer-exporter:cli-rework \
  "$@"


# docker run --name impexp -it \
#    --rm \
#    -e "JAVA_OPTS=-XX:+PrintFlagsFinal -Xmx1024m -XX:ActiveProcessorCount=4" \
#    -v /d/repo/git/docker/3dcitydb-impexp/git/share/:/share/ \
#  tumgis/3dcitydb-importer-exporter:oracle-jvm \
#   "$@"