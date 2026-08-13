CREATE OR REFRESH MATERIALIZED VIEW daily_sales_gold
AS
SELECT
    DATE(o.order_purchase_timestamp) AS sales_date,

    COUNT(DISTINCT o.order_id) AS total_orders,

    COUNT(DISTINCT o.customer_id) AS total_customers,

    COUNT(i.order_item_id) AS total_items,

    ROUND(SUM(i.price), 2) AS product_revenue,

    ROUND(SUM(i.freight_value), 2) AS freight_revenue,

    ROUND(
        SUM(i.price + i.freight_value),
        2
    ) AS total_revenue,

    ROUND(
        SUM(i.price + i.freight_value)
        / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value

FROM workspace.default.orders_dedup o

INNER JOIN workspace.default.order_items_silver i
    ON o.order_id = i.order_id

WHERE o.order_status = 'delivered'

GROUP BY DATE(o.order_purchase_timestamp);