--- SQL
SELECT 
    c.customer_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    AVG(oi.price) AS average_order_value,
	pc.product_category_name,
    AVG(r.review_score) AS average_review_score,
    c.customer_state AS state,
    c.customer_city AS city
FROM 
    olist_customers c
JOIN 
    olist_orders o ON c.customer_id = o.customer_id
LEFT JOIN 
    olist_order_items oi ON o.order_id = oi.order_id
LEFT JOIN 
    olist_order_reviews r ON o.order_id = r.order_id
LEFT JOIN (
    SELECT 
        oi.order_id,
        p.product_category_name,
        RANK() OVER (PARTITION BY oi.order_id ORDER BY COUNT(oi.product_id) DESC) as rank
    FROM 
        olist_order_items oi
    JOIN 
        olist_products p ON oi.product_id = p.product_id
    GROUP BY 
        oi.order_id, p.product_category_name
) pc ON o.order_id = pc.order_id AND pc.rank = 1
GROUP BY 
    c.customer_id, pc.product_category_name, c.customer_state, c.customer_city;


--- OLAP SQL

CREATE TABLE customer_purchase_behavior (
    customer_id String,
    total_orders UInt32,
    average_order_value Float64,
    most_frequent_product_category String,
    average_review_score Float32,
    state String,
    city String
) ENGINE = MergeTree()
ORDER BY (customer_id);
