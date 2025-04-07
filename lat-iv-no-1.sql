
--Tampilkan status pengembalian film dan total jumlah film.Berapa banyak film sewaan yang dikembalikan terlambat, lebih awal dan tepat waktu?


with rentalstatus as(
select r.rental_id,
r.inventory_id ,
r.rental_date ,
r.return_date,
extract(day from (return_date - rental_date)) as selisih_hari,
case when r.return_date is null then 'a. Belum Dikembalikan'
when extract(day from (return_date - rental_date)) = 0 then 'b. Pengembalian Tepat Waktu'
when extract(day from (return_date - rental_date)) < 0 then 'c. Pengembalian Lebih Awal'
when extract(day from (return_date - rental_date)) > 0 then 'd. Pengembalian Terlambat'
end as Status_Pengembalian
from rental r
)
select Status_Pengembalian, count(*) as jumlah_film from rentalstatus rs
group by Status_Pengembalian
order by Status_Pengembalian