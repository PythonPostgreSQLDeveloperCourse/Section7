SELECT * FROM items
INNER JOIN purchases
ON items.id = purchases.item_id;