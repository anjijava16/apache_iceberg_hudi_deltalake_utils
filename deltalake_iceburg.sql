


docker run -it alexmerced/spark33playground

export AWS_ACCESS_KEY_ID=xxxxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxxxxx
export AWS_REGION=us-east-1
export ICEBERG_WAREHOUSE=s3a://…

spark-sql --packages io.delta:delta-core_2.12:2.1.1,org.apache.hadoop:hadoop-aws:3.3.1,org.apache.iceberg:iceberg-spark-runtime-3.3_2.12:1.0.0,software.amazon.awssdk:bundle:2.17.178,software.amazon.awssdk:url-connection-client:2.17.178 \
--conf spark.sql.catalog.spark_catalog=org.apache.spark.sql.delta.catalog.DeltaCatalog \
--conf "spark.sql.extensions=io.delta.sql.DeltaSparkSessionExtension,org.apache.iceberg.spark.extensions.IcebergSparkSessionExtensions" \
--conf spark.sql.catalog.iceberg=org.apache.iceberg.spark.SparkCatalog \
--conf spark.sql.catalog.arctic.io-impl=org.apache.iceberg.aws.s3.S3FileIO \
--conf spark.sql.catalog.iceberg.type=hadoop \
--conf spark.sql.catalog.iceberg.warehouse=$ICEBERG_WAREHOUSE \
--conf spark.hadoop.fs.s3a.access.key=$AWS_ACCESS_KEY \
--conf spark.hadoop.fs.s3a.secret.key=$AWS_SECRET_ACCESS_KEY

 Let’s create a Delta Lake table.

CREATE TABLE default.example_table2 (name string) USING DELTA LOCATION 's3a://am-demo-cloud/nov2022/delta/112122/example_table2'
CREATE TABLE default.example_table2 (name string) USING DELTA LOCATION 's3a://am-demo-cloud/nov2022/delta/112122/example_table2'
5. Let’s add some records to our Delta Lake table.

INSERT into default.example_table2 (name) VALUES ('Alex Merced'),('Dipankar Mizumdar'), ('Jason Hughes');
INSERT into default.example_table2 (name) VALUES ('Alex Merced'),('Dipankar Mizumdar'), ('Jason Hughes');

6. Check your S3 dashboard to confirm the table was written.

7. Let’s then use a CTAS to convert that Delta Lake table over to Iceberg.

CREATE TABLE iceberg.example_table2 USING iceberg AS SELECT * FROM default.example_table2;
CREATE TABLE iceberg.example_table2 USING iceberg AS SELECT * FROM default.example_table2;



spark-sql> desc formatted  iceberg.example_table2;
name                	string

# Partitioning
Not partitioned

# Metadata Columns
_spec_id            	int
_partition          	struct<>
_file               	string
_pos                	bigint
_deleted            	boolean

# Detailed Table Information
Name                	iceberg.example_table2
Location            	s3a://data-iwinner-raw/example_table2
Provider            	iceberg
Owner               	docker
Table Properties    	[current-snapshot-id=3869036055277052095,format=iceberg/parquet,format-version=1]
Time taken: 1.031 seconds, Fetched 18 row(s)
spark-sql> desc formatted  default.example_table2;
name                	string

# Partitioning
Not partitioned

# Detailed Table Information
Name                	default.example_table2
Location            	s3a://data-iwinner-raw/nov2022/delta/112122/example_table2
Provider            	delta
Owner               	docker
External            	true
Table Properties    	[delta.minReaderVersion=1,delta.minWriterVersion=2]
Time taken: 1.647 seconds, Fetched 12 row(s)
