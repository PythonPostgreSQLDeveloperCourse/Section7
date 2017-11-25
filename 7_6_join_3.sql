SELECT customers.first_name, customers.last_name, items.name, items.price FROM items
INNER JOIN purchases ON items.id = purchases.item_id
INNER JOIN customers ON purchases.customer_id = customers.id;