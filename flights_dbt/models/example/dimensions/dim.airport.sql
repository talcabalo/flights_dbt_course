select *,
airport_name -> 'en' as EN_airport,
airport_name -> 'ru' as RU_airport,
city -> 'en' as EN_city,
city -> 'ru' as RU_city,
'{{ run_started_at.strftime ("%Y-%m-%d %H:%M:%S")}}' as dbt_time
from
stg.airports_data