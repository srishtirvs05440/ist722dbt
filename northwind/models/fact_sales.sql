with stg_orders as (
    select
        OrderID,  
        {{ dbt_utils.generate_surrogate_key(['employeeid']) }} as employeekey, 
        {{ dbt_utils.generate_surrogate_key(['customerid']) }} as customerkey, 
        replace(to_date(orderdate)::varchar,'-','')::int as orderdatekey
    from {{source('northwind','Orders')}}
), 
stg_order_details as (
    select 
        orderid,
        UnitPrice, 
        Quantity,
        Discount,
        sum(Quantity*UnitPrice) as costprice,
        sum(Quantity*UnitPrice*(1-Discount)) as sellingprice
    from {{source('northwind','Order_Details')}}
    group by orderid, UnitPrice, quantity, discount
)
select 
    o.*, 
    od.quantity,
    od.costprice,
    od.discount,
    od.sellingprice
from stg_orders o
    join stg_order_details od on o.orderid = od.orderid

