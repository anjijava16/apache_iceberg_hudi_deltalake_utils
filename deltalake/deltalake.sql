# Delta Lake : 
https://github.com/aravinthsci/Spark_Delta_Lake
https://docs.delta.io/latest/delta-utility.html
https://tinyurl.com/cloud-data-platform


Delta Lake is an open source storage layer that brings reliability to data lakes. 
Delta Lake provides ACID transactions, scalable metadata handling, and unifies streaming and batch data processing. Delta Lake runs on top of your existing data lake and is fully compatible with Apache Spark APIs.

Plays an intermediary service between Spark and Storage systems Insteaad of directly interacting with the storage layer
your programs talk to the delta lake for reading and wrtiting your data.

# Delta Lake write 

spark.range(100).repartition(1).write.mode("overwrite").format("delta").csv("C:/output/csv/delta/two")

scala.util.Try(spark.range(100).repartition(1).map{i =>
     if(i>100){
      Thread.sleep(2000)
       throw new RuntimeException("OOPS")
      }
      i
     }.write.mode("overwrite").format("delta").csv("C:/output/csv/delta/two") )
	 
# Read 
spark.range(100).select($"id".as("id")).repartition(1).write.format("delta").mode("overwrite").save("C:/output/csv/delta/two")
val df = spark.read.format("delta").load("C:/output/csv/delta/two")
df.count


scala.util.Try(spark.range(50).repartition(1).map{i =>
     if(i>100){
      Thread.sleep(2000)
       throw new RuntimeException("OOPS")
      }
      i
     }.select($"value".as("id")).write.format("delta").mode("overwrite").save("C:/output/csv/delta/two") )
	 
val df = spark.read.format("delta").load("C:/output/csv/delta/two")
df.count


df1.write.format("delta").mode("overwrite").save("/tmp/starts")


import io.delta.tables._
val dt=DeltaTable.forPath(spark,"C:/output/csv/delta/two")

dt.toDF.show()

dt.delete("FName=='Salaman')
dt.toDF.show()



import io.delta.tables._
val dt=DeltaTable.forPath(spark,"C:/output/csv/delta/two")
dt.delete("id=='1'")

#Note
The dataframe returned automically reads the most recent snapshot of the table for any query ; you never to run REFRESH table 
Delta Lake automiclly uses partitions to read the minimum amount of data when there are applicatable predicates in the query 


Inital Load ===>> Transform ===> Delta Table ===>> 


Merge ===> Transform ====. Increment load 



// Write as Delta 
val df=spark.read.format("csv").option("header","true").schema("FName STRING,LName STRING,Phone STRING, Age DOUBLE").load("C:/output/input/")
			
val df1=df.select($"FName",$"LName",
                 $"Phone" ,
                 $"Age",(when ($"Age" > 50,"old").otherwise("Young")).alias("AgeGroup"))

df1.write.format("delta").mode("overwrite").save("C:/output/delta/starts")
				 
				 
//Read Delta 
import io.delta.tables._
val dt=DeltaTable.forPath(spark,"C:/output/delta/starts")


dt.history.show(false)

+-------+-----------------------+------+--------+---------+--------------------------------------+----+--------+---------+-----------+--------------+-------------+
|version|timestamp              |userId|userName|operation|operationParameters                   |job |notebook|clusterId|readVersion|isolationLevel|isBlindAppend|
+-------+-----------------------+------+--------+---------+--------------------------------------+----+--------+---------+-----------+--------------+-------------+
|0      |2020-04-15 12:46:10.551|null  |null    |WRITE    |[mode -> Overwrite, partitionBy -> []]|null|null    |null     |null       |null          |false        |
+-------+-----------------------+------+--------+---------+--------------------------------------+----+--------+---------+-----------+--------------+-------------+



## Read based on version 
val df=spark.read.format("delta").option("versionAsOf",0).load("C:/output/delta/starts");
spark.read.format("delta").option("versionAsOf",1).load("C:/output/delta/starts")

spark.read.format("delta").option("timestampAsOf","2019-09-22 01:00:23.934").load("C:/output/delta/starts")



How Streaming dataframes differs:
   More restrive operations  
       Distrinct
	   Joins
	   Aggregations
	        Must be after joins 
			
Recovery is done through Checkpoing
   Chekoing uses write ahead logs
   Stores running aggregates and progress
   Must be a HDFS comptiable FS 


Structured Streaming + Data Warehousing 

i.  Importance of watermarking
ii. Managing late data 
iii. Using foreachBatch

Works using a transaction logs
  Transaction log tracs state
  Files will not be deleted during read
  
  
  
  
# Delta Lake --File Management :
  
  # Cleaning up 
   Delta provides VACUUM commands
   VACUUM can be run with retention period
     Default 7 days retention perid 
	 VACUUM with low retention period can corrupt active writers
     VACUUM does not get logged 	 
  
