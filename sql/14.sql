/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
select name, title, "total rentals"
from (
	select name, title, count(*) as "total rentals",
		rank () over (
			partition by name 
			order by count(*) desc, title desc
		) as rank
	from category
	join film_category using (category_id)
	join film using (film_id)
	join inventory using (film_id)
	join rental using (inventory_id)
	group by name, title
) sub 
where rank < 6
order by name, "total rentals" desc, title;
