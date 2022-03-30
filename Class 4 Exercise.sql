use sakila;
#1) Show title and special_features of films that are PG-13
select title, special_features from film 
	where rating = "PG-13";

#2) Get a list of all the different films duration.
select distinct(`length`) from film;

#3) Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00
select title, rental_rate, replacement_cost from film 
	where replacement_cost between 20.00 and 24.00;

#4) Show title, category and rating of films that have 'Behind the Scenes' as special_features
select f.title, c.`name` as "category", f.rating from film_category fc
	join film f on fc.film_id = f.film_id
    join category c on fc.category_id = c.category_id
	where f.special_features like "%Behind the Scenes%";

#5) Show first name and last name of actors that acted in 'ZOOLANDER FICTION'
select a.first_name, a.last_name from film_actor fa
	join film f on fa.film_id = f.film_id
    join actor a on fa.actor_id = a.actor_id
    where f.title = "ZOOLANDER FICTION";

#6) Show the address, city and country of the store with id 1
select a.address, ci.city, co.country from store s
	join address a on s.address_id = a.address_id
    join city ci on a.city_id = ci.city_id
    join country co on ci.country_id = co.country_id
    where s.store_id = 1;

#7) Show pair of film titles and rating of films that have the same rating.
select rating from film group by rating;

#8) Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).
select distinct(f.title), sf.first_name, sf.last_name from inventory i
	join store st on i.store_id = st.store_id
    join film f on i.film_id = f.film_id
    join staff sf on st.manager_staff_id = sf.staff_id
    where i.store_id = 2;