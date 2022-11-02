USE sakila;

#1) Create a user data_analyst
CREATE USER data_analyst@localhost IDENTIFIED BY 'password';

#2) Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.

GRANT SELECT, UPDATE, DELETE ON sakila.* TO data_analyst@localhost WITH GRANT OPTION;

SHOW GRANTS FOR data_analyst@localhost;

#3) Login with this user and try to create a table. Show the result of that operation.

#Error Code: 1142. CREATE command denied to user 'data_analyst'@'localhost' for table 'hola'

#4) Try to update a title of a film. Write the update script.

SELECT title FROM film WHERE film_id = 86;

UPDATE film SET title = 'Argentina 1985' WHERE film_id = 86;

#5) With root or any admin user revoke the UPDATE permission. Write the command

REVOKE UPDATE ON sakila.* FROM data_analyst@localhost;

#Login again with data_analyst and try again the update done in step 4. Show the result.

#Error Code: 1142. UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'
