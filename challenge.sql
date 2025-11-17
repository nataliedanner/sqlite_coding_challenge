-- Tool I used: SQLite.
-- Results validated by running the queries and comparing the outputs to my own calculations using the data provided in the database.

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

-- TASK 3
SELECT e.first_name, e.last_name, e.salary AS employee_salary, d.name AS department_name, dept_avg.department_average
FROM employees e
JOIN departments d ON e.department_id = d.id
JOIN (
    SELECT department_id, round(AVG(salary), 2) AS department_average
    FROM employees
    GROUP BY department_id
) dept_avg ON e.department_id = dept_avg.department_id
WHERE e.salary > dept_avg.department_average
ORDER BY e.salary DESC, e.salary DESC;

-- TASK 4
SELECT c.city, COUNT(*) AS gold_customer_count
FROM customers c
WHERE c.loyalty_level = 'Gold'
GROUP BY c.city
ORDER BY gold_customer_count DESC, c.city ASC;