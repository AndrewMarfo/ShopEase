USE shop_ease;

CREATE TABLE IF NOT EXISTS orders(
	order_id INT NOT NULL,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL
);

CREATE TABLE IF NOT EXISTS products(
	product_id INT NOT NULL,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS customers(
	customer_id INT NOT NULL,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
	join_date DATE NOT NULL
);

-- Lab Exercise 2.1
USE shop_ease;
SELECT *
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN products ON orders.product_id = products.product_id
ORDER BY orders.order_id;

-- Lab Exercise 2.2
USE shop_ease;
SELECT product_name, SUM(total_revenue) AS total_sales
FROM sales_data
WHERE year = (SELECT MAX(year) FROM sales_data)
  AND month = (SELECT MAX(month) FROM sales_data WHERE year = (SELECT MAX(year) FROM sales_data))
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;

-- Lab Exercise 2.3
USE shop_ease;
SELECT 
    order_id,
    customer_id,
    total_revenue,
    CASE 
        WHEN total_revenue > 1000 THEN 'High'
        WHEN total_revenue BETWEEN 500 AND 1000 THEN 'Medium'
        ELSE 'Low'
    END AS revenue_category
FROM sales_data;

-- Lab Exercise 2.3

