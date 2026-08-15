{{config(
    materialized = 'table',
    schema = 'gold'
)}}

SELECT 
ROW_NUMBER() OVER (ORDER BY employee_id) AS employee_sk
,*
FROM {{ref("silver_employees")}}