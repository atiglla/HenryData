![HenryLogo](https://d31uz8lwfmyn8g.cloudfront.net/Assets/logo-henry-white-lg.png)

# Formatos de Almacenamiento

La elección de un formato correcto puede traducirse en mejoras de performance y reducción de costos.

<img src="../_src/assets/Formatos_Almacenamiento2.jpg"  height="400">

## Factores de elección

Al momento de elegir un formato de almacenamiento, debemos considerar los siguientes puntos:
* ROW vs COLUMN: las consultas serán de tipo SELECT * o agregaciones AVG, SUM, etc
<img src="../_src/assets/RowVsColumn.jpg"  height="250">
* SCHEMA EVOLUTION: que sucede si debemos agregar, eliminar o modificar un campo
<img src="../_src/assets/Schema_Evolution.jpg"  height="250">
* COMPRESSION: equilibrio entre espacio en disco utilizado y tiempo de procesamiento
<img src="../_src/assets/Compression.jpg"  height="250">

[Enlace recomendado](https://luminousmen.com/post/big-data-file-formats)

### CSV

Texto plano delimitado por el carácter de la coma (pueden utilizarse otros separadores).
Generalmente este formato lo utilizan aplicaciones tradicionales para exportar datos hacia otros sistemas.

<img src="../_src/assets/CSV.jpg"  height="250">

### JSON

<img src="../_src/assets/JSON.jpg"  height="250">

### Avro

Almacena los datos en formato binario para reducir el tamaño y mejorar la performance.
La definición de los datos (schema) se almacena en formato JSON.
Es recomendable utilizarlo para consultas de tipo SELECT *.

<img src="../_src/assets/AVRO.jpg"  height="250">

### Parquet

Es un formato de almacenamiento columnar que surge de la colaboración de Twitter y Cloudera.
Los datos se almacenan en formato binario y al final del archivo se agrega la metadata (schema).
Este formato es ideal para agregaciones AVG, SUM, etc.

<img src="../_src/assets/PARQUET.jpg"  height="250">

### Resúmen

<img src="../_src/assets/Resumen.jpg"  height="250">

#### Enlaces de referencia:

* [Parquet] (https://parquet.apache.org/documentation/latest/)
* [Avro] (https://avro.apache.org/docs/current/)
* [JSON] (https://www.json.org/json-es.html)

### Herramientas de compresión de datos de Hadoop

* gzip - org.apache.hadoop.io.compress.GzipCodec
* bzip2 - org.apache.hadoop.io.compress.BZip2Codec
* LZO - com.hadoop.compression.lzo.LzopCodec
* Snappy - org.apache.hadoop.io.compress.SnappyCodec
* Deflate - org.apache.hadoop.io.compress.DeflateCodec

#### Ejemplo de Parquet y Snappy

<img src="../_src/assets/Parquet_Snappy.jpg"  height="250">

## Homework

### Formatos de Almacenamiento en Hive

1) En la sección de archivos, cargar los archivos de la carpeta data y replicar la misma estructura de directorios en HDFS.
2) En la sección de mis documentos, cargar el archivo clase-04.json y luego seleccionar el editor Hive