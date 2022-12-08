use sakila;

-- Create a query or queries to extract the information you think may be relevant for building the prediction model. 
-- It should include some film features and some rental features. Use the data from 2005.


SELECT film.rental_duration, film.rating, film.rental_rate, film.length, film.replacement_cost, category.name, film.special_features FROM film
JOIN film_category
USING(film_id)
JOIN category
USING(category_id);

-- Create a query to get the list of films and a boolean indicating if it was rented last month (mai 2005). This would be our target variable


SELECT count(*) FROM rental
where rental_date BETWEEN '2005-05-01' AND '2005-05-31'
;
SELECT count(*) FROM rental
WHERE rental_date LIKE '%2005-05%';


CREATE TEMPORARY TABLE rentedmay AS (
    SELECT film_id, f.title FROM rental r
    JOIN inventory i USING (inventory_id)
    JOIN film f USING (film_id)
    WHERE rental_date LIKE '%2005-05%'
    GROUP BY film_id
    ORDER BY rental_date
);


SELECT f.rental_duration, f.rental_rate, f.length, f.rating, fc.category_id, film_id, re.title FROM film f
JOIN film_category fc
USING (film_id)
LEFT JOIN rentedmay re
USING (film_id)
ORDER BY film_id;


SELECT f.rental_duration, f.rental_rate, f.length, f.rating, fc.category_id, film_id, re.title FROM film f
JOIN film_category fc
USING (film_id)
LEFT JOIN (SELECT film_id, f.title FROM rental r
    JOIN inventory i USING (inventory_id)
    JOIN film f USING (film_id)
    WHERE rental_date LIKE '%2005-05%'
    GROUP BY film_id
    ORDER BY rental_date) AS re
USING (film_id)
ORDER BY film_id;










SELECT r.rental_date, i.inventory_id, film_id, f.title FROM rental r
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id)
WHERE rental_date LIKE '%2005-05%'
GROUP BY film_id
ORDER BY rental_date;



SELECT film_id, f.title FROM rental r
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id)
WHERE rental_date LIKE '%%2005-05%%'
GROUP BY film_id
ORDER BY rental_date
;





SELECT r.rental_date, i.inventory_id, film_id, f.title, count(film_id), i.inventory_id FROM rental r
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id)
WHERE rental_date BETWEEN '2005-05-01' AND '2005-05-31'
GROUP BY film_id
ORDER BY rental_date;


SELECT r.rental_date, film_id, f.title, count(film_id), f.special_features, f.rating, f.length, f.rental_rate FROM rental r
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id)
WHERE rental_date LIKE '%%2005%%'
GROUP BY film_id
ORDER BY rental_date;


select distinct f.title, 
CASE
    WHEN (sum(case when date_format((r.rental_date), "%%M") = "May" and date_format((r.rental_date), "%%Y") = 2005
    then True else False
END )) >= 1 then 1 else 0 end as rented_last_month
from film f
join inventory i on i.film_id = f.film_id
join rental r using(inventory_id)
group by f.title;



SELECT film.rental_duration, film.rating, film.rental_rate, film.length, film.replacement_cost, category.name, film.special_features, film.title 
FROM film
JOIN film_category
USING(film_id)
JOIN category
USING(category_id)
;

SELECT film.rental_duration, film.rating, film.rental_rate, film.length, film.replacement_cost, category.name, film.special_features, film.title 
FROM rental
JOIN inventory
USING(inventory_id)
JOIN film
USING(film_id)
JOIN film_category
USING(film_id)
JOIN category
USING(category_id)
WHERE convert(rental_date, DATE) BETWEEN '2005-05-01' AND '2005-05-31';

SELECT r.rental_date, i.inventory_id, film_id, f.title, count(film_id), i.inventory_id FROM rental r
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id)
JOIN film_category
USING(film_id)
JOIN category 
USING(category_id)
WHERE rental_date BETWEEN '2005-05-01' AND '2005-05-31'
GROUP BY film_id
ORDER BY rental_date;