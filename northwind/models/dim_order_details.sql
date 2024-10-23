with stg_order_details as (
    select * from {{source('northwind', 'Order_Details')}}
),
stg_orders as (
    select * from {{source('northwind', 'Orders')}}
),
stg_products as (
    select * from {{source('northwind', 'Products')}}
)
select 
{{ dbt_utils.generate_surrogate_key(['od.OrderId']) }} 
       as orderkey, 
       o.orderID, 
       p.ProductID, 
       od.UnitPrice, 
       od.Quantity,
       od.Discount
    FROM stg_order_details od 
     join stg_orders o on o.orderID = od.orderID
     join stg_products p on p.ProductID = od.ProductID