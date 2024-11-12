USE shop_ease;

-- Lab Exercise 3.1
-- using ROW_NUMBER()
SELECT 
	order_id,
    customer_name,
    product_id,
    quantity,
    product_name,
    total_revenue,
    ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS sales_rank
FROM sales_data;

-- using RANK()
SELECT 
    order_id,
    customer_name,
    product_id,
    quantity,
    product_name,
    total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS sales_rank
FROM sales_data;

-- using DENSE_RANK()
SELECT 
    order_id,
    customer_name,
    product_id,
    quantity,
    product_name,
    total_revenue,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS sales_rank
FROM sales_data;

-- lab Exercise 3.2
SELECT 
    category,
    order_date,
    total_revenue,
    SUM(total_revenue) OVER (
        PARTITION BY category
        ORDER BY order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_sales
FROM sales_data;

-- lab Exercise 3.3
SELECT 
    customer_id,
    customer_name,
    order_id,
    total_revenue,
    AVG(total_revenue) OVER (PARTITION BY customer_id) AS avg_order_value
FROM sales_data
ORDER BY customer_id, order_id;

-- lab Exercise 3.4
WITH monthly_sales AS (
	SELECT
		year,
        month,
        SUM(total_revenue) AS monthly_total_sales
	FROM sales_data
    GROUP BY year, month
)

SELECT 
    year,
    month,
    monthly_total_sales,
    LAG(monthly_total_sales) OVER (ORDER BY year, month) AS previous_month_sales,
    LEAD(monthly_total_sales) OVER (ORDER BY year, month) AS next_month_sales
FROM monthly_sales
ORDER BY year, month;

-- Lab Exercise 3.5
WITH monthly_sales AS (
    SELECT 
        customer_id,
        year,
        month,
        SUM(total_revenue) AS monthly_total_sales
    FROM sales_data
    GROUP BY customer_id, year, month
)

SELECT 
    customer_id,
    product_id,
    order_date,
    category,
    quantity,
    price,
    total_revenue,
    
    -- Cumulative monthly sales trend for each customer
    SUM(total_revenue) OVER (PARTITION BY customer_id ORDER BY year, month) AS cumulative_sales,

    -- Ranking products by total revenue within each product category
    RANK() OVER (PARTITION BY category ORDER BY total_revenue DESC) AS product_sales_rank,
    
    -- Purchase frequency: Ranking each order for each customer
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS purchase_number,
    
    -- Average order value for each customer
    AVG(total_revenue) OVER (PARTITION BY customer_id) AS avg_order_value
FROM sales_data
ORDER BY customer_id, order_date;