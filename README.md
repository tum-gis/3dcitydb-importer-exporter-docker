# 3DCityDB Importer/Exporter Docker

**Warning: This is a pre-release. The image has not jet been tested and this documentation is incomplete and possibly wrong!**

A test image is available here: [tumgis/3dcitydb-importer-exporter](tumgis/3dcitydb-importer-exporter) on DockerCloud.

This repo contains a Dockerfile for the [3D City Database (3DCityDB) Importer/Exporter](https://github.com/3dcitydb/importer-exporter). The images can be used to run the Importer/Exporter CLI and use the in automation processes. To get the 3DCityDB Importer/Exporter images visit the [tumgis/3dcitydb-impexp](https://hub.docker.com/r/tumgis/3dcitydb-impexp/) DockerHub page. Currently, only the Importer/Exporter versions >= `4.0.0` are supported.

:rocket: To get started immediately go to the [quick start](#quick-start) section. :rocket:

> **Note:** The content in this repo is in development stage.
> If you experience any problems or have a suggestion/improvement please let me know by creating an [issue](https://github.com/tum-gis/3dcitydb-importer-exporter-docker/issues) or make a contribution with a [pull request](https://github.com/tum-gis/3dcitydb-docker-postgis/pulls).

## News

* 2020-12 Added Alpine image
* 2020-12 Reduced image size using mlti stage builds
* Support for powerful new 3DCityDB Importer/Exporter CLI added

## Image variants

The Docker images are available on DockerHub from [tumgis](https://hub.docker.com/r/tumgis/).
To get the image run: `docker pull tumgis/3dcitydb-importer-exporter:<TAG>` Following tags are available:

| Tag        | Build status                                                                                                                                                  | Description                                                          |
|------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------:|----------------------------------------------------------------------|
| ``latest`` | To be done [![Build Status](https://travis-ci.com/tum-gis/3dcitydb-importer-exporter-docker.svg?branch=master)](https://travis-ci.com/tum-gis/3dcitydb-importer-exporter-docker) | Latest image version built from Importer/Exporter `master` using Debian and OpenJDK      |
| ``alpine`` | To be done [![Build Status](https://travis-ci.com/tum-gis/3dcitydb-importer-exporter-docker.svg?branch=alpine)](https://travis-ci.com/tum-gis/3dcitydb-importer-exporter-docker) | Image based on lightweight Alpine Linux v3.12 and OpenJDK        |

## Content

- [3DCityDB Importer/Exporter Docker](#3dcitydb-importerexporter-docker)
  - [News](#news)
  - [Image variants](#image-variants)
  - [Content](#content)
  - [Quick start](#quick-start)
    - [Linux (`bash`)](#linux-bash)
    - [Windows (`cmd`)](#windows-cmd)
  - [More 3DCityDB Docker Images](#more-3dcitydb-docker-images)
  - [Usage](#usage)
  - [Importer/Exporter CLI documentation](#importerexporter-cli-documentation)
    - [Import](#import)
    - [Export](#export)
    - [Visualization export (kml, collada, glTF)](#visualization-export-kml-collada-gltf)
    - [Delete](#delete)
    - [Validate](#validate)
    - [GUI](#gui)

## Quick start

1. Create a folder for exchanging data between the Importer/Exporter container and the Docker host, e.g. `/my/local/share/folder`. This folder will be mounted to the container later in the process.

2. Run the Importer/Exporter docker image using the command below.
Append the COMMAND, OPTIONS and ARGUMENTS as described in the [Importer/Exporter CLI documentation](#importerexporter-cli-documentation) below.

### Linux (`bash`)

``` bash
docker run --name impexp -i -t --rm \
  -v /my/local/share/folder:/share \
tumgis/3dcitydb-importer-exporter COMMAND OPTS ARGS
```

### Windows (`cmd`)

``` cmd
  docker run --name impexp -i -t --rm ^
    -v /my/local/share/folder:/share ^
  tumgis/3dcitydb-importer-exporter COMMAND OPTS ARGS
```

## More 3DCityDB Docker Images

Check out the Docker images for the *3D City Database*, *3D City Database Web Feature Service (WFS)*, and the *3D City Database Web-Map-Client* too:

* [3DCityDB image](https://github.com/tum-gis/3dcitydb-docker-postgis/)
* [3DCityDB Web-Map-Client image](https://github.com/tum-gis/3dcitydb-web-map-docker/)
* [3DCityDB Web Feature Service (WFS) image](https://github.com/tum-gis/3dcitydb-wfs-docker/)

## Usage

To be done!

## Importer/Exporter CLI documentation

This section contains the output of the Importer/Exporter CLI `help` command.

```text
  Usage: impexp [-hV] [-c=<file>] [--log-file=<file>] [--log-level=<level>]
                [--pid-file=<file>] [@<filename>...] COMMAND
  Command-line interface for the 3D City Database.
        [@<filename>...]      One or more argument files containing options.
    -c, --config=<file>       Use configuration from this file.
        --log-level=<level>   Log level: error, warn, info, debug (default: info).
        --log-file=<file>     Write log messages to this file.
        --pid-file=<file>     Create a file containing the current process ID.
    -h, --help                Show this help message and exit.
    -V, --version             Print version information and exit.
  Commands:
    help        Displays help information about the specified command
    import      Imports data in CityGML or CityJSON format.
    export      Exports data in CityGML format.
    export-vis  Exports data in KML/COLLADA/glTF format for visualization.
    delete      Deletes top-level city objects from the database.
    validate    Validates input files against their schemas.
    gui         Starts the graphical user interface.
```

### Import

```text
  Usage: impexp import [-hV] [-c=<file>] [--import-log=<file>]
                      [--log-file=<file>] [--log-level=<level>]
                      [--pid-file=<file>] [--worker-threads=<threads[,max]>]
                      [[[-t=<[prefix:]name>[,<[prefix:]name>...]]...
                      [--namespace=<prefix=name>[,<prefix=name>...]]...] [-i=<id>
                      [,<id>...] [-i=<id>[,<id>...]]...] [-b=<minx,miny,maxx,maxy
                      [,srid]> [--bbox-mode=<mode>]] [[--count=<count>]
                      [--start-index=<index>]] [[--no-appearance]]]
                      [[-T=<database>] -H=<host> [-P=<port>] -d=<name>
                      [-S=<schema>] -u=<name> [-p[=<password>]]]
                      [@<filename>...] <file>...
  Imports data in CityGML or CityJSON format.
        [@<filename>...]       One or more argument files containing options.
        <file>...              Files or directories to import (glob patterns
                                allowed).
        --import-log=<file>    Record imported top-level features to this file.
        --worker-threads=<threads[,max]>
                              Number of worker threads to use.
    -h, --help                 Show this help message and exit.
    -V, --version              Print version information and exit.
    -c, --config=<file>        Use configuration from this file.
        --log-level=<level>    Log level: error, warn, info, debug (default:
                                info).
        --log-file=<file>      Write log messages to this file.
        --pid-file=<file>      Create a file containing the current process ID.
  Import filter options:
    -t, --type-name=<[prefix:]name>[,<[prefix:]name>...]
                              Names of the top-level features to process.
        --namespace=<prefix=name>[,<prefix=name>...]
                              Prefix-to-namespace mappings.
    -i, --gml-id=<id>[,<id>...]
                              Process top-level features with a matching gml:id.
    -b, --bbox=<minx,miny,maxx,maxy[,srid]>
                              Bounding box to use as spatial filter.
        --bbox-mode=<mode>     Bounding box filter mode: overlaps, within
                                (default: overlaps).
        --count=<count>        Maximum number of top-level features to import.
        --start-index=<index>  Index within the input set to import from.
        --no-appearance        Do not import appearance information.
  Database connection options:
    -T, --db-type=<database>   Database type: postgresql, oracle (default:
                                postgresql).
    -H, --db-host=<host>       Name of the host on which the 3DCityDB is running.
    -P, --db-port=<port>       Port of the 3DCityDB server (default: 5432 | 1521).
    -d, --db-name=<name>       Name of the 3DCityDB database to connect to.
    -S, --db-schema=<schema>   Schema to use when connecting to the 3DCityDB
                                (default: citydb | username).
    -u, --db-username=<name>   Username to use when connecting to the 3DCityDB.
    -p, --db-password[=<password>]
                              Password to use when connecting to the 3DCityDB
                                (leave empty to be prompted).
```

### Export

```text
  Usage: impexp export [-hV] [-c=<file>] [--log-file=<file>]
                      [--log-level=<level>] -o=<file>
                      [--output-encoding=<encoding>] [--pid-file=<file>]
                      [--worker-threads=<threads[,max]>] [[[-t=<[prefix:]name>[,<
                      [prefix:]name>...]]... [--namespace=<prefix=name>[,
                      <prefix=name>...]]...] [-i=<id>[,<id>...] [-i=<id>[,
                      <id>...]]...] [--db-id=<id>[,<id>...] [--db-id=<id>[,
                      <id>...]]...] [-b=<minx,miny,maxx,maxy[,srid]>
                      [--bbox-mode=<mode>] [--bbox-tiling=<rows,columns>]]
                      [[--count=<count>] [--start-index=<index>]] [-l=<0..4>[,
                      <0..4>...] [-l=<0..4>[,<0..4>...]]... [--lod-mode=<mode>]
                      [--lod-search-depth=<0..n|all>]] [[--no-appearance] |
                      -a=<theme>[,<theme>...] [-a=<theme>[,<theme>...]]...]
                      [-s=<select>] [-q=<xml>]] [[-T=<database>] -H=<host>
                      [-P=<port>] -d=<name> [-S=<schema>] -u=<name> [-p
                      [=<password>]]] [@<filename>...]
  Exports data in CityGML format.
        [@<filename>...]       One or more argument files containing options.
    -o, --output=<file>        Name of the output file.
        --output-encoding=<encoding>
                              Encoding used for the output file (default: UTF-8).
        --worker-threads=<threads[,max]>
                              Number of worker threads to use.
    -h, --help                 Show this help message and exit.
    -V, --version              Print version information and exit.
    -c, --config=<file>        Use configuration from this file.
        --log-level=<level>    Log level: error, warn, info, debug (default:
                                info).
        --log-file=<file>      Write log messages to this file.
        --pid-file=<file>      Create a file containing the current process ID.
  Query and filter options:
    -t, --type-name=<[prefix:]name>[,<[prefix:]name>...]
                              Names of the top-level features to process.
        --namespace=<prefix=name>[,<prefix=name>...]
                              Prefix-to-namespace mappings.
    -i, --gml-id=<id>[,<id>...]
                              Process top-level features with a matching gml:id.
        --db-id=<id>[,<id>...] Process top-level features with a matching
                                database id.
    -b, --bbox=<minx,miny,maxx,maxy[,srid]>
                              Bounding box to use as spatial filter.
        --bbox-mode=<mode>     Bounding box filter mode: overlaps, within
                                (default: overlaps).
        --bbox-tiling=<rows,columns>
                              Tile the bounding box into a rows x columns grid.
        --count=<count>        Maximum number of top-level features to process.
        --start-index=<index>  Index within the result set to process top-level
                                features from.
    -l, --lod=<0..4>[,<0..4>...]
                              LoD representations to export.
        --lod-mode=<mode>      LoD filter mode: or, and, minimum, maximum
                                (default: or).
        --lod-search-depth=<0..n|all>
                              Levels of sub-features to search for matching LoDs
                                (default: 1).
        --no-appearance        Do not export appearance information.
    -a, --appearance-theme=<theme>[,<theme>...]
                              Only export appearances with a matching theme. Use
                                'none' for the null theme.
    -s, --sql-select=<select>  SQL select statement to use as filter.
    -q, --xml-query=<xml>      XML query expression to use as database query.
  Database connection options:
    -T, --db-type=<database>   Database type: postgresql, oracle (default:
                                postgresql).
    -H, --db-host=<host>       Name of the host on which the 3DCityDB is running.
    -P, --db-port=<port>       Port of the 3DCityDB server (default: 5432 | 1521).
    -d, --db-name=<name>       Name of the 3DCityDB database to connect to.
    -S, --db-schema=<schema>   Schema to use when connecting to the 3DCityDB
                                (default: citydb | username).
    -u, --db-username=<name>   Username to use when connecting to the 3DCityDB.
    -p, --db-password[=<password>]
                              Password to use when connecting to the 3DCityDB
                                (leave empty to be prompted).
```

### Visualization export (kml, collada, glTF)

```text
  Usage: impexp export-vis [-hjVz] [-c=<file>] [--log-file=<file>]
                         [--log-level=<level>] -o=<file> [--pid-file=<file>]
                         [--worker-threads=<threads[,max]>] [-D=<mode[=pixels]>
                         [,<mode[=pixels]>...] [-D=<mode[=pixels]>[,<mode
                         [=pixels]>...]]... -l=<0..4 | halod> [-a=<theme>]]
                         [[[-t=<[prefix:]name>[,<[prefix:]name>...]]...
                         [--namespace=<prefix=name>[,<prefix=name>...]]...]
                         [-i=<id>[,<id>...] [-i=<id>[,<id>...]]...] [-b=<minx,
                         miny,maxx,maxy[,srid]> [-g=<rows,columns | auto>]]]
                         [[-s] [--no-surface-normals] [-C] [-x=<mode>]
                         [--texture-atlas-pot]] [-G [--gltf-version=<version>]
                         [--gltf-converter=<file>] [--gltf-embed-textures]
                         [--gltf-binary] [--gltf-draco-compression] [-r]]
                         [[-A=<mode>] [-O=<number|globe|generic>]
                         [--google-elevation-api=<api-key>]
                         [--transform-height]] [[-T=<database>] -H=<host>
                         [-P=<port>] -d=<name> [-S=<schema>] -u=<name> [-p
                         [=<password>]]] [@<filename>...]
Exports data in KML/COLLADA/glTF format for visualization.
      [@<filename>...]       One or more argument files containing options.
  -o, --output=<file>        Name of the master KML output file.
  -z, --kmz                  Compress KML/COLLADA output and save as KMZ.
  -j, --json-metadata        Write JSON metadata file.
      --worker-threads=<threads[,max]>
                             Number of worker threads to use.
  -h, --help                 Show this help message and exit.
  -V, --version              Print version information and exit.
  -c, --config=<file>        Use configuration from this file.
      --log-level=<level>    Log level: error, warn, info, debug (default:
                               info).
      --log-file=<file>      Write log messages to this file.
      --pid-file=<file>      Create a file containing the current process ID.
Display options:
  -D, --display-mode=<mode[=pixels]>[,<mode[=pixels]>...]
                             Display mode: collada, geometry, extruded,
                               footprint. Optionally specify the visibility in
                               terms of screen pixels (default: 0).
  -l, --lod=<0..4 | halod>   LoD to export from.
  -a, --appearance-theme=<theme>
                             Appearance theme to use for COLLADA/glTF exports.
                               Use 'none' for the null theme.
Query and filter options:
  -t, --type-name=<[prefix:]name>[,<[prefix:]name>...]
                             Names of the top-level features to process.
      --namespace=<prefix=name>[,<prefix=name>...]
                             Prefix-to-namespace mappings.
  -i, --gml-id=<id>[,<id>...]
                             Process top-level features with a matching gml:id.
  -b, --bbox=<minx,miny,maxx,maxy[,srid]>
                             Bounding box to use as spatial filter.
  -g, --bbox-tiling=<rows,columns | auto>
                             Tile the bounding box into a rows x columns grid
                               or automatically.
COLLADA/glTF rendering options:
  -s, --double-sided         Force all surfaces to be double sided.
      --no-surface-normals   Do not generate surface normals.
  -C, --crop-textures        Crop texture images.
  -x, --texture-atlas=<mode> Texture atlas mode: none, basic, tpim,
                               tpim_wo_rotation (default: basic).
      --texture-atlas-pot    Texture atlases must be power-of-two sized.
glTF export options:
  -G, --gltf                 Convert COLLADA output to glTF.
      --gltf-version=<version>
                             glTF version: 1.0, 2.0 (default: 2.0).
      --gltf-converter=<file>
                             Path to the COLLADA2GLTF converter executable.
      --gltf-embed-textures  Embed textures in glTF files.
      --gltf-binary          Output binary glTF.
      --gltf-draco-compression
                             Output meshes using Draco compression (requires
                               glTF version 2.0).
  -r, --remove-collada       Only keep glTF and remove the COLLADA output.
Elevation options:
  -A, --altitude-mode=<mode> Altitude mode: absolute, relative, clamp (default:
                               absolute).
  -O, --altitude-offset=<number|globe|generic>
                             Apply offset to height values. Provide a <number>
                               as constant offset, <globe> for zero elevation
                               or <generic> to use the generic attribute
                               GE_LoDn_zOffset as per-feature offset.
      --google-elevation-api=<api-key>
                             Query the Google elevation API when no
                               GE_LoDn_zOffset attribute is available. Requires
                               an API key.
      --transform-height     Transform height to WGS84 ellipsoid height.
Database connection options:
  -T, --db-type=<database>   Database type: postgresql, oracle (default:
                               postgresql).
  -H, --db-host=<host>       Name of the host on which the 3DCityDB is running.
  -P, --db-port=<port>       Port of the 3DCityDB server (default: 5432 | 1521).
  -d, --db-name=<name>       Name of the 3DCityDB database to connect to.
  -S, --db-schema=<schema>   Schema to use when connecting to the 3DCityDB
                               (default: citydb | username).
  -u, --db-username=<name>   Username to use when connecting to the 3DCityDB.
  -p, --db-password[=<password>]
                             Password to use when connecting to the 3DCityDB
                               (leave empty to be prompted).
```

### Delete

```text
  Usage: impexp delete [-hV] [-c=<file>] [--log-file=<file>]
                      [--log-level=<level>] [-m=<mode>] [--pid-file=<file>]
                      [[[-t=<[prefix:]name>[,<[prefix:]name>...]]...
                      [--namespace=<prefix=name>[,<prefix=name>...]]...] [-i=<id>
                      [,<id>...] [-i=<id>[,<id>...]]...] [--db-id=<id>[,<id>...]
                      [--db-id=<id>[,<id>...]]...] [-b=<minx,miny,maxx,maxy[,
                      srid]> [--bbox-mode=<mode>]] [[--count=<count>]
                      [--start-index=<index>]] [-s=<select>] [-q=<xml>]]
                      [-f=<file> [--delete-list-encoding=<encoding>] [-n=<name>]
                      [-I=<index>] [-C=<type>] [-D=<char>] [--[no-]header]
                      [--quote=<char>] [--comment-start=<marker>]]
                      [[-T=<database>] -H=<host> [-P=<port>] -d=<name>
                      [-S=<schema>] -u=<name> [-p[=<password>]]] [@<filename>...]
  Deletes top-level city objects from the database.
        [@<filename>...]       One or more argument files containing options.
    -m, --delete-mode=<mode>   Delete mode: delete, terminate (default: delete).
    -h, --help                 Show this help message and exit.
    -V, --version              Print version information and exit.
    -c, --config=<file>        Use configuration from this file.
        --log-level=<level>    Log level: error, warn, info, debug (default:
                                info).
        --log-file=<file>      Write log messages to this file.
        --pid-file=<file>      Create a file containing the current process ID.
  Query and filter options:
    -t, --type-name=<[prefix:]name>[,<[prefix:]name>...]
                              Names of the top-level features to process.
        --namespace=<prefix=name>[,<prefix=name>...]
                              Prefix-to-namespace mappings.
    -i, --gml-id=<id>[,<id>...]
                              Process top-level features with a matching gml:id.
        --db-id=<id>[,<id>...] Process top-level features with a matching
                                database id.
    -b, --bbox=<minx,miny,maxx,maxy[,srid]>
                              Bounding box to use as spatial filter.
        --bbox-mode=<mode>     Bounding box filter mode: overlaps, within
                                (default: overlaps).
        --count=<count>        Maximum number of top-level features to process.
        --start-index=<index>  Index within the result set to process top-level
                                features from.
    -s, --sql-select=<select>  SQL select statement to use as filter.
    -q, --xml-query=<xml>      XML query expression to use as database query.
  Delete list options:
    -f, --delete-list=<file>   Name of the CSV file containing the delete list.
        --delete-list-encoding=<encoding>
                              Encoding used for the CSV file (default: UTF-8).
    -n, --id-column-name=<name>
                              Name of the id column.
    -I, --id-column-index=<index>
                              Index of the id column (default: 1).
    -C, --id-column-type=<type>
                              Type of id column value: gml, db (default: gml).
    -D, --delimiter=<char>     Delimiter to use for splitting lines (default: ,).
        --[no-]header          CSV file uses a header row (default: true).
        --quote=<char>         Character used as quote (default: ").
        --comment-start=<marker>
                              Marker used to start a line comment (default: #).
  Database connection options:
    -T, --db-type=<database>   Database type: postgresql, oracle (default:
                                postgresql).
    -H, --db-host=<host>       Name of the host on which the 3DCityDB is running.
    -P, --db-port=<port>       Port of the 3DCityDB server (default: 5432 | 1521).
    -d, --db-name=<name>       Name of the 3DCityDB database to connect to.
    -S, --db-schema=<schema>   Schema to use when connecting to the 3DCityDB
                                (default: citydb | username).
    -u, --db-username=<name>   Username to use when connecting to the 3DCityDB.
    -p, --db-password[=<password>]
                              Password to use when connecting to the 3DCityDB
                                (leave empty to be prompted).
```

### Validate

```text
  Usage: impexp validate [-hV] [-c=<file>] [--log-file=<file>]
                        [--log-level=<level>] [--pid-file=<file>]
                        [@<filename>...] <file>...
  Validates input files against their schemas.
        [@<filename>...]      One or more argument files containing options.
        <file>...             Files or directories to validate (glob patterns
                                allowed).
    -h, --help                Show this help message and exit.
    -V, --version             Print version information and exit.
    -c, --config=<file>       Use configuration from this file.
        --log-level=<level>   Log level: error, warn, info, debug (default: info).
        --log-file=<file>     Write log messages to this file.
        --pid-file=<file>     Create a file containing the current process ID.
```

### GUI

```text
  Usage: impexp gui [-hV] [--no-splash] [-c=<file>] [--log-file=<file>]
                    [--log-level=<level>] [--pid-file=<file>] [@<filename>...]
  Starts the graphical user interface.
        [@<filename>...]      One or more argument files containing options.
        --no-splash           Hide the splash screen during startup.
    -h, --help                Show this help message and exit.
    -V, --version             Print version information and exit.
    -c, --config=<file>       Use configuration from this file.
        --log-level=<level>   Log level: error, warn, info, debug (default: info).
        --log-file=<file>     Write log messages to this file.
        --pid-file=<file>     Create a file containing the current process ID.
```
