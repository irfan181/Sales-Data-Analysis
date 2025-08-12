-- 1. Create Database
CREATE DATABASE IF NOT EXISTS sales_analysis;
USE sales_analysis;

-- 2. Create Products Table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL
);

-- 3. Create Customers Table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20)
);

-- 4. Create Sales Table
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    quantity INT NOT NULL,
    sale_date DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 5. Insert Sample Data into Products
INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 750.00),
('Smartphone', 'Electronics', 500.00),
('Office Chair', 'Furniture', 150.00),
('Pen', 'Stationery', 2.50),
('Desk', 'Furniture', 200.00);

-- 6. Insert Sample Data into Customers
INSERT INTO customers (customer_name, email, phone) VALUES
('Alice Johnson', 'alice@example.com', '1234567890'),
('Bob Smith', 'bob@example.com', '0987654321'),
('Charlie Lee', 'charlie@example.com', '1122334455');

-- 7. Insert Sample Data into Sales
INSERT INTO sales (product_id, customer_id, quantity, sale_date) VALUES
(1, 1, 2, '2025-08-01'),
(2, 2, 1, '2025-08-03'),
(4, 1, 20, '2025-08-05'),
(3, 2, 1, '2025-08-07'),
(5, 3, 2, '2025-08-08'),
(1, 3, 1, '2025-08-08');

-- 8. View All Sales
SELECT * FROM sales;

-- 9. Total Revenue
SELECT 
    SUM(p.price * s.quantity) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id;

-- 10. Revenue by Product
SELECT 
    p.product_name,
    SUM(s.quantity) AS total_quantity_sold,
    SUM(p.price * s.quantity) AS revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- 11. Sales by Customer
SELECT 
    c.customer_name,
    COUNT(s.sale_id) AS total_purchases,
    SUM(p.price * s.quantity) AS total_spent
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.customer_name;

-- 12. Best Selling Product
SELECT 
    p.product_name,
    SUM(s.quantity) AS total_sold
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 1;

-- 13. Sales on a Specific Date
SELECT 
    s.sale_date,
    p.product_name,
    c.customer_name,
    s.quantity,
    (p.price * s.quantity) AS total_price
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN customers c ON s.customer_id = c.customer_id
WHERE s.sale_date = '2025-08-08';

-- 14. Total Sales per Day
SELECT 
    sale_date,
    SUM(p.price * s.quantity) AS daily_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY sale_date
ORDER BY sale_date;

-- 15. Total Quantity Sold per Category
SELECT 
    p.category,
    SUM(s.quantity) AS total_quantity
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category;

USE sales_analysis;
