
--Tampilkan status pengembalian film dan total jumlah film.Berapa banyak film sewaan yang dikembalikan terlambat, lebih awal dan tepat waktu?


WITH rentalstatus AS (
    SELECT 
        r.rental_id,
        r.inventory_id,
        r.rental_date,
        r.return_date,
        EXTRACT(DAY FROM (return_date - rental_date)) AS selisih_hari,
        CASE 
            WHEN r.return_date IS NULL THEN 'a. Belum Dikembalikan'
            WHEN EXTRACT(DAY FROM (return_date - rental_date)) = 0 THEN 'b. Pengembalian Tepat Waktu'
            WHEN EXTRACT(DAY FROM (return_date - rental_date)) < 0 THEN 'c. Pengembalian Lebih Awal'
            WHEN EXTRACT(DAY FROM (return_date - rental_date)) > 0 THEN 'd. Pengembalian Terlambat'
        END AS status_pengembalian
    FROM rental r
),
status_categories AS (
    SELECT status
    FROM (VALUES 
        ('a. Belum Dikembalikan'), 
        ('b. Pengembalian Tepat Waktu'), 
        ('c. Pengembalian Lebih Awal'), 
        ('d. Pengembalian Terlambat')
    ) AS categories(status)
)
SELECT 
    sc.status AS status_pengembalian,
    COALESCE(COUNT(rs.rental_id), 0) AS jumlah_film
FROM status_categories sc
LEFT JOIN rentalstatus rs ON sc.status = rs.status_pengembalian
GROUP BY sc.status
ORDER BY sc.status;