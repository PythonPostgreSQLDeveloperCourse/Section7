SELECT customers.first_name, customers.last_name, SUM(items.price) from items
INNER JOIN purchases ON items.id = purchases.item_id
INNER JOIN customers on purchases.customer_id = customers.id
GROUP BY customers.id