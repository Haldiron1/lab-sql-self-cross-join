use sakila;

-- Get all pairs of actors that worked together.
SELECT a1.actor_id AS actor1_id, a1.first_name AS actor1_first_name, a1.last_name AS actor1_last_name,
       a2.actor_id AS actor2_id, a2.first_name AS actor2_first_name, a2.last_name AS actor2_last_name,
       f.title AS movie_title
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id -- Join on the film_id to find common movies
JOIN actor a1 ON fa1.actor_id = a1.actor_id -- Join to retrieve details of actor1
JOIN actor a2 ON fa2.actor_id = a2.actor_id -- Join to retrieve details of actor2
JOIN film f ON fa1.film_id = f.film_id -- Join to retrieve the movie title
WHERE a1.actor_id < a2.actor_id; -- To avoid duplicates and to get pairs in a consistent order

-- Get all pairs of customers that have rented the same film more than 3 times.
SELECT c1.customer_id AS customer1_id, c1.first_name AS customer1_first_name, c1.last_name AS customer1_last_name,
       c2.customer_id AS customer2_id, c2.first_name AS customer2_first_name, c2.last_name AS customer2_last_name,
       f.film_id, f.title AS film_title, COUNT(*) AS rental_count
FROM rental r
JOIN customer c1 ON r.customer_id = c1.customer_id
JOIN inventory i1 ON r.inventory_id = i1.inventory_id
JOIN film f ON i1.film_id = f.film_id
JOIN inventory i2 ON f.film_id = i2.film_id -- Self-join to find different customers
JOIN rental r2 ON i2.inventory_id = r2.inventory_id AND r2.customer_id <> c1.customer_id
JOIN customer c2 ON r2.customer_id = c2.customer_id
GROUP BY c1.customer_id, c1.first_name, c1.last_name, c2.customer_id, c2.first_name, c2.last_name, f.film_id, f.title
HAVING COUNT(*) > 3
ORDER BY rental_count DESC;

-- Now Get all possible pairs of actors and films.
SELECT a.actor_id, a.first_name AS actor_first_name, a.last_name as actor_last_name, f.title AS film_title
FROM actor a
CROSS JOIN film f;

select * from actor;









