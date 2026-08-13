CREATE OR REFRESH STREAMING TABLE orders_bronze
AS
SELECT *
FROM STREAM read_files(
    '/Volumes/workspace/default/olist_raw/',
    format => 'csv',
    header => true,
    inferSchema => true
);