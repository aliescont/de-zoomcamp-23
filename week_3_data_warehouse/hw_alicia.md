## Homework

### Question 1: 

CREATE OR REPLACE EXTERNAL TABLE `dezoomcamp-2023-375020.trips_data_all.external_fhv_tripdata`
OPTIONS (
format = 'CSV',
uris = ['gs://ny-taxi-fhv/fhv_tripdata_2019-*.csv.gz']
);

SELECT count(*) FROM dezoomcamp-2023-375020.trips_data_all.external_fhv_tripdata

CREATE OR REPLACE TABLE `dezoomcamp-2023-375020.trips_data_all.fhv_non_partitioned_tripdata`
AS SELECT * FROM `dezoomcamp-2023-375020.trips_data_all.external_fhv_tripdata`;

43244696

### Question 2: 

select 
    count(distinct affiliated_base_number)
  from `dezoomcamp-2023-375020.trips_data_all.fhv_non_partitioned_tripdata`
size → 317.94MB

select 
    count(distinct affiliated_base_number)
  from `dezoomcamp-2023-375020.trips_data_all.external_fhv_tripdata`
size → 0 MB

### Question 3: 

select 
    count(*)
  from `dezoomcamp-2023-375020.trips_data_all.fhv_non_partitioned_tripdata`
  where PUlocationID is null and DOlocationID is null
717,748

### Question 4: 
• Partition by pickup_datetime Cluster on affiliated_base_number

### Question 5: 
CREATE OR REPLACE TABLE `dezoomcamp-2023-375020.trips_data_all.fhv_partitioned_tripdata` 
PARTITION BY DATE(pickup_datetime)
CLUSTER BY affiliated_base_number
AS SELECT * FROM `dezoomcamp-2023-375020.trips_data_all.external_fhv_tripdata`;

select
  count(distinct affiliated_base_number)
from `dezoomcamp-2023-375020.trips_data_all.fhv_partitioned_tripdata` 
where 
pickup_datetime BETWEEN '2019-03-01' AND '2019-03-31'
23.05 MB

select
  count(distinct affiliated_base_number)
from `dezoomcamp-2023-375020.trips_data_all.fhv_non_partitioned_tripdata` 
where 
pickup_datetime BETWEEN '2019-03-01' AND '2019-03-31'
647.87MB

### Question 6: 
GCP Bucket

### (Not required) Question 7: 
False