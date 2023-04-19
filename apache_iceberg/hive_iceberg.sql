hive> add jar /Users/welcome/Downloads/iceberg-hive-runtime-0.12.1.jar
    > ;
Added [/Users/welcome/Downloads/iceberg-hive-runtime-0.12.1.jar] to class path
Added resources: [/Users/welcome/Downloads/iceberg-hive-runtime-0.12.1.jar]
hive> CREATE EXTERNAL TABLE customer (
    >      id bigint,
    >      name string
    > ) PARTITIONED BY (
    >      state string
    > ) STORED BY 'org.apache.iceberg.mr.hive.HiveIcebergStorageHandler'
    > TBLPROPERTIES ('iceberg.catalog'='iceberg'); 
OK
Time taken: 2.765 seconds
hive> show tables;
OK
customer
Time taken: 0.21 seconds, Fetched: 1 row(s)
hive> insert into customer(id,name,state) values(10,'bbb','DE');
Query ID = welcome_20230418222545_11bbacf1-468d-45cb-9fec-580cdd548dc3
Total jobs = 1
Launching Job 1 out of 1
Number of reduce tasks is set to 0 since there's no reduce operator
Job running in-process (local Hadoop)
2023-04-18 22:25:50,382 Stage-2 map = 0%,  reduce = 0%
2023-04-18 22:25:52,408 Stage-2 map = 100%,  reduce = 0%
Ended Job = job_local2021033365_0001
MapReduce Jobs Launched: 
Stage-Stage-2:  HDFS Read: 15732 HDFS Write: 5277 SUCCESS
Total MapReduce CPU Time Spent: 0 msec
OK
Time taken: 9.261 seconds
hive> insert into customer(id,name,state) values(20,'ccc','PA');
Query ID = welcome_20230418222609_aaa043da-c531-44e9-b4bf-6d2b8b58386a
Total jobs = 1
Launching Job 1 out of 1
Number of reduce tasks is set to 0 since there's no reduce operator
Job running in-process (local Hadoop)
2023-04-18 22:26:11,860 Stage-2 map = 100%,  reduce = 0%
Ended Job = job_local1576509509_0002
MapReduce Jobs Launched: 
Stage-Stage-2:  HDFS Read: 50685 HDFS Write: 21378 SUCCESS
Total MapReduce CPU Time Spent: 0 msec
OK
Time taken: 4.663 seconds
hive> insert into customer(id,name,state) values(30,'ddd','NJ');
Query ID = welcome_20230418222643_5f8de587-f4bc-4a54-b06a-0a75e1383158
Total jobs = 1
Launching Job 1 out of 1
Number of reduce tasks is set to 0 since there's no reduce operator
Job running in-process (local Hadoop)
2023-04-18 22:26:46,110 Stage-2 map = 100%,  reduce = 0%
Ended Job = job_local135726044_0003
MapReduce Jobs Launched: 
Stage-Stage-2:  HDFS Read: 100104 HDFS Write: 38519 SUCCESS
Total MapReduce CPU Time Spent: 0 msec
OK
Time taken: 3.612 seconds
hive> show tables;
OK
customer
Time taken: 0.082 seconds, Fetched: 1 row(s)
hive> select * from customer;
OK
30	ddd	NJ
10	bbb	DE
20	ccc	PA
Time taken: 0.382 seconds, Fetched: 3 row(s)
hive> show create table customer;
OK
CREATE EXTERNAL TABLE `customer`(
  `id` bigint COMMENT 'from deserializer', 
  `name` string COMMENT 'from deserializer', 
  `state` string COMMENT 'from deserializer')
ROW FORMAT SERDE 
  'org.apache.iceberg.mr.hive.HiveIcebergSerDe' 
STORED BY 
  'org.apache.iceberg.mr.hive.HiveIcebergStorageHandler' 

LOCATION
  'hdfs://localhost:8020/user/hive/warehouse/customer'
TBLPROPERTIES (
  'bucketing_version'='2', 
  'engine.hive.enabled'='true', 
  'external.table.purge'='TRUE', 
  'iceberg.catalog'='iceberg', 
  'last_modified_by'='welcome', 
  'last_modified_time'='1681871204', 
  'metadata_location'='hdfs://localhost:8020/user/hive/warehouse/customer/metadata/00003-3abb0a99-8bcc-43c6-87d0-1ae8129b8852.metadata.json', 
  'previous_metadata_location'='hdfs://localhost:8020/user/hive/warehouse/customer/metadata/00002-063b09c1-f774-4fae-ae40-4e5732c82181.metadata.json', 
  'table_type'='ICEBERG', 
  'transient_lastDdlTime'='1681871204')
Time taken: 0.299 seconds, Fetched: 22 row(s)
hive> 
zsh: suspended  hive
