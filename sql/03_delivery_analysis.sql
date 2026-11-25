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

