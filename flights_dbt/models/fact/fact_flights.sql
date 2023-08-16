with cte as (
select * ,
EXTRACT(EPOCH FROM (scheduled_arrival - scheduled_departure)) / 3600 AS flight_duration_expected ,
EXTRACT(EPOCH FROM (actual_arrival - actual_departure)) / 3600 AS duration_flight 
from stg.flights f 
)
select * ,
case
	when flight_duration_expected > duration_flight then 'longer'
	when flight_duration_expected < duration_flight then 'shorter'
	when flight_duration_expected = duration_flight then 'as expected'
end as flight_duration_indicator ,
'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}' as dbt_time
from cte
