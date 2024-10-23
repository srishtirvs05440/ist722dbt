with stg_shippers as (
    select * from {{ source('northwind','Shippers')}}
)
select  {{ dbt_utils.generate_surrogate_key(['stg_shippers.shipperid']) }} as shipperkey, 
    stg_shippers.* 
from stg_shippers
