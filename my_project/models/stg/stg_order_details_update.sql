with base as (
    select 
        date(orders.order_date) as order_date,
        order_details.quantity,
        order_details.price,
        brands.name as brand_name,
        products.name as product_name,
        {{ normalize_phone_number('orders.customer_phone') }} AS normalized_phone
    from {{ source('store', 'orders') }} as orders
    left join {{ source('store', 'order_details') }} as order_details
        on orders.order_id = order_details.order_id
    left join {{ source('store', 'products') }} as products
        on order_details.product_id = products.product_id
    left join {{ source('store', 'brands') }} as brands
        on products.brand_id = brands.brand_id
)
select 
    *,
    case
        WHEN left(normalized_phone, 2) = '62' then 'Indonesia'
        WHEN left(normalized_phone, 2) = '91' then 'India'
        else normalized_phone
    end as country 
from base