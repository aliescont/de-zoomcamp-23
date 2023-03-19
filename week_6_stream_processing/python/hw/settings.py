import pyspark.sql.types as T

INPUT_DATA_PATH = './resources/rides.csv'
INPUT_DATA_FHV_PATH = './resources/fhv_tripdata_2019-01.csv'
INPUT_DATA_GREEN_PATH = './resources/green_tripdata_2019-01.csv'

BOOTSTRAP_SERVERS = 'localhost:9092'

TOPIC_WINDOWED_VENDOR_ID_COUNT = 'vendor_counts_windowed'
TOPIC_WINDOWED_PULOCATIONID_COUNT = 'pulocation_counts_windowed'

PRODUCE_TOPIC_RIDES_CSV = CONSUME_TOPIC_RIDES_CSV = 'rides_csv'
PRODUCE_TOPIC_RIDES_ALL_CSV = CONSUME_TOPIC_RIDES_ALL_CSV = 'rides_all'

RIDE_SCHEMA = T.StructType(
    [T.StructField("vendor_id", T.IntegerType()),
     T.StructField('tpep_pickup_datetime', T.TimestampType()),
     T.StructField('tpep_dropoff_datetime', T.TimestampType()),
     T.StructField("passenger_count", T.IntegerType()),
     T.StructField("trip_distance", T.FloatType()),
     T.StructField("payment_type", T.IntegerType()),
     T.StructField("total_amount", T.FloatType()),
     ])


RIDES_ALL_SCHEMA = T.StructType([
    T.StructField("PULocationID", T.IntegerType(), True),
    T.StructField("DOLocationID", T.IntegerType(), True),
    T.StructField("pickup_datetime", T.TimestampType(), True),
    T.StructField("dropoff_datetime", T.TimestampType(), True),
])


GREEN_SCHEMA = T.StructType([
    T.StructField("PULocationID", T.IntegerType(), True),
    T.StructField("DOLocationID", T.IntegerType(), True),
    T.StructField("lpep_pickup_datetime", T.TimestampType(), True),
    T.StructField("lpep_dropoff_datetime", T.TimestampType(), True)
])

FHV_SCHEMA = T.StructType(
    [
    T.StructField('PULocationID', T.IntegerType(), True), 
    T.StructField('DOLocationID', T.IntegerType(), True), 
    T.StructField('pickup_input_pathdatetime', T.TimestampType(), True), 
    T.StructField('dropoff_datetime', T.TimestampType(), True)
])