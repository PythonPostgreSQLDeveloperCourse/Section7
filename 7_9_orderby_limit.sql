SELECT customers.first_name, customers.last_name, SUM(items.price) as "total_spent" FROM items
INNER JOIN purchases on purchases.item_id = items.id
INNER JOIN customers ON purchases.customer_id = customers.id
GROUP BY customers.id
ORDER BY "total_spent" DESC
LIMIT 1