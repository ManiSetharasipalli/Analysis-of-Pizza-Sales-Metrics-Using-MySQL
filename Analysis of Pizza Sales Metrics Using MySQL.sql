USE pizza_sales;
DESC orders;
# SELECT * FROM orders;

-- Calculate various statistics for pizza orders
SELECT 
      ROUND(SUM(total_price)) AS Total_Revenue,
      COUNT(DISTINCT order_id) AS Total_Orders,
      SUM(quantity) AS Total_Pizzas_sold,
      ROUND(AVG(unit_price)) AS Average_pizza_price,
      ROUND(SUM(total_price)/COUNT(DISTINCT order_id)) AS Average_Order_Value,
      -- Determine the average number of pizzas sold per order 
      ROUND(SUM(quantity)/COUNT(DISTINCT order_id)) AS Average_pizza_sold
FROM orders;

-- Identify peak hours and the total number of orders during each hour
SELECT 
      HOUR(order_time) AS peak_hours,
      COUNT(DISTINCT order_id) AS Total_orders
FROM orders
GROUP BY HOUR(order_time)
ORDER BY Total_orders DESC;

-- Daily trend for total orders
SELECT 
      DAYNAME(order_date) AS Order_day,
	  COUNT(DISTINCT order_id) AS Total_Orders,
      SUM(quantity) AS Total_products_sold
FROM orders
GROUP BY DAYNAME(order_date)
ORDER BY Total_Orders DESC;

-- Monthly trend for total orders
SELECT 
	 MONTHNAME(order_date) AS Month_name,
     COUNT(DISTINCT order_id) AS Total_Orders,
	 SUM(quantity) AS Total_products_sold
FROM orders
GROUP BY MONTHNAME(order_date)
ORDER BY Total_Orders DESC;

-- Percentage of sales by pizza category
SELECT 
       pizza_category,
       CONCAT(ROUND(SUM(quantity)/(SELECT SUM(quantity) FROM orders) * 100,2),"%") AS pizza_sales
FROM orders 
GROUP BY pizza_category
ORDER BY pizza_sales DESC;

-- Percentage of sales by pizza size
SELECT 
       pizza_size,
       CONCAT(ROUND(SUM(quantity)/(SELECT SUM(quantity) FROM orders) * 100,2),"%") AS pizza_sales
FROM orders 
GROUP BY pizza_size
ORDER BY pizza_sales DESC;

-- Top 5 pizza by orders
SELECT 
       pizza_name_id,
       pizza_name,
       ROUND(COUNT(DISTINCT order_id)) AS Total_orders
FROM orders
GROUP BY pizza_name_id,pizza_name
ORDER BY Total_orders DESC
LIMIT 5;

-- Bottom 5 pizza by orders
SELECT 
       pizza_name_id,
       pizza_name,
       ROUND(COUNT(DISTINCT order_id)) AS Total_orders
FROM orders
GROUP BY pizza_name_id,pizza_name
ORDER BY Total_orders
LIMIT 5;

-- Top 5 pizza by products sold
SELECT 
       pizza_name_id,
       pizza_name,
       ROUND(SUM(quantity)) AS Total_products_sold
FROM orders
GROUP BY pizza_name_id,pizza_name
ORDER BY Total_products_sold DESC
LIMIT 5;

-- Bottom 5 pizza by products sold
SELECT 
       pizza_name_id,
       pizza_name,
       ROUND(SUM(quantity)) AS Total_products_sold
FROM orders
GROUP BY pizza_name_id,pizza_name
ORDER BY Total_products_sold 
LIMIT 5;

-- Top 5 pizza by revenue
SELECT 
       pizza_name_id,
       pizza_name,
       ROUND(SUM(total_price)) AS Total_revenue
FROM orders
GROUP BY pizza_name_id,pizza_name
ORDER BY Total_revenue DESC
LIMIT 5;

-- Bottom 5 pizza by revenue
SELECT 
       pizza_name_id,
       pizza_name,
       ROUND(SUM(total_price)) AS Total_revenue
FROM orders
GROUP BY pizza_name_id,pizza_name
ORDER BY Total_revenue 
LIMIT 5;
       