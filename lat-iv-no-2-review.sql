WITH 
cust AS (
    SELECT *, first_name || ' ' || last_name AS full_name
    FROM customer c
)
SELECT
    full_name,
    email,
    address,
    phone,
    city,
    country,
    SUM(amount) AS total_payment
FROM cust
JOIN address a USING(address_id)
JOIN city USING(city_id)
JOIN country USING(country_id)
JOIN payment USING(customer_id)
GROUP BY 1, 2, 3, 4, 5, 6
ORDER BY 7 DESC
LIMIT 5