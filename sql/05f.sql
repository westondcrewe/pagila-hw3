/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
select f1.title
from film f1
join film_actor fa1 on fa1.film_id = f1.film_id
join film_actor fa2 on fa2.actor_id = fa1.actor_id
join film f2 on f2.film_id = fa2.film_id
where f2.title = 'AMERICAN CIRCUS'
intersect
select f3.title
from film f3
join film_category fc1 on fc1.film_id = f3.film_id
join film_category fc2 on fc2.category_id = fc1.category_id
join film f4 on f4.film_id = fc2.film_id
where f4.title = 'AMERICAN CIRCUS'
group by f3.title
having count(f3.title) > 1
order by title;
