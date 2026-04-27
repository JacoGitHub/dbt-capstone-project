{{ config(severity="warn") }}
SELECT * FROM {{ ref('silver_airport_comments') }}
WHERE LEN(NVL(comment_subject, '')) = 0
    OR LEN(NVL(comment_body, '')) = 0
LIMIT 10
