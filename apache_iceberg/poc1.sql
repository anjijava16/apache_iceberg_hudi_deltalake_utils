# ===============================
# Database
# ===============================

create database fastapi_db

# ===============================
# CSV table 
# ===============================


CREATE  EXTERNAL TABLE fastapi_db.stage_welcome 
(
  Country string , 
  Age string ,
  Salary string ,
  Purchased string ,
  ts timestamp
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 's3://mmtech-athena/csvdata/'
TBLPROPERTIES ('skip.header.line.count'='1')
;

# ===============================
# SELECT 
# ===============================


select * from fastapi_db.stage_welcome 



# ===============================
# ICEBERG table 
# ===============================


CREATE TABLE iceberg_test 
(
 Country string , 
  Age string ,
  Salary string ,
  Purchased string ,
  ts timestamp
)
LOCATION
    's3://mmtech-athena/icebergdata'
TBLPROPERTIES (
    'table_type'='ICEBERG'
);

show create table fastapi_db.iceberg_test 

DESCRIBE fastapi_db.iceberg_test
DESCRIBE FORMATTED fastapi_db.iceberg_test


# ===============================
# Insert Query 
# ===============================

insert into fastapi_db.iceberg_test (
SELECT Country,Age name,Salary,Purchased,ts FROM fastapi_db.stage_welcome 
)


# ======================================
# Delete query
# =======================================


delete from fastapi_db.iceberg_test where age='44'


# ======================================
# Update Query 
# =======================================

UPDATE   fastapi_db.iceberg_test
SET country='INDIA' 
where age='35';
