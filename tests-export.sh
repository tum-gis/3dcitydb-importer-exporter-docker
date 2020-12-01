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

function testExport() {
  find "$1" -type f -name "*.txt" | \
  xargs -L1 -I{} basename -s .txt "{}" | xargs -I{} \
    docker run --name impexp -t \
    --rm \
    -v /d/repo/git/docker/3dcitydb-impexp/git/share/:/share \
    --link cdbrail \
   tumgis/3dcitydb-importer-exporter:cli-rework "@/$1/{}.txt" -o "/share/data/export/{}/{}.$2"
   echo "Exit code: $?"
}

###############################################################################
# Script
###############################################################################

# Cleanup
cleanup

# Tests #######################################################################
# Start Railway LoD3 dataset 3DcityDB container
docker rm -f -v cdbrail
docker run -d --name cdbrail --rm tumgis/3dcitydb-postgis:railwayScene_LoD3

# Test CityGML Export ---------------------------------------------------------
testExport share/config/tests/export-citygml gml

# Test KML/glTF Export --------------------------------------------------------
# Create export folders
find share/config/tests/export-vis -type f -name "*.txt" | \
  xargs -L1 -I{} basename -s .txt "{}" | xargs -I{} \
  mkdir -v -p share/data/export/{}

testExport share/config/tests/export-vis kml

# Remove Railway LoD3 dataset 3DcityDB container
docker rm -f -v cdbrail
