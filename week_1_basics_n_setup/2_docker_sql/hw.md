Q1 ->  --iidfile string
q2 -> 3
select count(*) from green_taxi_data where cast(lpep_pic
 kup_datetime as date) = date '2019-01-15' and cast(lpep_dropoff_datetime as dat
 e) = date '2019-01-15'
q3 -> 20530
select cast(lpep_pickup_datetime as date), trip_distance
  from green_taxi_data  order by 2 desc
q4 -> 2019-01-15
select count(*), passenger_count from green_taxi_data wh
 ere (passenger_count = 2 or passenger_count = 3) and cast(lpep_pickup_datetime 
 as date) = date '2019-01-01' and cast(lpep_dropoff_datetime as date) = date '20
 19-01-01' group by 2   
q5 -> 2: 1282 ; 3: 254
select z2."Zone"  , max(g.tip_amount) from green_taxi_da
 ta as g left join zones as z on g."PULocationID" = z."LocationID" left join zon
 es as z2 on g."DOLocationID"= z2."LocationID" where z."Zone" = 'Astoria' group 
 by 1 order by 2 desc
q6 -> Long Island City/Queens Plaza