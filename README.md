# Comapare apache_iceberg_apache_hudi_deltalake
1. https://www.youtube.com/watch?v=kqkmcZoPXao

# apache_iceberg_utils

- Data Storage
- Ingestion
- Data Abstraction
- Orchestration
- Data Quality
- Access Control
- Metrics
- Business Intelligence


## Apache Iceberg

### Iceberg medium
1. https://medium.com/@vutrinh274/i-spent-4-hours-learning-apache-iceberg-heres-what-i-found-9750b0d70d84

2. https://www.dremio.com/blog/a-hands-on-look-at-the-structure-of-an-apache-iceberg-table/

3. https://medium.com/starschema-blog/open-table-formats-for-efficient-data-processing-delta-lake-vs-iceberg-vs-hudi-b1107141e9a6



# HUDI
1. https://www.linkedin.com/pulse/transactional-data-lake-using-apache-hudi-ravi-shekhram%3FtrackingId=hWhbz1YwOmrLGpKDPshe%252FQ%253D%253D/?trackingId=hWhbz1YwOmrLGpKDPshe%2FQ%3D%3D




# Spark EKS
1. https://awslabs.github.io/data-on-eks/docs/streaming-platforms/kafka
2. https://github.com/awslabs/data-on-eks
3. 


Apache Iceberg is a new table format for storing large, slow-moving tabular data. It is designed to improve on the de-facto standard table layout built into Hive, Trino, and Spark.

Background and documentation is available at https://iceberg.apache.org


# Spark with Iceberg
1. https://iceberg.apache.org/#getting-started/


# Hive with Iceberg
1. https://iceberg.apache.org/#hive/

----------------------
# Apache Hudi

Apache Hudi is an open-source transactional data lake framework that greatly simplifies incremental data processing and data pipeline development. It does this by providing transaction support and record-level insert, update, and delete capabilities on data lakes on Amazon Simple Storage Service (Amazon S3) or Apache HDFS. Apache Hudi is integrated with open-source big data analytics frameworks, such as Apache Spark, Apache Hive, Presto, and Trino. Furthermore, Apache Hudi lets you maintain data in Amazon S3 or Apache HDFS in open formats such as Apache Parquet and Apache Avro.

Common use cases where we see customers use Apache Hudi are as follows:

To simplify data ingestion pipelines that deal with late-arriving or updated records from streaming and batch data sources.
To ingest data using Change Data Capture (CDC) from transactional systems.
To implement data-deletion pipelines to comply with data privacy regulations, e.g., GDPR (General Data Protection Regulation) compliance. Conforming to GDPR is a necessity of today’s modern data architectures, which includes the features of “right to erasure” or “right to be forgotten”, and it can be implemented using Apache Hudi capabilities in place of deletes and updates.

# Reference Links
1. https://aws.amazon.com/blogs/big-data/new-features-from-apache-hudi-0-9-0-on-amazon-emr/
2. https://noise.getoto.net/2022/04/04/new-features-from-apache-hudi-0-9-0-on-amazon-emr/

------------------------------------------------

