-- import files
-- count rows after joining orders with order items 
-- result: 112, 650 rows - 13209 more from the original count of orders
-- query: 
SELECT COUNT(*) AS num_rows 
FROM olist_orders_dataset as o 
JOIN olist_order_items_dataset as oi 
    ON o.order_id = oi.order_id ; 

-- Using LEFT JOIN, the number of orders without corresponding products was determined
-- result: 775 orders 
SELECT o.order_status, COUNT(DISTINCT o.order_id)
FROM olist_orders_dataset as o 
LEFT JOIN olist_order_items_dataset as oi
    ON o.order_id = oi.order_id 
WHERE oi.product_id is NULL 
GROUP BY o.order_status
