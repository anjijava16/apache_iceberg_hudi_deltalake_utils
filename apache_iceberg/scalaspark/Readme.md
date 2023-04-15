spark-submit \
 --master yarn \
 --deploy-mode cluster \
 --driver-memory 1g \
 --executor-cores 2 \
 --executor-memory 3g \
 --num-executors 1 \
 --class com.aliyun.iceberg.StructuredSinkIceberg \
 iceberg-demos.jar
