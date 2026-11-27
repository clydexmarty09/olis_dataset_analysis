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

-- Finding the number of items sold per category, plus the total price per category
SELECT 
SUM(o.price) AS price_per_category, 
p.product_category_name, 
COUNT(*) AS items_sold
FROM olist_products_dataset AS p
JOIN olist_order_items_dataset AS o 
	ON  p.product_id = o.product_id 
GROUP BY p.product_category_name
ORDER BY price_per_category DESC

-- Finding the highest number of items sold per category
-- Result cama_mesa_banho with 11115
SELECT 
SUM(o.price) AS price_per_category, 
p.product_category_name, 
COUNT(*) AS items_sold
FROM olist_products_dataset AS p
JOIN olist_order_items_dataset AS o 
	ON  p.product_id = o.product_id 
GROUP BY p.product_category_name
ORDER BY items_sold DESC

-- Finding the average price of categories 'beauty & health' and 'bed, bath, and table'
-- Results: 130.16 and 93.30 respectively. 
SELECT 
SUM(o.price) AS price_per_category, 
p.product_category_name, 
COUNT(*) AS items_sold, 
AVG(o.price) AS avg_price
FROM olist_products_dataset AS p
JOIN olist_order_items_dataset AS o 
	ON  p.product_id = o.product_id 
WHERE p.product_category_name = 'beleza_saude' 
	OR  p.product_category_name = 'cama_mesa_banho'
GROUP BY p.product_category_name
ORDER BY avg_price DESC

-- Determining the category with the highest freight_value
--Result: cama_mesa_banho with $204639.04

SELECT 
SUM(o.price) AS price_per_category, 
p.product_category_name, 
COUNT(*) AS items_sold, 
AVG(o.price) AS avg_price, 
SUM(o.freight_value) AS freight_per_category
FROM olist_products_dataset AS p
JOIN olist_order_items_dataset AS o 
	ON  p.product_id = o.product_id 
GROUP BY p.product_category_name
ORDER BY freight_per_category DESC






