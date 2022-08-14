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


