CREATE OR REFRESH STREAMING TABLE orders_silver
(
    CONSTRAINT valid_order_id
    EXPECT (order_id IS NOT NULL),

    CONSTRAINT valid_customer_id
    EXPECT (customer_id IS NOT NULL),

    CONSTRAINT valid_order_status
    EXPECT (order_status IS NOT NULL)
)
AS
SELECT
    order_id,
    customer_id,
    LOWER(TRIM(order_status)) AS order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM STREAM orders_bronze;