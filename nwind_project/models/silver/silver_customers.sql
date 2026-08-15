{{ config(
    materialized="table",
    schema="silver"
) }}

WITH DEDUP AS (
    SELECT *, 
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY ingestion_time DESC ) AS dedup_id
    FROM {{ref("customers")}})

SELECT
    customer_id,
    company_name,
    contact_name,
    contact_title,
    cust_address,
    city,
    region,
    postal_code,
    country,
    phone,
    fax,
    CURRENT_TIMESTAMP() AS updated_at
FROM DEDUP
WHERE dedup_id = 1