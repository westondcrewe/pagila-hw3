/*
 * Find every documentary film that is rated PG.
 * Report the title and the actors.
 *
 * HINT:
 * Getting the formatting right on this query can be tricky.
 * You are welcome to try to manually get the correct formatting.
 * But there is also a view in the database that contains the correct formatting,
 * and you can SELECT from that VIEW instead of constructing the entire query manually.
 */
select title, string_agg(name, ', ') as actors
from (
	select title, initcap(first_name) || initcap(last_name) as name
	from actor
	join film_actor using (actor_id)
	join film using (film_id)
	join film_category using (film_id)
	join category using (category_id)
	where film.rating = 'G' and category.name = 'Documentary'
) G_Doc
group by G_Doc.title
order by G_Doc.title;


