#!/usr/bin/env bash
###############################################################################
# Functions
###############################################################################
# Run import tests from a folder containing txt files -------------------------
# $1  tests folder (local)
# $2  Import files or folders
# $3  docker image
# $4  tag of docker image

function testImport() {
  find "$1" -type f -name "*.txt" | \
  xargs -L1 -I{} basename -s .txt "{}" | xargs -I{} \
    docker run --name impexp -t \
    --rm \
    -v /d/repo/git/docker/3dcitydb-impexp/git/share/:/share \
    --link cdbimp \
   "$3:$4" \
   "@/$1/{}.txt" "$2"
   echo "Exit code: $?"
}

###############################################################################
# Script
###############################################################################

# settings
image=tumgis/3dcitydb-importer-exporter
tag=master

# Test CityGML Import ---------------------------------------------------------
port=$(shuf -i 2000-65000 -n 1)
docker rm -f -v cdbimp
docker run -d --name cdbimp --rm \
  -p $port:5432 \
  -e "POSTGRES_PASSWORD=postgres" \
  -e "SRID=3068" \
  -e "SRSNAME=urn:ogc:def:crs,crs:EPSG::3068,crs:EPSG::5783" \
tumgis/3dcitydb-postgis:alpine

# Wait for 3DCityDB
./wait-for-psql.sh 30 localhost $port postgres postgres echo "citydb ready!"

# Runs tests
testImport share/config/tests/import /share/data/import/railway-scene-lod3

# Remove 3DcityDb container
docker rm -f -v cdbimp
