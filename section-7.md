## Installation

- pgAdmin
- stack builder
	+ apps that compliment postgre database

## Update

- specify a WHERE or else all rows are affected

## Delete

- don't for get the "where" or else all items get deleted

## Like

- underscores or %
- underscores are spaces
- `SELECT * FROM customers WHERE last_name LIKE '____'`

## Join

- key element of relational databases
- retrieve from multiple tables
- joins are like sets
- perform set operations with joins
- intersection is the elems common between 2 sets
- INNER JOIN, set intersection
	+ joins rows from table 1 and table 2 where they match the selecting column
- LEFT JOIN
	+ joins rows from table 1 and table 2 if they match
	+ if they don't match the data for the right table is blank
- RIGHT JOIN
	+ opposite of LEFT JOIN
- FULL JOIN
	+ both left and a right join
- Joins are much faster than getting the data from the tables separately and matching the data in our application
- most common: INNER JOIN then LEFT JOIN

## Count

- `SELECT customers.first_name, customers.last_name, COUNT(purchases.id) FROM customers LEFT JOIN purchases ON customers.id = purchases.customer_id GROUP BY customers.id`
- when performing COUNT it is necessary to use GROUP BY
- GROUP BY reduces row data to one item per customer

## Sum

- how much money each customer has spent

```
SELECT customers.first_name, customers.last_name, SUM(items.price) from items
INNER JOIN purchases ON items.id = purchases.item_id
INNER JOIN customers on purchases.customer_id = customers.id
GROUP BY customers.id
```

## Create table

```
CREATE TABLE public.users (
id integer PRIMARY KEY,
name character varying(100) NOT NULL
)
```

- `CREATE TABLE` <schema.table\_name> (<first\_col\_name> <data\_type> <is\_primary\_key\_primary>, <second\_col\_name> <data\_type> <allow\_null>)
- create a table, on schema public called users
	+ first column name is id
	+ the data type is integer
	+ we want to use this column as the primary key which is unique id
	+ the second column name is name
	+ the data type is character string of varying length up to 100
	+ the field cannot be left blank since we definitely want every id to be associated with a name

```
CREATE TABLE public.users (
id integer,
name character varying(100) NOT NULL,
CONSTRAINT users_id_pkey PRIMARY KEY (id))
```

- setting up the primary key this way allows for multiple colums to contain primary keys such as `PRIMARY KEY (id, name)` if we wanted name to also contain primary keys

## References (foreign key)

```
CREATE TABLE public.videos(
id integer,
user_id integer REFERENCES public.users,
name character varying(255) NOT NULL,
CONSTRAINT videos_id_pkey PRIMARY KEY (id))
```

- `user_id integer REFERENCES public.users`
- this `user_id` column should also be valid in the users table as `id`

## Insert Into

- insert some data into users table

```
INSERT INTO public.users(id, name)
VALUES (3, 'josealvatierra')
```

- insert data into (optional) public schema users table the columns id and name, values 3 and 'josealvatierra'
- column names are optional if we provide the number of items unless we want to insert data not in all the columns of the table
- if you want to only put data in to some of the columns then you have to specify column names

```
INSERT INTO public.users(id, name, phone_number)
VALUES (3, 'josealvatierra')
```

- valid

```
INSERT INTO public.users
VALUES (3, 'josealvatierra', 1234567)
```

- also valid

```
INSERT INTO public.videos
VALUES (1, 10, 'Test video');
```

- if we now try to insert an item with an arbitrary user id

```
ERROR:  insert or update on table "videos" violates foreign key constraint "videos_user_id_fkey"
DETAIL:  Key (user_id)=(10) is not present in table "users".
SQL state: 23503
```

- error when we run the example

```
SELECT * FROM public.videos
INNER JOIN public.users ON public.users.id = public.videos.user_id
```

- as we've seen before we can join the two tables

## Automatic Insert

