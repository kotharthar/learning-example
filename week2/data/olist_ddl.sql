-- Download all the CSV files from (https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
-- and put into the folder week2/data
-- olist_customers_dataset.csv
DROP TABLE IF EXISTS olist_customers;
CREATE TABLE olist_customers (
    customer_id VARCHAR PRIMARY KEY,
    customer_unique_id VARCHAR NOT NULL,
    customer_zip_code_prefix VARCHAR NOT NULL,
    customer_city VARCHAR NOT NULL,
    customer_state CHAR(2) NOT NULL
);

-- olist_geolocation_dataset.csv
DROP TABLE IF EXISTS olist_geolocation;
CREATE TABLE olist_geolocation (
    geolocation_zip_code_prefix VARCHAR(5) NOT NULL,
    geolocation_lat DOUBLE PRECISION NOT NULL,
    geolocation_lng DOUBLE PRECISION NOT NULL,
    geolocation_city VARCHAR NOT NULL,
    geolocation_state CHAR(2) NOT NULL
);

-- olist_order_items_dataset.csv
DROP TABLE IF EXISTS olist_order_items;
CREATE TABLE olist_order_items (
    order_id VARCHAR NOT NULL,
    order_item_id INTEGER NOT NULL,
    product_id VARCHAR NOT NULL,
    seller_id VARCHAR NOT NULL,
    shipping_limit_date TIMESTAMP NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    freight_value NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY (order_id, order_item_id)
);

-- olist_order_payments_dataset.csv
DROP TABLE IF EXISTS olist_order_payments;
CREATE TABLE olist_order_payments (
    order_id VARCHAR NOT NULL,
    payment_sequential INTEGER NOT NULL,
    payment_type VARCHAR NOT NULL,
    payment_installments INTEGER NOT NULL,
    payment_value NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY (order_id, payment_sequential)
);

-- olist_order_reviews_dataset.csv
DROP TABLE IF EXISTS olist_order_reviews;
CREATE TABLE olist_order_reviews (
    review_id VARCHAR NOT NULL,
    order_id VARCHAR NOT NULL,
    review_score INTEGER NOT NULL,
    review_comment_title VARCHAR,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP NOT NULL,
    review_answer_timestamp TIMESTAMP NOT NULL
);

-- olist_orders_dataset.csv
DROP TABLE IF EXISTS olist_orders;
CREATE TABLE olist_orders (
    order_id VARCHAR PRIMARY KEY,
    customer_id VARCHAR NOT NULL,
    order_status VARCHAR NOT NULL,
    order_purchase_timestamp TIMESTAMP NOT NULL,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP NOT NULL
);

-- olist_products_dataset.csv
DROP TABLE IF EXISTS olist_products;
CREATE TABLE olist_products (
    product_id VARCHAR PRIMARY KEY,
    product_category_name VARCHAR,
    product_name_length INTEGER,
    product_description_length INTEGER,
    product_photos_qty INTEGER,
    product_weight_g INTEGER,
    product_length_cm INTEGER,
    product_height_cm INTEGER,
    product_width_cm INTEGER
);

-- olist_sellers_dataset.csv
DROP TABLE IF EXISTS olist_sellers;
CREATE TABLE olist_sellers (
    seller_id VARCHAR PRIMARY KEY,
    seller_zip_code_prefix VARCHAR NOT NULL,R
    seller_city VARCHAR NOT NULL,
    seller_state CHAR(2) NOT NULL
);

-- product_category_name_translation.csv
DROP TABLE IF EXISTS product_category_name_translation;
CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR PRIMARY KEY,
    product_category_name_english VARCHAR NOT NULL
);


-- Linking olist_orders & olist_order_reviews on order_id
ALTER TABLE olist_order_reviews
ADD FOREIGN KEY (order_id) REFERENCES olist_orders (order_id);

-- Linking olist_orders & olist_order_payments on order_id
ALTER TABLE olist_order_payments
ADD FOREIGN KEY (order_id) REFERENCES olist_orders (order_id);

-- Linking olist_orders & olist_customers on customer_id
ALTER TABLE olist_orders
ADD FOREIGN KEY (customer_id) REFERENCES olist_customers (customer_id);

-- Linking olist_orders & olist_order_items on order_id
ALTER TABLE olist_order_items
ADD FOREIGN KEY (order_id) REFERENCES olist_orders (order_id);

-- Linking olist_order_items & olist_products on product_id
ALTER TABLE olist_order_items
ADD FOREIGN KEY (product_id) REFERENCES olist_products (product_id);

-- Linking olist_order_items & olist_sellers on seller_id
ALTER TABLE olist_order_items
ADD FOREIGN KEY (seller_id) REFERENCES olist_sellers (seller_id);

-- Linking olist_geolocation and olist_customers on customer_zip_code_prefix
ALTER TABLE olist_customers
ADD FOREIGN KEY (customer_zip_code_prefix) REFERENCES olist_geolocation (geolocation_zip_code_prefix);

ALTER TABLE olist_customers
DROP CONSTRAINT olist_customers_customer_zip_code_prefix_fkey;

ALTER TABLE olist_order_items
DROP CONSTRAINT olist_order_items_seller_id_fkey;

ALTER TABLE olist_order_items
DROP CONSTRAINT olist_order_items_product_id_fkey;

ALTER TABLE olist_order_items
DROP CONSTRAINT olist_order_items_order_id_fkey;

ALTER TABLE olist_orders
DROP CONSTRAINT olist_orders_customer_id_fkey;

ALTER TABLE olist_order_payments
DROP CONSTRAINT olist_order_payments_order_id_fkey;

ALTER TABLE olist_order_reviews
DROP CONSTRAINT olist_order_reviews_order_id_fkey;