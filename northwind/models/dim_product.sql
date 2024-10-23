with stg_products as (
    select * from {{source('northwind','Products')}}
),
stg_categories as (
    select * from {{source('northwind','Categories')}}
),
stg_suppliers as (
    select * from {{source('northwind','Suppliers')}}
)
select 
    {{ dbt_utils.generate_surrogate_key(['p.ProductID']) }} 
       as productkey, 
       ProductID, 
       ProductName, 
       s.SupplierID
    ,CategoryName, 
    [Description] as categorydescription
  FROM stg_products p 
     join stg_categories c on p.CategoryID = c.CategoryID
     join stg_suppliers s on p.SupplierID = s.SupplierID
