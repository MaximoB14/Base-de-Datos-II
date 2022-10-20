use sakila;
#1) Write a query that gets all the customers that live in Argentina.
#Show the first and last name in one column, the address and the city.

select concat(first_name, " ", last_name) as full_name, address, city
from customer
	join address using(address_id)
	join city using(city_id)
	join country using(country_id)
where country like "Argentina";

#2) Write a query that shows the film title, language and rating. 
#Rating shall be shown as the full text described here: https://en.wikipedia.org/wiki/Motion_picture_content_rating_system#United_States. 
#Hint: use case.

select title, `name` as "language",
case
	when rating = "G" then "G (General Audiences) – All ages admitted."
    when rating = "PG" then "PG (Parental Guidance Suggested) – Some material may not be suitable for children."
    when rating = "PG-13" then "PG-13 (Parents Strongly Cautioned) – Some material may be inappropriate for children under 13."
    when rating = "R" then "R (Restricted) – Under 17 requires accompanying parent or adult guardian."
    when rating = "NC-17" then "NC-17 (Adults Only) – No one 17 and under admitted."
end as "rating"
from film
	join `language` using(language_id);

#3) Write a search query that shows all the films (title and release year) an actor was part of.
#Assume the actor comes from a text box introduced by hand from a web page. 
#Make sure to "adjust" the input text to try to find the films as effectively as you think is possible.

select title, release_year
from film
	join film_actor using(film_id)
    join actor using(actor_id)
where concat_ws(" ", first_name, last_name) like trim(upper("Ed ChAsE"));

#4) Find all the rentals done in the months of May and June.
#Show the film title, customer name and if it was returned or not.
#There should be returned column with two possible values 'Yes' and 'No'.

select title, 
	concat_ws(" ", first_name, last_name) as "costumer name",
	case
		when return_date is null then "No"
        else "Yes"
	end "Returned"
from rental
	join inventory using(inventory_id)
    join film using(film_id)
    join customer using(customer_id)
where month(rental_date) = 5 or month(rental_date) = 6;

#5) Investigate CAST and CONVERT functions. 
#Explain the differences if any, write examples based on sakila DB.

# CAST Function: The CAST() function converts a value (of any type) into the specified datatype.
# CONVERT Function: The CONVERT() function converts a value into the specified datatype or character set.

# Differeces:
# CONVERT Function it also allows you to convert character set of data into another character set. CAST Function cannot be used to change character set.

# Examples of usage:

# CAST Function.
# Compare between this query
SELECT last_update FROM film LIMIT 10;

# And this query
SELECT CAST(last_update AS DATE) FROM film LIMIT 10;

# We can see that the hour-minute-second in the second case is eliminated.

# CONVERT Function.
# Compare between this query
SELECT rental_date FROM rental LIMIT 10;

# And this query
SELECT CONVERT(rental_date, TIME) FROM rental LIMIT 10;

# We can see that in the second query, the year-month-day is eliminated

#6) Investigate NVL, ISNULL, IFNULL, COALESCE, etc type of function.
#Explain what they do. Which ones are not in MySql and write usage examples.

# All the functions above (NVL, ISNULL, IFNULL, COALCE) let you return an alternative value if an expression is NULL.

# The difference is that each of them are used in different DBMS (Examples: MySQL, SQL Server, Oracle...)

# In MySQL, we only have IFNULL and COALESCE. Thus, NVL and ISNULL are not in MySQL

# Examples of usage:

# IFNULL
SELECT address_id, address, IFNULL(address2, "Alternative value") FROM address LIMIT 10;

# COALESCE
SELECT address_id, address, COALESCE(address2, "Alternative value") FROM address LIMIT 10;