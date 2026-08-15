{{config(
    materialized = 'table',
    schema = 'gold'
)}}

SELECT
    ROW_NUMBER() OVER (ORDER BY product_id,dbt_valid_from) as product_sk,
    product_id,
    product_name,
    category_name,
    quantity_per_unit,
    unit_price,
    units_in_stock,
    units_on_order,
    reorder_level,
    discontinued,
    supplier_company,
    dbt_valid_from AS effective_from,
    COALESCE(CAST(dbt_valid_to AS DATE), DATE('9999-12-31')) AS effective_to,
    CASE
        WHEN dbt_valid_to == DATE('9999-12-31')  THEN true
        ELSE false
    END AS is_current

FROM {{ref('snapshot_products')}}