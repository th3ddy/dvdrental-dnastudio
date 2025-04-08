WITH rent AS (
    SELECT
        *,
        date_part('day', return_date - rental_date) AS date_difference
    FROM rental
),
status AS (
    SELECT
        rental_duration,
        date_difference,
        CASE
            WHEN rental_duration > date_difference THEN 'Kembali Lebih Awal'
            WHEN rental_duration = date_difference THEN 'Kembali Tepat Waktu'
            ELSE 'Terlambat'
        END AS Return_status
    FROM film f
    JOIN inventory i USING(film_id)
    JOIN rent USING(inventory_id)
)

SELECT
    Return_status,
    count(*) AS total_jumlah_film
FROM status
GROUP BY 1
ORDER BY 2 DESC