- let postgres assign user ids automatically
- SEQUENCE generator of sequential numbers
- `CREATE SEQUENCE users_id_seq START 3;`
	+ create a sequence starting at 3 since we already have 2 items in our table
- `ALTER TABLE` changes a table

```
ALTER TABLE public.users
ALTER COLUMN id
SET DEFAULT nextval('users_id_seq');
```

- set the default id to the next value of the sequence using the `nextval` sql function

`ALTER SEQUENCE users_id_seq OWNED BY public.users.id`

- id column uses the sequence but also *owns* the sequence
- if table/column deleted cascade to -> sequence deleted
- `ALTER SEQUENCE` edit sequence name `OWNED BY` assign ownership to schema table column name

```
INSERT INTO public.users(name)
VALUES ('josealvatierra');
```

- test by inserting a new user without specifying an id

## Indexes

`CREATE INDEX users_name_index ON public.users(name);`

- speed
- picture a table with millions of users
- think of id = work, name = definition
- telling the table to search by definition is slow
- allow table to know how the names are ordered
- binary tree index
- items are inserted, updated, index needs to be updated
- index only items that need to be searched

`CREATE UNIQUE INDEX index_name table(column)`

- multi-column indexes
- don't create arbitrarily
- use case: when always performing search using a combination of columns using `AND`
	+ id=1 AND user_id=2

`SELECT * FROM public.movies WHERE id=1 AND user_id=2`

`CREATE INDEX index_name ON public.movies(id, user_id)`

- if you have separate indexes for each column postgres is still fast

- indexes can get corrupt
- re-index a specific index by name `REINDEX INDEX users_name_index`
- re-index a specific table by name `REINDEX TABLE table_index`
- re-index a specific database by name `REINDEX DATABASE database_index`
- you can tell postgres to use and not use indexes for troubleshooting
- indexes may need to be turned off to rebuild indexes then indexing can be turned back on

## DROP TABLE

`DROP TABLE public.users CASCADE;`

```
NOTICE:  drop cascades to constraint videos_user_id_fkey on table videos
DROP TABLE
```

- delete a table
- foreign key relationships
- `DROP TABLE table_name RESTRICT`
- the default behavior
- `DROP TABLE table_name CASCADE`
- foreign key reference gets removed as well
- other option is to drop the other table first

`DROP TABLE IF EXISTS public.videos;`

- so you don't create something that's already there

```
NOTICE:  table "videos" does not exist, skipping
DROP TABLE
```

- other things you can drop

`DROP TABLE ...`
`DROP DATABASE ...`
`DROP VIEW ...`

## Quiz

- How would we create the following table

|  name  |   category   |  price  |
| ------ | ------------ | ------- |
| pen    | office       | 7.99    |
| chair  | home         | 159.50  |

A:

```
CREATE TABLE items(
	name character varying(255),
	category character varying(255),
	price numeric(10, 2)
);

INSERT INTO items VALUES("pen", "office", 7.99)
INSERT INTO items VALUES("chair", "home", 159.50)
```

- Given the two following tables (cars and orders):

| id   | name        | price  |
| ---- | ----------- | ------ |
| 1    | Audi TT     | 29995  |
| 2    | Mini Cooper | 35575  |
| 3    | AMG S65     | 128935 |
| 4    | Ford Fiesta | 11000  |

| id   | car_id |
| ---- | ------ |
| 1    | 3      |
| 2    | 3      |
| 3    | 4      |
| 4    | 1      |

How could we get all purchases made, including the purchase amount, in a single result?

A: `SELECT * FROM orders INNER JOIN cars ON orders.car_id = cars.id`

- Given the following table (called items):

|  name  |   category   |  price  |
| ------ | ------------ | ------- |
| pen    | office       | 7.99    |
| pencil | office       | 1.99    |
| laptop | professional | 1599.75 |
| chair  | home         | 159.50  |

What would this query return?

`UPDATE items SET name = "ball-point pen" WHERE name = "pen";`

A: It would change the first row to have a name equal to "ball-point pen", and it would no longer be "pen"
