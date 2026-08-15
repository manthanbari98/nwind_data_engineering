{{config(
    materialized = "table",
    schema = "bronze"
)}}

SELECT * FROM {{source("databricks_nwind","shippers")}}

