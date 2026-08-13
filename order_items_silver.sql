CREATE OR REFRESH MATERIALIZED VIEW order_items_silver
(
    CONSTRAINT valid_order_id
    EXPECT (order_id IS NOT NULL)
    ON VIOLATION DROP ROW,

    CONSTRAINT valid_product_id
    EXPECT (product_id IS NOT NULL)
    ON VIOLATION DROP ROW,

    CONSTRAINT valid_order_item_id
    EXPECT (order_item_id IS NOT NULL)
    ON VIOLATION DROP ROW,

    CONSTRAINT valid_price
    EXPECT (price >= 0)
    ON VIOLATION DROP ROW,

    CONSTRAINT valid_freight
    EXPECT (freight_value >= 0)
    ON VIOLATION DROP ROW
)
AS
SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    CAST(price AS DECIMAL(12,2)) AS price,
    CAST(freight_value AS DECIMAL(12,2)) AS freight_value
FROM workspace.default.olist_order_items;