/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
/*
select distinct a1.first_name || ' ' || a1.last_name as "Actor Name"
from actor a1
join film_actor fa1 using (actor_id)
join film_actor fa2 using (film_id)
join actor a2 on a2.actor_id = fa2.actor_id
where a2.first_name = 'RUSSELL' and a2.last_name = 'BACALL'
and a1.first_name || ' ' || a1.last_name != 'RUSSELL BACALL'
order by "Actor Name";
select a1.first_name || ' ' || a1.last_name as "Actor Name"
from actor a1
join film_actor fa1 using (actor_id)
join film_actor fa2 on fa2.film_id = fa1.film_id
join film_actor fa3 on fa3.actor_id = fa2.actor_id
join actor a2 on a2.actor_id = fa3.actor_id
where a2.first_name = 'RUSSELL' and a2.last_name = 'BACALL'
and a1.actor_id not in (
	select distinct fa4.actor_id
	from film_actor fa4
	where fa4.film_id in (
		select distinct film_id
		from film_actor
		where actor_id = a2.actor_id
	)
);

*/

select a1.first_name || ' ' || a1.last_name as "Actor Name"
from actor a1
join (
	select fa1.actor_id
	from film_actor fa1
	join film_actor fa2 using (film_id)
	join film_actor fa3 on fa3.actor_id = fa2.actor_id
	join film_actor fa4 on fa4.film_id = fa4.film_id
	join actor a2 on a2.actor_id = fa4.actor_id
        where a2.first_name = 'RUSSELL' and a2.last_name = 'BACALL'
	except
	select fa5.actor_id 
	from film_actor fa5
	join film_actor fa6 using (film_id)
	join actor a2 on fa6.actor_id = a2.actor_id
	where a2.first_name = 'RUSSELL' and a2.last_name = 'BACALL'
) sub using (actor_id)
order by a1.first_name || ' ' || a1.last_name;
