use sakila;

#1)----------------
select postal_code
from address
where 20000 < postal_code and postal_code < 80000
order by postal_code asc;
#0.016 sec

select *
from address a
join city cty on a.city_id = cty.city_id
join country ctry on cty.country_id = ctry.country_id
where postal_code % 2 = 0
order by ctry.country_id;
#0.015 sec

create index postalCode on address(postal_code);

#after indez duration:
#0.000
#0.000
#esto pasa porque index GOD

#2)----------------
select first_name
from actor
where first_name like "%ll%"
order by first_name;

select last_name
from actor
where last_name like "%ll%"
order by last_name;

#la query de last name se ejecuta más rápido porque tiene index e index GOD

#3)----------------

select `description`
from film
where `description` like "%epic%";

select `description`
from film_text
where match(`description`) against("epic");

#la query de film_text se ejecuta más rápido porque tiene index fulltext e index GOD