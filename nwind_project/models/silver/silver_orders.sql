WITH order_detail AS (
    SELECT *,
        unit_price * quantity * (1 - discount) AS line_amount
    FROM {{ref("order_details")}}
),
order AS (
    SELECT *
    FROM {{ref("orders")}}
),
joined_table AS (
    SELECT      
                od.order_id,
                od.product_id,
                od.unit_price,
                od.quantity,
                od.discount,
                od.product_name,
                od.line_amount,
                o.customer_id,
                o.employee_id,
                o.order_date,
                o.required_date,
                o.shipped_date,
                o.ship_via,
                o.freight,
                o.ship_name,
                o.ship_address,
                o.ship_city,
                o.ship_region,
                o.ship_postal_code,
                o.ship_country,
                o.ingestion_time
    FROM order AS o
    JOIN order_detail AS od ON o.order_id = od.order_id
    order by od.order_id asc
),
total_amount AS (
    SELECT *,
            SUM(line_amount) OVER (PARTITION BY order_id) AS total_amount
    FROM joined_table
)

SELECT *,
    ROUND((freight * line_amount/total_amount ),2) AS freight_allocation
FROM total_amount