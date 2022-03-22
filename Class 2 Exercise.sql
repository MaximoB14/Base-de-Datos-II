CREATE DATABASE IF NOT EXISTS imdb;
drop table if exists film_actor;
drop table if exists film;
drop table if exists actor;
USE imdb;

CREATE TABLE IF NOT EXISTS film(
	film_id int NOT NULL AUTO_INCREMENT,
	title varchar(255), description varchar(255),
	release_year year,
	PRIMARY KEY (film_id)
);

CREATE TABLE IF NOT EXISTS actor(
	actor_id int NOT NULL AUTO_INCREMENT,
	first_name varchar(255),
	last_name varchar(255),
	PRIMARY KEY (actor_id)
);

CREATE TABLE IF NOT EXISTS film_actor(
	film_id int,
	actor_id int,
    foreign key (film_id) references film (film_id),
    foreign key (actor_id) references actor (actor_id)
);

ALTER TABLE film ADD last_update date;
ALTER TABLE actor ADD last_update date;

ALTER TABLE film_actor ADD FOREIGN KEY (film_id) REFERENCES film (film_id);
ALTER TABLE film_actor ADD FOREIGN KEY (actor_id) REFERENCES actor (actor_id);

INSERT INTO film (title, description, release_year, last_update) VALUES ("Cars", "autos vivos", "2003", CURDATE());
INSERT INTO film (title, description, release_year, last_update) VALUES ("Star Wars", "guerras en el espacio", "2054", CURDATE());
INSERT INTO film (title, description, release_year, last_update) VALUES ("Uncharted", "cazar tesoros", "2022", CURDATE());

INSERT INTO actor (first_name, last_name, last_update) VALUES ("Pepe", "Mujica", CURDATE());
INSERT INTO actor (first_name, last_name, last_update) VALUES ("Mateo", "Lanzilotta", CURDATE());
INSERT INTO actor (first_name, last_name, last_update) VALUES ("Teo", "Teo", CURDATE());

INSERT INTO film_actor VALUES (1, 2);
INSERT INTO film_actor VALUES (2, 3);
INSERT INTO film_actor VALUES (3, 1);

select * from film;
select * from actor;
select * from film_actor;