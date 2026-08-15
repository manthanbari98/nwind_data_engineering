{{config(
    materialized = 'table',
    schema = 'gold'
)}}

SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id,dbt_valid_from) as customer_sk,
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
    dbt_valid_from AS effective_from,
    COALESCE(CAST(dbt_valid_to AS DATE), DATE('9999-12-31')) AS effective_to,
    CASE
        WHEN dbt_valid_to == DATE('9999-12-31') THEN true
        ELSE false
    END AS is_current

FROM {{ref("snapshot_customer")}}