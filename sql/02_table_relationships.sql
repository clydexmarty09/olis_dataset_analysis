-- Count rows after joining Orders with Order Items
-- Result: 112,650 rows
SELECT COUNT(*) AS num_rows
FROM olist_orders_dataset AS o
JOIN olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id;

-- Investigate orders without matching item records
-- Result: 775 unmatched orders
SELECT
    o.order_status,
    COUNT(DISTINCT o.order_id) AS unmatched_orders
FROM olist_orders_dataset AS o
LEFT JOIN olist_order_items_dataset AS oi
    ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL
GROUP BY o.order_status;