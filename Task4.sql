CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE orders (
    order_id VARCHAR(20),
    customer_id VARCHAR(20),
    product_id VARCHAR(20),
    product_name VARCHAR(255),
    category VARCHAR(100),
    quantity INT,
    price DECIMAL(10,2),
    order_date DATE,
    region VARCHAR(100),
    payment_method VARCHAR(50),
    total_amount DECIMAL(10,2)
);

-- Creating table products
CREATE TABLE products AS
SELECT DISTINCT product_id, product_name, category, price
FROM orders;

-- creating table customers 
CREATE TABLE customers AS
SELECT DISTINCT customer_id
FROM orders;

show tables;

-- INNER JOIN: Orders with customer details
SELECT o.order_id, o.customer_id, c.customer_id
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- INNER JOIN orders with products (with sample output)
SELECT o.order_id, o.product_id, p.product_name, p.category, p.price
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id
LIMIT 10;


-- LEFT JOIN: Orders with product info
SELECT o.order_id, o.product_id, p.product_name, p.price
FROM orders o
LEFT JOIN products p ON o.product_id = p.product_id;

-- RIGHT JOIN (if needed, note: MySQL may emulate it)
SELECT o.order_id, o.product_id, p.product_name
FROM orders o
RIGHT JOIN products p ON o.product_id = p.product_id;

-- View all data from orders table
SELECT * FROM orders;

--  Get top 5 orders by highest total_amount
SELECT order_id, customer_id, total_amount
FROM orders
ORDER BY total_amount DESC
LIMIT 5;

--  Total quantity sold per product category
SELECT category, SUM(quantity) AS total_quantity
FROM orders
GROUP BY category;

--  Average price per region
SELECT region, AVG(price) AS avg_price
FROM orders
GROUP BY region;

-- Count the number of orders placed in each region
SELECT region, COUNT(*) AS number_of_orders
FROM orders
GROUP BY region;

--  Subquery: Show orders where total_amount is greater than the average
SELECT order_id, total_amount
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount) FROM orders
);

--  View orders only from 'South' region
SELECT * FROM orders
WHERE region = 'South';

--  Create a view for total sales by category
CREATE OR REPLACE VIEW category_summary AS
SELECT category, SUM(total_amount) AS total_sales
FROM orders
GROUP BY category;

--  Select from the view
SELECT * FROM category_summary;

--  Create an index on order_date column to improve performance
SHOW COLUMNS FROM orders;
SHOW INDEX FROM orders;




