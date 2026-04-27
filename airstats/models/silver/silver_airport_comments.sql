{{
    config(
        materialized = 'incremental',
        on_schema_change='fail'
    )
}}

WITH cte_airport_comments AS (
    SELECT * FROM {{ ref('src_airport_comments') }}
    WHERE comment_body IS NOT NULL
)
SELECT 
    comment_id,
    airport_ident,
    comment_timestamp, 
    NVL(
    member_nickname, 
    '__UNKNOWN__'
    ) AS member_nickname,
    comment_subject,
    comment_body,
    CURRENT_TIMESTAMP() AS loaded_at 
FROM
    cte_airport_comments
WHERE
    TRUE
{% if is_incremental() %}
    AND comment_id > (select max(comment_id) from {{ this }})
{% endif %}