{{config(materialized = 'incremental',unique_key='ticket_no',post_hook="insert into {{this}}(ticket_no) VALUES (-1)")}}


select tf.* ,
boarding_no ,
seat_no ,
'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}' as dbt_time
from stg.ticket_flights tf 
left join stg.boarding_passes bp on tf.ticket_no = bp.ticket_no