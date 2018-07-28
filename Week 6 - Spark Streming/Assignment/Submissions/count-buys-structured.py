from pyspark.sql import SparkSession
from pyspark.sql.functions import explode
from pyspark.sql.functions import split
from pyspark.sql.types import StructType, TimestampType, IntegerType, StringType, FloatType

spark = SparkSession.builder.appName("SparkStructuredStreamingCountBuys").getOrCreate()

buyCountSchema = StructType().add("time", TimestampType()) \
               .add("orderId", IntegerType()) \
               .add("clientId", IntegerType()) \
               .add("symbol", StringType()) \
               .add("numberOfStocks", IntegerType()) \
               .add("price", FloatType()) \
               .add("buy", StringType())

data = spark.readStream.schema(buyCountSchema).csv("file:///home/kbhandarkar/PythonProjects/Assignment6/Problem4/input")

buys = data.groupBy("buy").count()

query = buys.writeStream.outputMode("complete").format("console").start()

query.awaitTermination()
