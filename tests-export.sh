#!/usr/bin/env bash
###############################################################################
# Functions
###############################################################################
# Cleanup data folder ---------------------------------------------------------
function cleanup() {
  rm -r -f -v share/data/export/*
}

# Run export tests from a folder containing txt files -------------------------
# $1  tests folder (local)
# $2  Export file ending
# $3  docker image
# $4  tag of docker image

function testExport() {
  find "$1" -type f -name "*.txt" | \
  xargs -L1 -I{} basename -s .txt "{}" | xargs -I{} \
    docker run --name impexp -t \
    --rm \
    -v /d/repos/docker/3dcitydb-impexp/share/:/share \
    --link cdbrail \
   "$3:$4" \
    "@/$1/{}.txt" \
    -o "/share/data/export/{}/{}.$2"
   echo "Exit code: $?"
}

###############################################################################
# Script
###############################################################################

# settings
image=tumgis/3dcitydb-importer-exporter
tag=latest

# Cleanup
cleanup

# Test CityGML Export ---------------------------------------------------------
testExport share/config/tests/export-citygml gml "$image" "$tag"

# Test KML/glTF Export --------------------------------------------------------
# Create export folders
find share/config/tests/export-vis -type f -name "*.txt" | \
  xargs -L1 -I{} basename -s .txt "{}" | xargs -I{} \
  mkdir -v -p "share/data/export/{}"

testExport share/config/tests/export-vis kml "$image" "$tag"
