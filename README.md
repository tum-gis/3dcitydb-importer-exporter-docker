# 3DCityDB Importer/Exporter Docker

**Warning: This is a pre-release. The image has not jet been tested and this documentation is incomplete and possibly wrong!**

A test image is available here: [tumgis/3dcitydb-importer-exporter](tumgis/3dcitydb-importer-exporter) on DockerCloud.

This repo contains a Dockerfile for the [3D City Database (3DCityDB) Importer/Exporter](https://github.com/3dcitydb/importer-exporter). The images can be used to run the Importer/Exporter CLI and use the in automation processes. To get the 3DCityDB Importer/Exporter images visit the [tumgis/3dcitydb-impexp](https://hub.docker.com/r/tumgis/3dcitydb-impexp/) DockerHub page. Currently, only the Importer/Exporter versions >= `4.0.0` are supported.

To get started immediately go to the [usage section](#usage) section.

> **Note:** The content in this repo is in development stage.
> If you experience any problems or have a suggestion/improvement please let me know by creating an [issue](https://github.com/tum-gis/3dcitydb-importer-exporter-docker/issues) or make a contribution with a [pull request](https://github.com/tum-gis/3dcitydb-docker-postgis/pulls).

## News

* Current build status: **TO BE DONE**


## More 3DCityDB Docker Images

Check out the Docker images for the *3D City Database*, *3D City Database Web Feature Service (WFS)*, and the *3D City Database Web-Map-Client* too:

* [3DCityDB image](https://github.com/tum-gis/3dcitydb-docker-postgis/)
* [3DCityDB Web-Map-Client image](https://github.com/tum-gis/3dcitydb-web-map-docker/)
* [3DCityDB Web Feature Service (WFS) image](https://github.com/tum-gis/3dcitydb-wfs-docker/)

## Usage

1. Create a folder for exchanging data between the Importer/Exporter container and the Docker host, e.g. `/home/myuser/dockershare/`. This folder will be mounted to the container later in the process.

2. Create a 3DCityDB Importer/Exporter configuration file. The easiest way to do this is using the GUI of the Importer/Exporter and safe a config `XML` file to disk using the top menu bar: *Project* -> *Save project as...* . Save the Importer/Exporter config file in the folder you created in step 1, e.g. at `/home/myuser/dockershare/config/config.xml`.

3. If necessary, adapt the configuration in `config.xml`. For instance, you may want to change the database connection used, or change the bahavior of the import/export process you are looking for. Make sure, `<activeConnection>ID</activeConnection>` points to the correct *connection id*.

    ```xml
    <connections>
      <connection id="UUID_a4c93583-6f39-4935-bbb8-da5798e64d66" loginTimeout="60" initialSize="0">
          <description>templateConnection</description>
          <type>PostGIS</type>
          <server>myhost</server>
          <port>5432</port>
          <sid>citydb</sid>
          <user>postgres</user>
          <password>postgres</password>
          <savePassword>false</savePassword>
      </connection>
    </connections>
    <activeConnection>UUID_a4c93583-6f39-4935-bbb8-da5798e64d66</activeConnection>
    ```

    > **Warning:** The entire configuration of the Importer/Exporter is stored in this file, including all saved database profiles possibly containing passwords in plain text.

4. Run the 3DCityDB Importer/Exporter Docker container and mount the  folder you created before. Specify the Importer/Exporter command line switch you want to use with all additional parameters required. The `-shell` switch can be ommitted. Refer to the official [3DCityDB documentation](https://www.3dcitydb.org/3dcitydb/documentation/) for more on the Importer/Exporter CLI options.

    Use the mounted folder to pass the configuration file from step 1 to the application and exchange of import/export 3D city model data between the docker host and the container. 
    
    For instance, use following command to export CityGML data according to the options specified in `config.xml` to `/home/myuser/dockershare/data/out.gml` on the docker host.

    ```txt
    docker run -rm -it --name impexp \
        -v /home/myuser/dockershare/:/share/ \
      tumgis/3dcitydb-importer-exporter \
        -config /share/config/config.xml \
        -export /share/data/out.gml
    ```
