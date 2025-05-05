SELECT TOP 100 * FROM pizza_sales; 
-- Using Top clause to limit the number of rows to 100 for performance optimization


-- Total Revenue of Pizza Sales
SELECT SUM(total_price) "Total_revenue" FROM pizza_sales;

-- Average Order Value
-- The formula method is used instead of the "AVG" clause to avoid duplicate order IDs in the table, which could lead to incorrect results.
SELECT SUM(total_price)/COUNT(DISTINCT order_id) AS Average_order_value FROM pizza_sales;

-- Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales;

-- Total Orders 
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

-- Average Pizzas per order
SELECT CAST(SUM(quantity) AS DECIMAL (10,2)) / CAST( COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS Avg_Pizzas FROM pizza_sales

-- Total Orders per Day
SELECT DATENAME(DW, order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_orders 
FROM pizza_sales
GROUP BY DATENAME(DW, order_date);

-- Total Orders per month
SELECT DATENAME(MONTH, order_date) AS Order_month, COUNT(DISTINCT order_id) AS Total_orders 
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date);

-- Order value per category
SELECT pizza_category, SUM(total_price) AS Revenue, CAST(SUM(total_price) * 100  / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL (5,2))  AS PCT 
FROM pizza_sales
GROUP BY pizza_category;

-- Order value per size
SELECT pizza_size, SUM(total_price) AS Revenue, CAST(SUM(total_price) * 100  / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL (5,2))  AS PCT 
FROM pizza_sales
GROUP BY pizza_size;

-- Top 5 selling pizzas
SELECT TOP 5 pizza_name, SUM(total_price) AS Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) DESC;

-- Worst 5 Selling pizzas
SELECT TOP 5 pizza_name, SUM(total_price) AS Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(total_price) ASC;