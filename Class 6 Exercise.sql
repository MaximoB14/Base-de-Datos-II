use sakila;

#1)List all the actors that share the last name. Show them in order.

select *
from actor a1
where exists (select * from actor a2
				where a1.last_name = a2.last_name
				and a1.actor_id <> a2.actor_id)
order by last_name;

#2)Find actors that don't work in any film.

select * 
from actor
where actor_id not in(select actor_id 
					  from film_actor);

#3) Find customers that rented only one film.

select * 
from customer c
where (select count(*) 
	   from rental r
	   where c.customer_id = r.customer_id) = 1;

#4) Find customers that rented more than one film

select *
from customer c
where (select count(*)
	   from rental r
	   where c.customer_id = r.customer_id) > 1;

#5) List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'

select *
from actor
where actor_id in (select actor_id
				   from film_actor
				   where film_id in (select film_id 
									 from film
									 where title like "BETRAYED REAR" 
                                        or title like "CATCH AMISTAD"));

#6) List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'

select * 
from actor
where actor_id in (select actor_id 
				   from film_actor
				   where film_id in (select film_id 
                                     from film
									 where title like "BETRAYED REAR")
					 and film_id not in(select film_id 
										from film
										where title like "CATCH AMISTAD"));

#7) List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'

select * 
from actor
where actor_id in (select actor_id 
				   from film_actor
				   where film_id in (select film_id 
									 from film
									 where title like "BETRAYED REAR")
					 and film_id in (select film_id
									 from film
									 where title like "CATCH AMISTAD"));

#8) List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'

select * 
from actor
where actor_id not in (select actor_id 
					   from film_actor
					   where film_id in (select film_id 
										 from film
										 where title like "BETRAYED REAR" 
                                            or title like "CATCH AMISTAD"));