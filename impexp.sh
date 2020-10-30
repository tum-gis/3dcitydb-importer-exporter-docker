#!/usr/bin/env bash

# Print commands and their arguments as they are executed
set -e;

# echo version info and maintainer
cat <<EOF


# 3DCityDB ImporterExporter Docker #############################################
################################################################################
#
#   3DCityDB ImporterExporter version $IMPEXP_VERSION
#     version info    https://github.com/3dcitydb/3dcitydb/tree/${IMPEXP_VERSION}
#
# Maintainer -------------------------------------------------------------------
#   Bruno Willenborg
#   Chair of Geoinformatics
#   Department of Aerospace and Geodesy
#   Technical University of Munich (TUM)
#   b.willenborg(at)tum.de
#   www.gis.lrg.tum.de
################################################################################

EOF

# Print version info
# printf "3DCityDB ImporterExporter version: "
# ./bin/impexp -V

# Print cmd line passed to container
printf "\nCommand line passed to 3DCityDB ImporterExporter:\n"
printf "\t"
echo "$@"
printf "\n\n"

# ./bin/3DCityDB-Importer-Exporter -shell "$@"
./bin/impexp "$@"
