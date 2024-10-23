with stg_territories as (
    select * from {{ source('northwind','Territories')}}
)
select {{ dbt_utils.generate_surrogate_key(['stg_territories.territoryid']) }} as 
territorykey,
stg_territories.*
  FROM stg_territories
