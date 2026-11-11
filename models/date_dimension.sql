WITH CTE AS (
    SELECT
    to_timestamp(STARTED_AT) AS STARTED_AT,
    DATE(to_timestamp(STARTED_AT)) AS DATE_STARTED_AT,
    HOUR(to_timestamp(STARTED_AT)) AS HOUR_STARTED_AT,

    {{get_day_type('STARTED_AT')}} AS DAY_TYPE, 
    {{get_season('STARTED_AT')}}  AS STATION_OF_YEAR

    FROM 
    {{ ref('stg_bike') }}
    WHERE STARTED_AT != 'started_at'

)
SELECT *
FROM CTE
