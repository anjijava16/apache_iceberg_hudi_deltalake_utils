##################################################################
##################################################################
# Delta Table
##################################################################
##################################################################


pyspark \
  --packages io.delta:delta-core_2.12:2.1.0 \
  --conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension" \
  --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog"



  from pyspark.sql.types import *

# initialize the bucket
table_name = "people"
local_base_path = "/tmp/delta-dataset"

records = [
   (1, 'John', 25, 'NYC', '2023-09-28 00:00:00'),
   (2, 'Emily', 30, 'SFO', '2023-09-28 00:00:00'),
   (3, 'Michael', 35, 'ORD', '2023-09-28 00:00:00'),
   (4, 'Andrew', 40, 'NYC', '2023-10-28 00:00:00'),
   (5, 'Bob', 28, 'SEA', '2023-09-23 00:00:00'),
   (6, 'Charlie', 31, 'DFW', '2023-08-29 00:00:00')
]

schema = StructType([
   StructField("id", IntegerType(), True),
   StructField("name", StringType(), True),
   StructField("age", IntegerType(), True),
   StructField("city", StringType(), True),
   StructField("create_ts", StringType(), True)
])

df = spark.createDataFrame(records, schema)

(
   df.write
   .format("delta")
   .partitionBy("city")
   .save(f"{local_base_path}/{table_name}")
)

##################################################################
##################################################################
# Hudi Example 
##################################################################
##################################################################

pyspark \
  --packages org.apache.hudi:hudi-spark3.2-bundle_2.12:0.14.0 \
  --conf "spark.serializer=org.apache.spark.serializer.KryoSerializer" \
  --conf "spark.sql.catalog.spark_catalog=org.apache.spark.sql.hudi.catalog.HoodieCatalog" \
  --conf "spark.sql.extensions=org.apache.spark.sql.hudi.HoodieSparkSessionExtension"

from pyspark.sql.types import *

# initialize the bucket
table_name = "people"
local_base_path = "/tmp/hudi-dataset"

records = [
   (1, 'John', 25, 'NYC', '2023-09-28 00:00:00'),
   (2, 'Emily', 30, 'SFO', '2023-09-28 00:00:00'),
   (3, 'Michael', 35, 'ORD', '2023-09-28 00:00:00'),
   (4, 'Andrew', 40, 'NYC', '2023-10-28 00:00:00'),
   (5, 'Bob', 28, 'SEA', '2023-09-23 00:00:00'),
   (6, 'Charlie', 31, 'DFW', '2023-08-29 00:00:00')
]

schema = StructType([
   StructField("id", IntegerType(), True),
   StructField("name", StringType(), True),
   StructField("age", IntegerType(), True),
   StructField("city", StringType(), True),
   StructField("create_ts", StringType(), True)
])

df = spark.createDataFrame(records, schema)

hudi_options = {
   'hoodie.table.name': table_name,
   'hoodie.datasource.write.partitionpath.field': 'city',
   'hoodie.datasource.write.hive_style_partitioning': 'true'
}

(
   df.write
   .format("hudi")
   .options(**hudi_options)
   .save(f"{local_base_path}/{table_name}")
)

##################################################################
##################################################################
# Iceberg Table 
##################################################################
##################################################################

pyspark \
  --packages org.apache.iceberg:iceberg-spark-runtime-3.2_2.12:1.4.1 \
  --conf "spark.sql.extensions=org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions" \
  --conf "spark.sql.catalog.spark_catalog=org.apache.iceberg.spark.SparkSessionCatalog"


from pyspark.sql.types import *

# initialize the bucket
table_name = "people"
local_base_path = "/tmp/iceberg-dataset"

records = [
   (1, 'John', 25, 'NYC', '2023-09-28 00:00:00'),
   (2, 'Emily', 30, 'SFO', '2023-09-28 00:00:00'),
   (3, 'Michael', 35, 'ORD', '2023-09-28 00:00:00'),
   (4, 'Andrew', 40, 'NYC', '2023-10-28 00:00:00'),
   (5, 'Bob', 28, 'SEA', '2023-09-23 00:00:00'),
   (6, 'Charlie', 31, 'DFW', '2023-08-29 00:00:00')
]

schema = StructType([
   StructField("id", IntegerType(), True),
   StructField("name", StringType(), True),
   StructField("age", IntegerType(), True),
   StructField("city", StringType(), True),
   StructField("create_ts", StringType(), True)
])

df = spark.createDataFrame(records, schema)

(
   df.write
   .format("iceberg")
   .partitionBy("city")
   .save(f"{local_base_path}/{table_name}")
)



