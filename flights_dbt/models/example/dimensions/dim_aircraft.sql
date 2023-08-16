{{config(materialized = 'incremental',unique_key='aircraft_code',post_hook="insert into {{this}}(aircraft_code) VALUES (-1)")}}

select ad.* ,
seat_no ,
fare_conditions ,
case 
	when ad.range > 5600 then 'High'
	when ad.range < 5600 then 'Low' 
	when ad."range" = 5600 then 'Exactly_5600'
end as range_situaion , 
ad.model -> 'en' as Model_English ,
ad.model -> 're' as Model_Russian ,
'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}' as dbt_time
from stg.aircrafts_data ad
join stg.seats s on s.aircraft_code = ad.aircraft_code 



