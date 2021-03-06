PGDMP         1            
    u            udemy-learning    10.0    10.0                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false                       1262    16394    udemy-learning    DATABASE     �   CREATE DATABASE "udemy-learning" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';
     DROP DATABASE "udemy-learning";
             jonas    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    3                        3079    12924    plpgsql 	   EXTENSION     ?   CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;
    DROP EXTENSION plpgsql;
                  false                       0    0    EXTENSION plpgsql    COMMENT     @   COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';
                       false    1            �            1259    16443    total_revenue_per_customer    VIEW     �   CREATE VIEW total_revenue_per_customer AS
SELECT
    NULL::integer AS id,
    NULL::character varying(100) AS first_name,
    NULL::character varying(255) AS last_name,
    NULL::numeric AS sum;
 -   DROP VIEW public.total_revenue_per_customer;
       public       postgres    false    3            �            1259    16447    awesome_customers    VIEW       CREATE VIEW awesome_customers AS
 SELECT total_revenue_per_customer.id,
    total_revenue_per_customer.first_name,
    total_revenue_per_customer.last_name,
    total_revenue_per_customer.sum
   FROM total_revenue_per_customer
  WHERE (total_revenue_per_customer.sum > (150)::numeric);
 $   DROP VIEW public.awesome_customers;
       public       postgres    false    199    199    199    199    3            �            1259    16395 	   customers    TABLE     �   CREATE TABLE customers (
    first_name character varying(100),
    id integer NOT NULL,
    last_name character varying(255)
);
    DROP TABLE public.customers;
       public         postgres    false    3            �            1259    16400    items    TABLE     s   CREATE TABLE items (
    name character varying(255) NOT NULL,
    id integer NOT NULL,
    price numeric(10,2)
);
    DROP TABLE public.items;
       public         postgres    false    3            �            1259    16459    expensive_items    VIEW     �   CREATE VIEW expensive_items AS
 SELECT items.name,
    items.id,
    items.price
   FROM items
  WHERE (items.price >= (100)::numeric);
 "   DROP VIEW public.expensive_items;
       public       postgres    false    197    197    197    3            �            1259    16467    non_luxury_items    VIEW     �   CREATE VIEW non_luxury_items AS
 SELECT expensive_items.name,
    expensive_items.id,
    expensive_items.price
   FROM expensive_items
  WHERE (expensive_items.price < (10000)::numeric)
  WITH CASCADED CHECK OPTION;
 #   DROP VIEW public.non_luxury_items;
       public       postgres    false    201    201    201    3            �            1259    16405 	   purchases    TABLE     b   CREATE TABLE purchases (
    id integer NOT NULL,
    item_id integer,
    customer_id integer
);
    DROP TABLE public.purchases;
       public         postgres    false    3            	          0    16395 	   customers 
   TABLE DATA               7   COPY customers (first_name, id, last_name) FROM stdin;
    public       postgres    false    196   o       
          0    16400    items 
   TABLE DATA               )   COPY items (name, id, price) FROM stdin;
    public       postgres    false    197   �                 0    16405 	   purchases 
   TABLE DATA               6   COPY purchases (id, item_id, customer_id) FROM stdin;
    public       postgres    false    198   V       �
           2606    16399    customers customers_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.customers DROP CONSTRAINT customers_pkey;
       public         postgres    false    196            �
           2606    16404    items items_pkey 
   CONSTRAINT     G   ALTER TABLE ONLY items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.items DROP CONSTRAINT items_pkey;
       public         postgres    false    197            �
           2606    16409    purchases purchases_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY purchases
    ADD CONSTRAINT purchases_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.purchases DROP CONSTRAINT purchases_pkey;
       public         postgres    false    198                       2618    16446 "   total_revenue_per_customer _RETURN    RULE     =  CREATE OR REPLACE VIEW total_revenue_per_customer AS
 SELECT customers.id,
    customers.first_name,
    customers.last_name,
    sum(items.price) AS sum
   FROM ((customers
     JOIN purchases ON ((customers.id = purchases.customer_id)))
     JOIN items ON ((purchases.item_id = items.id)))
  GROUP BY customers.id;
 �   CREATE OR REPLACE VIEW public.total_revenue_per_customer AS
SELECT
    NULL::integer AS id,
    NULL::character varying(100) AS first_name,
    NULL::character varying(255) AS last_name,
    NULL::numeric AS sum;
       public       postgres    false    196    196    198    2693    196    197    197    198    199            �
           2606    16410    purchases fk_customer_purchase    FK CONSTRAINT     w   ALTER TABLE ONLY purchases
    ADD CONSTRAINT fk_customer_purchase FOREIGN KEY (customer_id) REFERENCES customers(id);
 H   ALTER TABLE ONLY public.purchases DROP CONSTRAINT fk_customer_purchase;
       public       postgres    false    2693    196    198            �
           2606    16415    purchases fk_purchase_item    FK CONSTRAINT     k   ALTER TABLE ONLY purchases
    ADD CONSTRAINT fk_purchase_item FOREIGN KEY (item_id) REFERENCES items(id);
 D   ALTER TABLE ONLY public.purchases DROP CONSTRAINT fk_purchase_item;
       public       postgres    false    197    198    2695            	   U   x��;
�0���av��)ll����| .�ߙ��=|V���W0�s��TZcr�Flo-�4�|�f�i�,	3�řΎ�~���      
   r   x�%̱� F���O��\P�2KML]��@�4!��/����3��"t�|�RVS5����kZ��e+ԇ�R��_�7��ѐ�h�?�Յ-� �V�ĺ[�
-0g>���c         4   x���  B�3cl-����sH���@B.��F�m��K1�o1����v�     