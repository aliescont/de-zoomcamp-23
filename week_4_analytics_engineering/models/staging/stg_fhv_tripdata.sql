{{
    config(
        materialized='view'
    )
}}


with tripdata as (
    select
        * except(dispatching_base_num),
        cast(dispatching_base_num as string) as dispatching_base_num
    from {{ source('staging', 'fhv_data') }}
    where dispatching_base_num is not null
)
select
    {{ dbt_utils.surrogate_key(['dispatching_base_num', 'pickup_datetime']) }} as tripid,
    cast(dispatching_base_num as integer) as vendorid,
    cast(null as integer) as ratecodeid,
    cast(pulocationid as integer) as  pickup_locationid,
    cast(dolocationid as integer) as dropoff_locationid,
    
    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropoff_datetime as timestamp) as dropoff_datetime,
    
    -- trip info
    cast(null as string) as store_and_fwd_flag,
    cast(null as integer) as passenger_count,
    cast(null as numeric) as trip_distance,
    -- yellow cabs are always street-hail
    2 as trip_type,
    
    -- payment info
    cast(null as numeric) as fare_amount,
    cast(null as numeric) as extra,
    cast(null as numeric) as mta_tax,
    cast(null as numeric) as tip_amount,
    cast(null as numeric) as tolls_amount,
    cast(0 as numeric) as ehail_fee,
    cast(null as numeric) as improvement_surcharge,
    cast(null as numeric) as total_amount,
    cast(null as integer) as payment_type,
    cast(null as string) as payment_type_description, 
    cast(null as numeric) as congestion_surcharge,
from tripdata
-- dbt build --m <model.sql> --var 'is_test_run: false'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}

