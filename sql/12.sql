/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
select customer.customer_id, customer.first_name, customer.last_name
from customer
left join lateral (
	select customer_id, category_id
	from rental
	join inventory using (inventory_id)
	join film using (film_id)
	join film_category using (film_id)
	join category using (category_id)
	where name = 'Action'
	and rental.customer_id = customer.customer_id
	limit 5
) recent on true
group by customer.customer_id
having count(case when category_id = 
	(select category_id from category where name = 'Action') 
	then 1 end) > 3
order by customer_id;
