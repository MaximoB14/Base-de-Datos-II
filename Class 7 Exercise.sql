use sakila;

#1) Find the films with less duration, show the title and rating.

select title, rating
from film f1
where length <= ALL(select length
					  from film f2
                      where f1.film_id <> f2.film_id);

#2) Write a query that returns the tiltle of the film which duration is the lowest.
#If there are more than one film with the lowest duration, the query returns an empty resultset.

select title, rating
from film f1
where length < ALL(select length
					  from film f2
                      where f1.film_id <> f2.film_id);
                      
#3) Generate a report with list of customers showing the lowest payments done by each of them.
#Show customer information, the address and the lowest amount,
# provide both solution using ALL and/or ANY and MIN.

SELECT customer.customer_id, first_name, last_name, address,
       (SELECT DISTINCT amount 
		FROM payment 
		WHERE customer.customer_id = payment.customer_id 
           AND amount <= ALL (SELECT amount 
                                FROM payment 
                               WHERE customer.customer_id = payment.customer_id))
	   AS lowest_amount 
FROM customer, address
where address.address_id = customer.address_id
ORDER BY lowest_amount, customer.customer_id;

SELECT customer.customer_id, first_name, last_name, address,
	   (SELECT min(amount) 
		FROM payment 
		WHERE payment.customer_id = customer.customer_id)
		AS lowest_amount
FROM customer, address
where address.address_id = customer.address_id
ORDER BY lowest_amount, customer.customer_id;

#4) Generate a report that shows the customer's information with the highest payment 
# and the lowest payment in the same row.

select customer.customer_id, first_name, last_name, concat(max(amount),", ", min(amount)) as "highest and lowest payment"
from customer, payment
where customer.customer_id = payment.customer_id 
group by customer_id, first_name, last_name
        





