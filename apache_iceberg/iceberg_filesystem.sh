welcome@Anjaiahs-MacBook-Pro ~ % hadoop fs -ls hdfs://localhost:9000/
2022-08-14 00:32:15,856 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Found 6 items
drwxr-xr-x   - welcome supergroup          0 2022-08-13 23:23 hdfs://localhost:9000/Users
drwxr-xr-x   - welcome supergroup          0 2022-08-14 00:23 hdfs://localhost:9000/test
drwxr-xr-x   - welcome supergroup          0 2022-08-01 14:32 hdfs://localhost:9000/tmp
drwxr-xr-x   - welcome supergroup          0 2022-08-02 00:04 hdfs://localhost:9000/user
drwxr-xr-x   - welcome supergroup          0 2022-07-31 18:02 hdfs://localhost:9000/welcome
-rw-r--r--   1 welcome supergroup         19 2022-07-31 17:58 hdfs://localhost:9000/welcome.sh
welcome@Anjaiahs-MacBook-Pro ~ % Add jar /Users/welcome/Desktop/hadoop/apache-hive-3.1.2-bin/lib/iceberg-hive-runtime-0.10.0.jar;
zsh: command not found: Add
welcome@Anjaiahs-MacBook-Pro ~ % hadoop fs -ls /Users/welcome/Desktop/data/iceberg/warehouse/db/table/
2022-08-14 09:20:38,496 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Found 2 items
drwxr-xr-x   - welcome supergroup          0 2022-08-13 23:27 /Users/welcome/Desktop/data/iceberg/warehouse/db/table/data
drwxr-xr-x   - welcome supergroup          0 2022-08-13 23:27 /Users/welcome/Desktop/data/iceberg/warehouse/db/table/metadata
welcome@Anjaiahs-MacBook-Pro ~ % 

spark-sql> CREATE TABLE iceberg_table (id bigint, data string, category string)
         >   PARTITIONED BY (category, bucket(16, id));
Error in query: Table iceberg_table already exists
spark-sql> drop table iceberg_table
         > ;
Time taken: 0.177 seconds
spark-sql> CREATE TABLE iceberg_table (
         >   id int,
         >   data string,
         >   category string) 
         > PARTITIONED BY (category, bucket(16,id))
         > TBLPROPERTIES ( 'table_type' = 'ICEBERG' );
Time taken: 1.206 seconds
spark-sql> describe iceberg_table;
id                  	int                 	                    
data                	string              	                    
category            	string              	                    
                    	                    	                    
# Partitioning      	                    	                    
Part 0              	category            	                    
Part 1              	bucket(16, id)      	                    
Time taken: 0.268 seconds, Fetched 7 row(s)
spark-sql> show create table iceberge_table;
Error in query: Table or permanent view not found: iceberge_table; line 1 pos 18;
'ShowCreateTable false, [createtab_stmt#206]
+- 'UnresolvedTableOrView [iceberge_table], SHOW CREATE TABLE, false

spark-sql> describe formatted iceberg_table;
id                  	int                 	                    
data                	string              	                    
category            	string              	                    
                    	                    	                    
# Partitioning      	                    	                    
Part 0              	category            	                    
Part 1              	bucket(16, id)      	                    
                    	                    	                    
# Metadata Columns  	                    	                    
_spec_id            	int                 	                    
_partition          	struct<category:string,id_bucket:int>	                    
_file               	string              	                    
_pos                	bigint              	                    
_deleted            	boolean             	                    
                    	                    	                    
# Detailed Table Information	                    	                    
Name                	local.iceberg_table 	                    
Location            	/Users/welcome/Desktop/data/iceberg/warehouse/iceberg_table	                    
Provider            	iceberg             	                    
Owner               	welcome             	                    
Table Properties    	[current-snapshot-id=none,format=iceberg/parquet,format-version=1,table_type=ICEBERG]	                    
Time taken: 0.263 seconds, Fetched 21 row(s)
spark-sql> CREATE TABLE iceberg_tbl_nopartion (id bigint, data string, category string)
         > TBLPROPERTIES ( 'table_type' = 'ICEBERG' );
Time taken: 0.715 seconds
spark-sql> insert into iceberg_tbl_nopartion(id,date,category) values(10,'dad','fs');
Error in query: Cannot resolve column name date; line 1 pos 0
spark-sql> insert into iceberg_tbl_nopartion(id,data,category) values(10,'dad','fs');
Time taken: 2.552 seconds
spark-sql> insert into iceberg_tbl_nopartion(id,data,category) values(11,'dad','fs');
Time taken: 2.088 seconds
spark-sql> insert into iceberg_tbl_nopartion(id,data,category) values(11,'dad','fs'),(13,'mom','amma');
Time taken: 2.004 seconds
spark-sql> select * from iceberg_tbl_nopartion;
11	dad	fs
11	dad	fs
10	dad	fs
13	mom	amma
Time taken: 0.554 seconds, Fetched 4 row(s)
spark-sql> describe formatted iceberg_table;
id                  	int                 	                    
data                	string              	                    
category            	string              	                    
                    	                    	                    
# Partitioning      	                    	                    
Part 0              	category            	                    
Part 1              	bucket(16, id)      	                    
                    	                    	                    
# Metadata Columns  	                    	                    
_spec_id            	int                 	                    
_partition          	struct<category:string,id_bucket:int>	                    
_file               	string              	                    
_pos                	bigint              	                    
_deleted            	boolean             	                    
                    	                    	                    
# Detailed Table Information	                    	                    
Name                	local.iceberg_table 	                    
Location            	/Users/welcome/Desktop/data/iceberg/warehouse/iceberg_table	                    
Provider            	iceberg             	                    
Owner               	welcome             	                    
Table Properties    	[current-snapshot-id=none,format=iceberg/parquet,format-version=1,table_type=ICEBERG]	                    
Time taken: 0.144 seconds, Fetched 21 row(s)
spark-sql> 


