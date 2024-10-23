with stg_suppliers as (
    select * from {{source('northwind','Suppliers')}}
)
select 
    {{ dbt_utils.generate_surrogate_key(['s.supplierid']) }} 
       as supplierkey,
       supplierID, CompanyName as suppliercompanyname
      ,ContactName as suppliercontactname
      ,ContactTitle as suppliercontacttitle 
      ,Address as supplieraddress
      ,City as suppliercity, Region as supplierregion
      ,PostalCode as supplierpostalcode
      ,Country as suppliercountry
      ,Phone as supplierphone, Fax as supplierfax
      ,HomePage as supplierhomepage
  FROM stg_suppliers s
