#Top 5 Market
SELECT
market,
ROUND (sum(net_sales)/ 1000000,2) as net_sales_mln 
FROM net_sales
WHERE fiscal_year = 2021
GROUP BY market
ORDER BY net_sales_mln desc
limit 5;

#Top 5 Customers by Net Sales
SELECT c.customer,
round(sum(net_sales)/1000000,2) as net_sales_mln
FROM net_sales n
JOIN dim_customer c
ON n.customer_code = c.customer_code
WHERE fiscal_year = 2021
GROUP BY customer
ORDER BY net_sales_mln desc
LIMIT 5;

#Top 5 Products by Net Sales
SELECT
product,
ROUND (sum(net_sales)/ 1000000,2) as net_sales_mln 
FROM net_sales
WHERE fiscal_year = 2021
GROUP BY market
ORDER BY net_sales_mln desc
LIMIT 5;

#Top 10% Market by Global Net Sales
WITH cte1 AS (
SELECT customer,
ROUND(sum(net_sales)/1000000,2) as net_sales_mln
FROM net_sales s
JOIN dim_customer c
ON s.customer_code = c.customer_code
WHERE fiscal_year = 2021
GROUP BY customer
ORDER BY net_sales_mln desc)

SELECT customer,
net_sales_mln*100/sum(net_sales_mln) OVER() as pct
 from cte1
ORDER BY net_sales_mln desc
LIMIT 5;

#Get Top N Products in each Division by their quantity sold
SELECT p.division, p.product,
sum(sold_quantity) as total_qty
FROM fact_sales_monthly s
JOIN dim_product p
ON p.product_code=s.product_code
WHERE fiscal_year = 2021
GROUP BY p.product 
