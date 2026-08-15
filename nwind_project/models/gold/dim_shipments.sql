{{config(
    materialized = 'table',
    schema = 'gold'
)}}

SELECT
    ROW_NUMBER() OVER (ORDER BY order_id) as shipment_sk,
    order_id,
    order_date,
    required_date,
    shipped_date,
    shipper_company,
    shipper_phone
FROM {{ref("silver_shippers")}}