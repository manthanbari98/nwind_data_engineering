{{config(
    materialized = "incremental",
    schema = "bronze"
)}}

SELECT * FROM {{source("databricks_nwind","customers")}}

{% if is_incremental()%}

where ingestion_time > (SELECT COALESCE(MAX(ingestion_time),'1900-01-01') FROM {{this}})

{% endif %}