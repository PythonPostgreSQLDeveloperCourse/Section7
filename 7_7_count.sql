SELECT customers.first_name, customers.last_name, COUNT(purchases.id) FROM customers
LEFT JOIN purchases ON customers.id = purchases.customer_id
GROUP BY customers.id;