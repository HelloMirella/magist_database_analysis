#   How many months of data are included in the magist database?
SELECT 
	YEAR(order_purchase_timestamp) AS year_,
    MONTH(order_purchase_timestamp) AS month_,
	COUNT(order_id)
FROM
	orders
GROUP BY year_ , month_
ORDER BY year_ , month_;


# 	How many sellers are there?  
SELECT 
    COUNT(seller_id)
FROM
    sellers;

    
# How many Tech sellers are there?
# STEP 1
SELECT *
FROM
order_items
LEFT JOIN 
products
ON order_items.product_id = products.product_id
WHERE product_category_name IN ('audio', 'pcs','consoles_games', 'eletronicos', 'informatica_acessorios', 'telefonia');

# STEP 2
SELECT 
product_category_name,
COUNT(seller_id)
FROM
order_items
LEFT JOIN 
products
ON order_items.product_id = products.product_id
WHERE product_category_name IN ('audio', 'pcs','consoles_games', 'eletronicos', 'informatica_acessorios', 'telefonia')
GROUP BY product_category_name;
# OR
SELECT 
COUNT(seller_id)
FROM
order_items
LEFT JOIN 
products
ON order_items.product_id = products.product_id
WHERE product_category_name IN ('audio', 'pcs','consoles_games', 'eletronicos', 'informatica_acessorios', 'telefonia');

# What percentage of overall sellers are Tech sellers?
# SELECT 
# product_category_name,
# COUNT(seller_id)
# FROM
# order_items
# LEFT JOIN 
# products
# ON order_items.product_id = products.product_id
# GROUP BY product_category_name;


#	What is the total amount earned by all sellers? 
SELECT 
product_category_name,
SUM(price)
FROM
order_items
LEFT JOIN 
products
ON order_items.product_id = products.product_id
GROUP BY product_category_name;

# What is the total amount earned by all Tech sellers?

SELECT 
SUM(price)
FROM
order_items
LEFT JOIN 
products
ON order_items.product_id = products.product_id
WHERE product_category_name IN ('audio', 'pcs','consoles_games', 'eletronicos', 'informatica_acessorios', 'telefonia');

# What is the amount per product category earned by all Tech sellers?
SELECT 
product_category_name,
SUM(price)
FROM
order_items
LEFT JOIN 
products
ON order_items.product_id = products.product_id
WHERE product_category_name IN ('audio', 'pcs','consoles_games', 'eletronicos', 'informatica_acessorios', 'telefonia')
GROUP BY product_category_name;

# Can you work out the average monthly income of all sellers? 
SELECT 
	seller_id,
sum(payment_value) AS total_payment,
sum(payment_value) / 25 AS total_payment_per_month
FROM
	orders
LEFT JOIN 
	order_payments
ON 
	orders.order_id = order_payments.order_id
RIGHT JOIN
	order_items
ON 
	order_items.order_id = order_payments.order_id
    LEFT JOIN 
products
ON order_items.product_id = products.product_id
WHERE product_category_name IN ('audio', 'pcs','consoles_games', 'eletronicos', 'informatica_acessorios', 'telefonia')
GROUP BY product_category_name;
WHERE order_status IN ('deliverd','invoiced')
GROUP BY seller_id
ORDER BY total_payment_per_month DESC;


# Can you work out the average monthly income of Tech sellers?

SELECT 
	seller_id,
sum(payment_value) AS total_payment,
sum(payment_value) / 25 AS total_payment_per_month
FROM
	orders
LEFT JOIN 
	order_payments
ON 
	orders.order_id = order_payments.order_id
RIGHT JOIN
	order_items
ON 
	order_items.order_id = order_payments.order_id
WHERE product_category_name IN ('audio', 'pcs','consoles_games', 'eletronicos', 'informatica_acessorios', 'telefonia') AND order_status IN ('deliverd','invoiced')
GROUP BY seller_id
ORDER BY total_payment_per_month DESC;