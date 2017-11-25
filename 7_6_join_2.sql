SELECT DISTINCT customers.first_name, customers.last_name FROM customers
INNER JOIN purchases
ON customers.id = purchases.customer_id;