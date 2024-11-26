select * from dbo.automobiledata

SELECT
  MIN(length) AS min_length,
  MAX(length) AS max_length
FROM
  automobiledata

 SELECT *
FROM
  automobiledata
WHERE 
  num_of_doors IS NULL

  ---Update null values

UPDATE
  automobiledata
SET
  num_of_doors = 'four'
WHERE
  make = 'dodge'
  AND fuel_type = 'gas'
  AND body_style = 'sedan'

  ---

SELECT
  DISTINCT num_of_cylinders
FROM
  automobiledata;

---

 UPDATE
  automobiledata
SET
  num_of_cylinders = 'two'
WHERE
  num_of_cylinders = 'tow';

  SELECT
  MIN(compression_ratio) AS min_compression_ratio,
  MAX(compression_ratio) AS max_compression_ratio
FROM
  automobiledata
---
  
  SELECT
  MIN(compression_ratio) AS min_compression_ratio,
  MAX(compression_ratio) AS max_compression_ratio
FROM
  automobiledata
WHERE
  compression_ratio <> 70

  ---

  SELECT

   COUNT(*) AS num_of_rows_to_delete
FROM
  automobiledata
WHERE
   compression_ratio = 70
---

DELETE automobiledata

WHERE compression_ratio = 70

SELECT
  DISTINCT drive_wheels
FROM
  automobiledata

  ---What is the maximum price in the price column
  Select max(price) as Maximum_Price
  from automobiledata
