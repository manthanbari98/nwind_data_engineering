{{ config(
    materialized="table",
    schema="silver"
) }}

WITH shipper AS (
    SELECT shipper_id,
           company_name,
           phone
    FROM
        {{ref("shippers")}}
),

shipment AS (
    SELECT
        order_id,
        order_date,
        required_date,
        shipped_date,
        ship_via as shipper_id,
        ship_name,
        ship_city,
        ship_region,
        ship_postal_code,
        ship_country
    FROM
    {{ref("shipments")}}
    ORDER BY order_date
),
joined_table AS (
    SELECT
        sm.order_id AS order_id,
        sm.order_date As order_date,
        sm.required_date AS required_date,
        sm.shipped_date AS shipped_date,
        sp.company_name AS shipper_company,
        sp.phone AS shipper_phone,
        sm.ship_name AS ship_name,
        sm.ship_city AS ship_city,
        sm.ship_region AS ship_region,
        sm.ship_postal_code AS ship_postal_code,
        sm.ship_country AS ship_country
    FROM shipment AS sm
    JOIN
         shipper AS sp ON sm.shipper_id = sp.shipper_id
)

SELECT
    order_id,
    order_date,
    required_date,
    shipped_date,
    shipper_company,
    shipper_phone,
    ship_name,
    ship_city,
    ship_region,
    ship_postal_code,
    ship_country
FROM joined_table