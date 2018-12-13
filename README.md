# 3DCityDB Importer Exporter Docker

## Usage

1. Prepare a 3DCityDB Importer/Exporter configuration `XML` file
2. Create a shared folder for exchanging data between the container and the Docker host. Inside your share a folder named `config` is expected, e.g.:

    ```bash
    /home/myuser/dockershare/config
    ```
3. Create a 3DCityDB Importer Exporter configuration file. The easiest way to do this is using the GUI ofthe Importer Exporter and safe a config `XML` file to disk using the top menu bar: *Project* -> *Save project as...* . Save the Importer Exporter config file in the shared folder you created:

    ```txt
    /home/myuser/dockershare/config/config.xml
    ```

    If necessary, adapt the configuration in `config.xml`. For instance, you may want to change the database connection used, or change the export import options. Make sure, `<activeConnection>ID</activeConnection>` points to the correct *connection id*.

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

4. Run the 3DCityDB Importer Exporter Docker container and mount the shared folder you created before. Specify the Importer Exporter command line switch you want to use with all additional parameters required. The `-shell` and `-config` switches can be ommitted.

    ```bash
    docker run -it --name impexp \
        -v D:/docker/impexp:/share \
      tumgis/3dcitydb-importer-exporter -export ./share/data/out.gml
    ```
