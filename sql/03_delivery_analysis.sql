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