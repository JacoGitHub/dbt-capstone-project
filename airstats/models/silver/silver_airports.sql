WITH cte_airports AS (
    SELECT * FROM {{ ref('src_airports') }}
)
SELECT 
    *
FROM
    cte_airports