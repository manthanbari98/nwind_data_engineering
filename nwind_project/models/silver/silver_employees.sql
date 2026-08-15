{{ config(
    materialized="table",
    schema="silver"
) }}

WITH DEDUP AS (
    SELECT *, 
    ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY ingestion_time DESC ) AS dedup_id
    FROM {{ref("employees")}})

SELECT
    employee_id,
    employee_name,
    title,
    city,
    country,
    reportsTO,
    CURRENT_TIMESTAMP() AS updated_at
FROM DEDUP
WHERE
    dedup_id = 1
