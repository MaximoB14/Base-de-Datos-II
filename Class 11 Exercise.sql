use sakila;
#4) Find all the film titles that are not in the inventory.
select title
from film
where film_id not in (select film.film_id
						from film
                        inner join inventory using(film_id));

#5) Find all the films that are in the inventory but were never rented.
# -Show title and inventory_id.
# -This exercise is complicated.
# -hint: use sub-queries in FROM and in WHERE or use left join and ask if one of the fields is null

select distinct title, i.inventory_id
from inventory i
inner join film f using(film_id)
where f.film_id not in (select f.film_id
						from rental r
                        inner join inventory i on r.inventory_id = i.inventory_id
                        inner join film f on i.film_id = f.film_id);

#6) Generate a report with:
# -customer (first, last) name, store id, film title,
# -when the film was rented and returned for each of these customers
# -order by store_id, customer last_name

select first_name, last_name, s.store_id, title, rental_date, return_date
from rental r
inner join customer c using(customer_id) #on r.customer_id = c.customer_id
inner join store s using(store_id) #on c.store_id = s.store_id
inner join inventory i using(inventory_id) #on r.inventory_id = i.inventory_id
inner join film f using(film_id) #on i.film_id = f.film_id
order by store_id, last_name;

#7) Show sales per store (money of rented films)
# -show store's city, country, manager info and total sales (money)
# -(optional) Use concat to show city and country and manager first and last name

select distinct str.store_id, city, country,
	concat(first_name, " ", last_name) as manager,
	(select sum(amount)
		from payment p 
        where p.staff_id = str.manager_staff_id) as "Listado de pagos"
from staff stf
inner join store str on stf.staff_id = str.manager_staff_id
inner join address a on str.address_id = a.address_id
inner join city using(city_id)
inner join country using(country_id);


#8)Which actor has appeared in the most films?
select first_name, last_name, count(fa.film_id) as films_acted
from actor 
inner join film_actor fa using(actor_id)
group by fa.actor_id
order by films_acted desc
limit 1;

