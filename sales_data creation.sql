CREATE DATABASE IF NOT EXISTS shop_ease;
USE shop_ease;

CREATE TABLE IF NOT EXISTS sales_data(
	order_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    total_revenue DECIMAL(10, 2) NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL
);
