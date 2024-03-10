/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */
select first_name, last_name
from actor
join (
	select distinct actor_id
	from film_actor
	join film using (film_id)
	join film_category using (film_id)
	join category using (category_id)
	where name = 'Children'
) as children using (actor_id)
where actor_id not in (
	select actor_id
	from film_actor
	join film using (film_id)
        join film_category using (film_id)
	join category using (category_id)
	where name = 'Horror'
)
order by last_name;
