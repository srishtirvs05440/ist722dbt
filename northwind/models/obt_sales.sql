with f_sales as (
    select * from {{ ref('fact_sales') }}
),
d_customer as (
    select * from {{ ref('dim_customer') }}
),
d_employee as (
    select * from {{ ref('dim_employee') }}
),
d_date as (
    select * from {{ ref('dim_date') }}
)
select
    d_customer.*, 
    d_employee.*, 
    d_date.*,
    sa.orderid, sa.orderdatekey, sa.quantity,
    sa.costprice, sa.discount, sa.sellingprice
 from f_sales as sa
    left join d_customer on sa.customerkey = d_customer.customerkey
    left join d_employee on sa.employeekey = d_employee.employeekey
    left join d_date on sa.orderdatekey = d_date.datekey