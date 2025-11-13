-- TASK 1

SELECT sum(oi.quantity * p.price) AS total_spend,
    c.first_name || ' ' || c.last_name AS customer_full_name
FROM order_items oi
JOIN orders o ON oi.order_id = o.id
JOIN products p ON oi.product_id = p.id
JOIN customers c ON o.customer_id = c.id
GROUP BY c.id
ORDER BY total_spend DESC
LIMIT 5;

-- TASK 2
SELECT p.category, SUM(oi.quantity * p.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY p.category
ORDER BY revenue DESC;

-- TASK 2 with only "delivered" orders
SELECT p.category, SUM(oi.quantity * p.price) AS revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.id
JOIN products p ON oi.product_id = p.id
WHERE o.status = 'Delivered'
GROUP BY p.category
ORDER BY revenue DESC;