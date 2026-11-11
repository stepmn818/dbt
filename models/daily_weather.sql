WITH daily_weather AS (
    SELECT 
    DATE(time) AS date, 
    weather,
    temp,
    pressure,
    humidity,
    clouds
    FROM {{ source('demo', 'weather') }}
),

daily_weather_agg AS (
    SELECT 
    date,
    weather,
    round(AVG(temp),2) AS avg_temp,
    round(avg(pressure),2) AS avg_pressure,
    round(avg(humidity),2) AS avg_humidity,
    round(avg(clouds),2) AS avg_clouds

    FROM daily_weather
    GROUP BY date, weather

    QUALIFY ROW_NUMBER() OVER (PARTITION BY date ORDER BY count(weather) DESC) = 1
) 

SELECT *
FROM daily_weather_agg


