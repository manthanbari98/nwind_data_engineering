{{config(
    materialized = "view",
    schema = "bronze"
)}}

SELECT * FROM {{source("databricks_nwind","employees")}}
