CREATE OR REFRESH MATERIALIZED VIEW customer_360_gold
AS
SELECT
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,

    COUNT(DISTINCT o.order_id) AS total_orders,

    ROUND(SUM(i.price), 2) AS total_spent,

    ROUND(AVG(i.price), 2) AS avg_item_value,

    MIN(o.order_purchase_timestamp) AS first_order_date,

    MAX(o.order_purchase_timestamp) AS last_order_date

FROM workspace.default.orders_dedup o

JOIN workspace.default.olist_customers c
    ON o.customer_id = c.customer_id

JOIN workspace.default.order_items_silver i
    ON o.order_id = i.order_id

GROUP BY
    c.customer_unique_id,
    c.customer_city,
    c.customer_state;