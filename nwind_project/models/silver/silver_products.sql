{{ config(
    materialized="table",
    schema="silver"
) }}

WITH category AS (
    SELECT category_id,
           category_name
    FROM {{ref("categories")}}
),
 
product AS (
    SELECT product_id,
           product_name,
           supplier_id,
           category_id,
           quantity_per_unit,
           unit_price,
           units_in_stock,
           units_on_order,
           reorder_level,
           discontinued
    FROM {{ref("products")}}
    ORDER BY product_id
),
supplier AS (
    SELECT supplier_id,
           company_name,
           contact_name,
           contact_title,
           address,
           city,
           region,
           postal_code,
           country,
           phone,
           fax
    FROM {{ref("suppliers")}}
),
joined_table AS (
    SELECT p.product_id AS product_id,
           p.product_name AS product_name,
           c.category_name AS category_name,
           p.quantity_per_unit AS quantity_per_unit,
           p.unit_price AS unit_price,
           p.units_in_stock AS units_in_stock,
           p.units_on_order AS units_on_order,
           p.reorder_level  AS reorder_level,
           p.discontinued AS discontinued,
           s.company_name AS supplier_company,
           s.contact_name AS supplier_contactname,
           s.country AS supplier_country,
           s.phone AS supplier_phone,
           s.fax AS supplier_fax
    FROM product as p
    join
        category as c on p.category_id = c.category_id
    join
        supplier as s on p.supplier_id = s.supplier_id
)

SELECT
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
    supplier_contactname,
    supplier_country,
    supplier_phone,
    supplier_fax,
    CURRENT_TIMESTAMP() AS updated_at
FROM joined_table
