--Tampilkan 10 pelanggan dengan total penjualan tertinggi dan tampilkan informasi detail mengenai pelanggan (full_name, email, address, phone, city, country, total_penjualan_tertinggi)


with customer_list as (
SELECT c.customer_id ,  
      Concat(c.first_name, ' ', c.last_name) AS full_name,
       c.email,
       a.address,
       a.phone,
       ci.city,
       co.country
FROM   customer c
       LEFT JOIN address a
              ON c.address_id = a.address_id
       LEFT JOIN city ci
              ON ci.city_id = a.city_id
       LEFT JOIN country co
              ON co.country_id = ci.country_id
              ) ,
              
payment_list as (
select p.customer_id,p.amount from payment p
)

select cl.full_name ,cl.email,cl.address,cl.phone,cl.city ,sum(pl.amount) as payment_total
from customer_list cl left join payment_list pl on cl.customer_id = pl.customer_id
group by cl.full_name ,cl.email,cl.address,cl.phone,cl.city
order by payment_total desc
limit 10