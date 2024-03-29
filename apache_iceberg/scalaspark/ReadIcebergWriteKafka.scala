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
    .appName("StructuredSinkIceberg")
    .getOrCreate()

  val checkpointPath = "oss://mybucket/tmp/iceberg_table_checkpoint"
  val bootstrapServers = "192.168.XX.XX:9092"
  val topic = "iceberg_test"

  // Read data from the Kafka cluster.
  val df = spark.readStream
    .format("kafka")
    .option("kafka.bootstrap.servers", bootstrapServers)
    .option("subscribe", topic)
    .load()

  import spark.implicits._
  val resDF = df.selectExpr("CAST(key AS STRING)", "CAST(value AS STRING)")
    .as[(String, String)].toDF("id", "data")

  // Write data to the Iceberg table in streaming mode.
  val query = resDF.writeStream
    .format("iceberg")
    .outputMode("append")
    .trigger(Trigger.ProcessingTime(1, TimeUnit.MINUTES))
    .option("path", "dlf_catalog.iceberg_db.iceberg_table")
    .option("checkpointLocation", checkpointPath)
    .start()

  query.awaitTermination()
}
