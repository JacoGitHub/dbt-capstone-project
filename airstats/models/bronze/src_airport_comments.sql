{{
    config(
        materialized = 'ephemeral'
    )
}}

WITH cte_airport_comments AS (
    SELECT * FROM {{ source('airstats', 'comments') }}
)
SELECT 
    id AS comment_id,
    airport_ident,
    date AS comment_timestamp, -- (it's actually a timestamp column, not a date column)
    member_nickname,
    subject	AS comment_subject,
    body AS comment_body
FROM
    cte_airport_comments
