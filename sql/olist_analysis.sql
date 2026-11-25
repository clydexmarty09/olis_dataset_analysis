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
WHERE oi.product_id = NULL 
GROUP BY o.order_status

-- Finding out the numvber of orders marked as delivered
-- Total: 96478 orders
SELECT COUNT(*) as num_delivered
FROM olist_orders_dataset as o 
WHERE o.order_status = 'delivered'

-- Finding the average delivery days
-- Total 12.56 days
SELECT AVG (
    julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)
) AS avg_delivery_days
FROM olist_orders_dataset
LIMIT 10; 

-- Findig the percentage of late orders 
-- Total: 6.77%
SELECT 
    COUNT(*) as late_orders,
    COUNT(*) * 100 / 96478 as late_order_percentage
FROM olist_orders_dataset as o 
WHERE o.order_status = 'delivered'
    AND date(o.order_delivered_customer_date) > date(o.order_estimated_delivery_date)