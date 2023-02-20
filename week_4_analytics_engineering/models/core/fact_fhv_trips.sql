{{
    config(
        materialized='table'
    )
}}

with fhv_data as (
    select
        *
    from {{ ref('stg_fhv_tripdata') }}
    where 1=1
        and pickup_locationid is not null 
        and dropoff_locationid is not null
)
, dim_zones as (
    select
        *
    from {{ ref('dim_zones') }}
)
select 
    t.tripid,
    t.vendorid,
    t.pickup_locationid,
    pz.zone as pickup_zone, 
    pz.borough as pickup_borough, 
    t.pickup_datetime,
    t.dropoff_locationid,
    dz.borough as dropoff_borough, 
    dz.zone as dropoff_zone,  
    t.dropoff_datetime,
    t.trip_type, 
from fhv_data as t
inner join dim_zones as pz
on t.pickup_locationid = pz.locationid
inner join dim_zones as dz
on t.dropoff_locationid = dz.locationid