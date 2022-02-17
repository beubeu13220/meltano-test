 {{
   config(
     materialized='table'
   )
 }}

SELECT DISTINCT artist, label
FROM {{ source('tap-postgres', 'reviews') }} AS reviews

INNER JOIN {{ source('tap-postgres', 'labels') }} AS labels
ON reviews.reviewid=labels.reviewid