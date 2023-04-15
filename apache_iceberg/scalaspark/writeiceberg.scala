def main(args: Array[String]): Unit = {

  // Configure the parameters for the catalog. 
  val sparkConf = new SparkConf()
  sparkConf.set("spark.sql.extensions", "org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions")
  sparkConf.set("spark.sql.catalog.dlf_catalog", "org.apache.iceberg.spark.SparkCatalog")
  sparkConf.set("spark.sql.catalog.dlf_catalog.catalog-impl", "org.apache.iceberg.aliyun.dlf.DlfCatalog")
  sparkConf.set("spark.sql.catalog.dlf_catalog.io-impl", "org.apache.iceberg.hadoop.HadoopFileIO")
  sparkConf.set("spark.sql.catalog.dlf_catalog.oss.endpoint", "<yourOSSEndpoint>")
  sparkConf.set("spark.sql.catalog.dlf_catalog.warehouse", "<yourOSSWarehousePath>")
  sparkConf.set("spark.sql.catalog.dlf_catalog.access.key.id", "<yourAccessKeyId>")
  sparkConf.set("spark.sql.catalog.dlf_catalog.access.key.secret", "<yourAccessKeySecret>")
  sparkConf.set("spark.sql.catalog.dlf_catalog.dlf.catalog-id", "<yourCatalogId>")
  sparkConf.set("spark.sql.catalog.dlf_catalog.dlf.endpoint", "<yourDLFEndpoint>")
  sparkConf.set("spark.sql.catalog.dlf_catalog.dlf.region-id", "<yourDLFRegionId>")

  val spark = SparkSession
  .builder()
  .config(sparkConf)
  .appName("IcebergReadWriteTest")
  .getOrCreate()

  // Create or replace an Iceberg table in a DataFrame.
  val firstDF = spark.createDataFrame(Seq(
  (1, "a"), (2, "b"), (3, "c")
  )).toDF("id", "data")

  firstDF.writeTo("dlf_catalog.iceberg_db.sample").createOrReplace()

  // Write data from a DataFrame to an Iceberg table.
  val secondDF = spark.createDataFrame(Seq(
  (4, "d"), (5, "e"), (6, "f")
  )).toDF("id", "data")

  secondDF.writeTo("dlf_catalog.iceberg_db.sample").append()

  // Read data from the Iceberg table.
  val icebergTable = spark.table("dlf_catalog.iceberg_db.sample")

  icebergTable.show()
}
