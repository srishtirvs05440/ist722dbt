with stg_categories as (
    select * from {{ source('northwind','Categories')}}
)
select {{ dbt_utils.generate_surrogate_key(['stg_categories.categoryid']) }} as 
categorykey,
stg_categories.*
  FROM stg_categories