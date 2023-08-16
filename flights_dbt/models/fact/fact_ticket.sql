{{config(materialized = 'incremental',unique_key='passenger_id',post_hook="insert into {{this}}(passenger_id) VALUES (-1)")}}

select t.* ,
book_date ,
total_amount ,
contact_data -> 'phone' as phone,
contact_data -> 'email' as email ,
'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}' as dbt_time
from stg.tickets t 
join stg.bookings b on t.book_ref = b.book_ref 

