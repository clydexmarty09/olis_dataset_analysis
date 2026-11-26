-- Finding out the numvber of orders marked as delivered
-- Total: 96478 orders
SELECT COUNT(*) as num_delivered
FROM olist_orders_dataset as o 
WHERE o.order_status = 'delivered'

-- find the number of delayed orders
-- Result: 6534
SELECT COUNT(*) AS late_orders
FROM olist_orders_dataset
WHERE order_status = 'delivered'
    AND date(order_delivered_customer_date) > date(order_estimated_delivery_date)

-- Finding the average delivery days
-- Total 12.56 days
SELECT AVG (
    julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)
) AS avg_delivery_days
WHERE order_status = 'delivered'
FROM olist_orders_dataset

-- Findig the percentage of late orders 
-- Total: 6.77%
SELECT 
    COUNT(*) as late_orders,
    COUNT(*) * 100.0 / 96478 as late_order_percentage
FROM olist_orders_dataset as o 
WHERE o.order_status = 'delivered'
    AND date(o.order_delivered_customer_date) > date(o.order_estimated_delivery_date)

--Find the number of orders that was more than 30 days late 
-- Result 360
SELECT COUNT(*)
FROM olist_orders_dataset
WHERE order_status = 'delivered'
    AND (julianday(order_delivered_customer_date) > julianday(order_estimated_delivery_date)) > 30

-- Out of all late delievries, find the percentages of orders that were late for more than 30 days. 
-- Result: 5.50%
SELECT COUNT(*) * 100.0/6534
FROM olist_orders_dataset
WHERE order_status = 'delivered'
    AND (julianday(order_delivered_customer_date) > julianday(order_estimated_delivery_date)) > 30

-- Finding the state with the most amount of late deliveries
-- Result: SP with 1820 late deliveries
SELECT 
c.customer_state,
COUNT(*) AS late_deliveries
FROM olist_orders_dataset as o
JOIN olist_customers_dataset as c
	ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
	AND date(o.order_delivered_customer_date) > date(o.order_estimated_delivery_date)
GROUP BY c.customer_state
ORDER BY late_delIveries DESC

-- We want to determine if SP has the worst delivery performace or if it simply just has the most amount of orders
-- Find the total number of deliverd orders per state
-- SP total: 40501
SELECT 
c.customer_state,
COUNT(*) AS delivered_orders
FROM olist_orders_dataset as o
JOIN olist_customers_dataset as c
	ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY delivered_orders DESC

-- Finding percentage of orders from SP
-- Result: 42%
SELECT 
c.customer_state,
COUNT(*) * 100.0/96478 AS SP_orders_percentage
FROM olist_orders_dataset as o
JOIN olist_customers_dataset as c
	ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
	AND c.customer_state = 'SP'

-- Finding percentage of late deliveries in Sao Paulo
-- Total: 4.49%
SELECT 
c.customer_state,
COUNT(*) * 100.0 / 40501 AS SP_late_order_percentage
FROM olist_orders_dataset as o
JOIN olist_customers_dataset as c
	ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
	AND c.customer_state = 'SP'
	AND date(o.order_delivered_customer_date) > date(order_estimated_delivery_date)

-- Finding the percentage of late deliveries in RJ for comparison's sake
-- Interestingly, it was 12.1%
SELECT 
c.customer_state,
COUNT(*) * 100.0 / 12350  -- 12350 is the total number of delivered items in RJ 
FROM olist_orders_dataset as o
JOIN olist_customers_dataset as c
	ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
	AND c.customer_state = 'RJ'
	AND date(o.order_delivered_customer_date) > date(order_estimated_delivery_date)

-- Finding the percentages of late deliveries per state in Brazil  
-- Highest Results: AL, MA, SE, with 397 delivered and 85 late (21.4%), 717 delivered and 125 late(17.4%), and 335 delivered and 51 late (15.2%), respectively
SELECT 
c.customer_state,
COUNT(*) as delivered_orders,
 SUM(
	 CASE 
		WHEN date(order_delivered_customer_date)>date(order_estimated_delivery_date) THEN 1 
		ELSE 0
	END  
) AS late_deliveries,
 SUM(
	 CASE 
		WHEN date(order_delivered_customer_date)>date(order_estimated_delivery_date) THEN 1 
		ELSE 0
	END  
) *100.0/COUNT(*) AS percentage_of_late_orders_per_state
FROM olist_orders_dataset as o
JOIN olist_customers_dataset as c
	ON o.customer_id = c.customer_id
WHERE order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY percentage_of_late_orders_per_state DESC

-- Finding the state with the highest number of delivered orders for comparison
-- Restricted the query to show states with 1000 orders or more
-- Result: CE, BA, and, RJ, with 1279, 3256, 12350
SELECT 
c.customer_state,
COUNT(*) as delivered_orders,
 SUM(
	 CASE 
		WHEN date(order_delivered_customer_date)>date(order_estimated_delivery_date) THEN 1 
		ELSE 0
	END  
) AS late_deliveries,
 SUM(
	 CASE 
		WHEN date(order_delivered_customer_date)>date(order_estimated_delivery_date) THEN 1 
		ELSE 0
	END  
) *100.0/COUNT(*) AS percentage_of_late_orders_per_state
FROM olist_orders_dataset as o
JOIN olist_customers_dataset as c
	ON o.customer_id = c.customer_id
WHERE order_status = 'delivered'
GROUP BY c.customer_state
HAVING delivered_orders >= 1000
ORDER BY percentage_of_late_orders_per_state DESC