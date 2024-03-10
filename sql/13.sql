/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */
select *
from (
	select actor_id, first_name, last_name, film_id, title,
		rank() over (
			partition by actor_id 
			order by sum(amount) desc, film_id
		) as rank,
		sum(amount) as revenue
		from actor
		join film_actor using (actor_id)
		join film using (film_id)
		join inventory using (film_id)
		join rental using (inventory_id)
		join payment using (rental_id)
		group by 1, 2, 3, 4, 5
		order by 1, 6
	) sub
	where rank < 4
