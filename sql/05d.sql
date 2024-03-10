/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */
select title
from (
        select f1.title
        from film f1
        join film_actor fa1 using (film_id)
        join film_actor fa2 using (actor_id)
        join film f2 on f2.film_id = fa2.film_id
        where f2.title = 'AMERICAN CIRCUS'
        intersect
        select f1.title
        from film f1
        join film_actor fa1 using (film_id)
        join film_actor fa2 using (actor_id)
        join film f2 on f2.film_id = fa2.film_id
        where f2.title = 'ACADEMY DINOSAUR'
        intersect
        select f1.title
        from film f1
        join film_actor fa1 using (film_id)
        join film_actor fa2 using (actor_id)
        join film f2 on f2.film_id = fa2.film_id
        where f2.title = 'AGENT TRUMAN'
) movie
order by title;
