#!/usr/bin/env bash

# Run import tests from a folder containing txt files -------------------------
# $1  tests folder (local)
# $2  Import files or folders

function testImport() {
  find "$1" -type f -name "*.txt" | \
  xargs -L1 -I{} basename -s .txt "{}" | xargs -I{} \
    docker run --name impexp -t \
    --rm \
    -v /d/repo/git/docker/3dcitydb-impexp/git/share/:/share \
    --link cdbimp \
   tumgis/3dcitydb-importer-exporter:cli-rework "@/$1/{}.txt" "$2"
   echo "Exit code: $?"
}


# Test CityGML Import ---------------------------------------------------------
port=$(shuf -i 2000-65000 -n 1)
docker rm -f -v cdbimp
docker run -d --name cdbimp --rm \
  -p $port:5432 \
  -e "POSTGRES_PASSWORD=postgres" \
  -e "SRID=3068" \
  -e "SRSNAME=urn:ogc:def:crs,crs:EPSG::3068,crs:EPSG::5783" \
tumgis/3dcitydb-postgis:alpine

./wait-for-psql.sh 30 localhost $port postgres postgres echo "citydb ready!"

    # TIMEOUT         Timeout in seconds
    # HOST            Host or IP under test
    # PORT            TCP port under test
    # USERNAME        postgres db user name
    # PASSWORD        postgres db user password
    # COMMAND ARGS    Execute command with args after the test finishes

testImport share/config/tests/import /share/data/import/railway-scene-lod3

# Remove 3DcityDb container
docker rm -f -v cdbimp