#1) Create a view named list_of_customers, it should contain the following columns:
#customer id
#customer full name,
#address
#zip code
#phone
#city
#country
#status (when active column is 1 show it as 'active', otherwise is 'inactive')
#store id

create view list_of_customers as
	select c.customer_id, concat(first_name," ", last_name) as full_name, address,
		postal_code, phone, city, country,
        case when `active` = 1
			 then "active"
			else "inactive"
        end as `status`, store_id
	from customer c
		join address a using(address_id)
		join city cty using(city_id)
		join country ctry using(country_id);

#2) Create a view named film_details, it should contain the following columns:
#film id, title, description, category, price, length, rating,
#actors - as a string of all the actors separated by comma. Hint use GROUP_CONCAT

create view film_details as
	select film_id, title, `description`, group_concat(distinct c.`name`) as categories,
		replacement_cost as price, `length`, rating,
        group_concat(concat_ws(" ", a.first_name, a.last_name) separator ", ")
	from film f
		join film_category fc using(film_id)
		join category c using(category_id)
		join film_actor fa using(film_id)
		join actor a using(actor_id)
	group by film_id;

#3) Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.

create view sales_by_film_category as
	select c.`name`, sum(amount) as total_rental
    from category c
		join film_category fc using(category_id)
		join film f using(film_id)
		join inventory i using(film_id)
		join rental r using(inventory_id)
		join payment p using(rental_id)
	group by c.name;

#4) Create a view called actor_information where it should return,
#actor id, first name, last name and the amount of films he/she acted on.

create view actor_information as
	select actor_id, first_name, last_name,
		(select count(film_id)
		 from film_actor fa
		 where fa.actor_id = a.actor_id) as amount_of_films_acted
	from actor a

                                             
    