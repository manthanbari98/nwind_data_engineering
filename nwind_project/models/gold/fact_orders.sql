{{config(
    materialized = 'table',
    schema = 'gold'
)}}

SELECT o.order_id,
       c.customer_sk,
       p.product_sk,
       o.quantity,
       o.unit_price,
       o.discount,
       o.freight_allocation AS freight_charges,
       e.employee_sk,
       s.shipment_sk,
       o.order_date
FROM {{ref("silver_orders")}} AS o
JOIN {{ref("dim_customers")}} AS C ON o.customer_id = c.customer_id
JOIN {{ref("dim_products")}} AS p ON o.product_id = p.product_id
JOIN {{ref("dim_employees")}} AS e ON o.employee_id = e.employee_id
JOIN {{ref("dim_shipments")}} AS s ON o.order_id = s.order_id
