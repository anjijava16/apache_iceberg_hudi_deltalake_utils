i'm trying to write simple data into the table by Apache Iceberg 0.9.1, but error messages show. I want to CRUD data by Hadoop directly. i create a hadooptable , and try to read from the table. after that i try to write data into the table . i prepare a json file including one line. my code have read the json object, and arrange the order of the data, but the final step writing data is always error. i've changed some version of dependency packages , but another error messages are show. Are there something wrong on version of packages. Please help me.

this is my source code:


public class IcebergTest {

    public static void main(String[] args) {
        testWithoutCatalog();
        readDataWithouCatalog();
        writeDataWithoutCatalog();

    }

    public static void testWithoutCatalog() {

        Schema bookSchema = new Schema(optional(1, "title", Types.StringType.get()),
                optional(2, "price", Types.LongType.get()), 
                optional(3, "author", Types.StringType.get()),               
                optional(4, "genre", Types.StringType.get()));
        PartitionSpec bookspec = PartitionSpec.builderFor(bookSchema).identity("title").build();

        Configuration conf = new Configuration();
        
        String warehousePath = "hdfs://hadoop01:9000/warehouse_path/xgfying/books3";

        HadoopTables tables = new HadoopTables(conf);
        Table table = tables.create(bookSchema, bookspec, warehousePath);
    }

    public static void readDataWithouCatalog(){
        .......
    }

    public static void writeDataWithoutCatalog(){
        SparkSession spark = SparkSession.builder().master("local[2]").getOrCreate();
        Dataset<Row> df = spark.read().json("src/test/data/books3.json");       
        System.out.println(" this is the writing data : "+df.select("title","price","author","genre")
                                                            .first().toString());
        df.select("title","price","author","genre")
          .write().format("iceberg").mode("append")
          .save("hdfs://hadoop01:9000/warehouse_path/xgfying/books3");
        // System.out.println(df.write().format("iceberg").mode("append").toString());
    }

}
