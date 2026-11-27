-- Finding the number of orders, total price of all orders, and average order price. 
-- Result: 98666, 120.65, 13591643.7
SELECT 
count(DISTINCT(order_id)) as num_orders,
AVg(price) as average_order_price,
SUM(price) AS order_total
FROM olist_order_items_dataset

-- Finding the total price of orders per order_id
SELECT 
order_id, 
SUM(price) AS order_total
FROM olist_order_items_dataset
GROUP BY order_id
ORDER BY order_total DESC

-- Finding the avearge value of an order
-- Result: 137.7
SELECT 
SUM(price) AS order_total, 
AVG(price) avg_per_order, 
SUM(price) / COUNT(DISTINCT(order_id)) AS average_order_value
FROM olist_order_items_dataset





