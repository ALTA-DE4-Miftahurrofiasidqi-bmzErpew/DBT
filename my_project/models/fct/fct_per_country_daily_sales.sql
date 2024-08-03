select
    country,
    order_date,
    SUM(quantity) as total_quantity,
    SUM(price * quantity) as total_revenue
from {{ ref('stg_order_details_update') }}
group by order_date, country
order by order_date, country
