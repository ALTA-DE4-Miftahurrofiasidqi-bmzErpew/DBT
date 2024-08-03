SELECT 
    DATE(orders.order_date) as order_date,
    products.name AS product_name,
    brands.name AS brand_name,
    SUM(order_details.quantity) AS qty_sold,
    SUM(order_details.price * order_details.quantity) AS revenue
FROM {{ source('store', 'orders') }} orders
JOIN {{ source('store', 'order_details') }} as order_details
    ON orders.order_id = order_details.order_id
JOIN {{ source('store', 'products') }} as products
    ON products.product_id = order_details.product_id
JOIN {{ source('store', 'brands') }} as brands
    ON brands.brand_id = products.brand_id
GROUP BY 
    orders.order_date, 
    products.name, 
    brands.name
ORDER BY 
    orders.order_date
