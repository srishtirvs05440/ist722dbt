with stg_orders as (
    select * from {{source('northwind', 'Orders')}}
), 
stg_customers as (
    select * from {{source('northwind','Customers')}}
),
stg_employees as (
    select * from {{source('northwind','Employees')}}
),
stg_shippers as (
    select * from {{source('northwind','Shippers')}}
)
select 
    {{ dbt_utils.generate_surrogate_key(['o.OrderId']) }} 
       as orderkey, 
    o.OrderId,
    o.employeeid,
    o.customerid,
    o.orderdate,
    o.ShipVia,
    o.RequiredDate,
    o.ShippedDate, 
    o.Freight,
    o.ShipName, 
    o.ShipAddress,
    o.ShipCity,
    o.ShipRegion,
    o.ShipPostalCode,
    o.ShipCountry
from stg_orders o
    join stg_customers c on c.customerid = o.customerid
    join stg_employees e on e.employeeid = o.employeeid
    join stg_shippers sh on sh.shipperid = o.ShipVia
