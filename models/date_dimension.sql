WITH CTE AS (
    SELECT
    to_timestamp(STARTED_AT) AS STARTED_AT,
    DATE(to_timestamp(STARTED_AT)) AS DATE_STARTED_AT,
    HOUR(to_timestamp(STARTED_AT)) AS HOUR_STARTED_AT,

    CASE 
    WHEN DAYNAME(to_timestamp(STARTED_AT)) IN ('Sat', 'Sun')
    THEN 'WEEKEND'
    ELSE 'BUSINESSDAY'
    END AS DAY_TYPE,
    
    CASE 
    WHEN MONTH(to_timestamp(STARTED_AT)) IN (12,1,2)
    THEN 'WINTER'
    WHEN MONTH(to_timestamp(STARTED_AT)) IN (3,4,5)
    THEN 'SPING'
    WHEN MONTH(to_timestamp(STARTED_AT)) IN (6,7,8)
    THEN 'SUMMER'
    ELSE 'AUTUMN'
    END AS STATION_OF_YEAR

    FROM 
    {{ source('demo', 'bike') }}
    WHERE STARTED_AT != 'started_at'

)
SELECT *
FROM CTE
