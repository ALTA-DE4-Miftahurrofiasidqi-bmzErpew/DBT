select 
    brand_name,
    order_date,
    SUM(quantity) as total_quantity,
    SUM(price * quantity) as total_revenue
from 
    {{ref('stg_order_details')}}
group by 
    brand_name, 
    order_date