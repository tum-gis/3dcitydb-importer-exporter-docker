#!/usr/bin/env sh

# Print commands and their arguments as they are executed
set -e;

# read version info file
versioninfo=`cat /versioninfo.txt`

# echo version info and maintainer
cat <<EOF


# 3DCityDB ImporterExporter Docker #############################################
################################################################################
# Official repo   github.com/3dcitydb/importer-exporter
# Docker repo     github.com/tum-gis/3dcitydb-importer-exporter-docker

# Version info -----------------------------------------------------------------
$versioninfo

# Maintainer -------------------------------------------------------------------
  Bruno Willenborg
  Chair of Geoinformatics
  Department of Aerospace and Geodesy
  Technical University of Munich (TUM)
  b.willenborg(at)tum.de
  www.gis.lrg.tum.de
################################################################################

EOF

# Print cmd line passed to container
printf "\nCommand line passed to 3DCityDB ImporterExporter:\n"
printf "\t"
echo "$@"
printf "\n\n"

# ./bin/3DCityDB-Importer-Exporter -shell "$@"
./bin/impexp "$@"
