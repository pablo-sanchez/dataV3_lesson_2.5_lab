use sakila;
-- 1.Select all the actors with the first name ‘Scarlett’.
select actor_id, first_name from sakila.actor
where first_name = 'Scarlett';

-- 2.How many films (movies) are available for rent and how many films have been rented?
select rental_id, rental_date, return_date from sakila.rental
where return_date > rental_date;
 -- There are 15.861 films that have been returned, so they are available to be rented


-- 3.What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select MIN(length) as min_duration,  MAX(length) as max_duration from sakila.film;


-- 4.What's the average movie duration expressed in format (hours, minutes)?
select sec_to_time(round(AVG(length*60))) as average_duration from sakila.film; -- I got seconds as well.

-- 5.How many distinct (different) actors' last names are there?
select count(distinct(last_name)) as amount_of_dif_last_names from sakila.actor;

-- 6.Since how many days has the company been operating (check DATEDIFF() function)?
select datediff(Max(payment_date), Min(payment_date)) as days_operating from payment;
select datediff(Max(rental_date), Min(rental_date)) as days_operating from rental;
-- Both approaches should be valid and returns the same result (266 days)

select datediff(Max(last_update), Min(rental_date)) as days_operating from rental;
/* However, if we assume that the last update day is the end of the opetarions, 
the result will be slightly higher (275 days)*/

-- 7.Show rental info with additional columns month and weekday. Get 20 results.
select *, substring(rental_date, 6, 5) as month_and_weekday_rental, substring(return_date, 6, 5) as month_and_weekday_return,
substring(last_update, 6, 5) as month_and_weekday_last_update from rental LIMIT 20;
/* I wasn't sure if I had to apply this just to rental_date columns of all column with dates. 
In case I had to apply this just to rental_date column I will just need to eliminate the 
modifications applied to return_date and last_update columns. However, if I had misunderstood the question 
and I need just to get 2 different columns (one called month and the other called day) from rental_date 
I could do the following:
*/
select *, dayname(rental_date) as weekday, monthname(rental_date) as month from rental
limit 20; -- this is if we want the output as a string
select *, substring(rental_date, 9, 2) as day, substring(rental_date, 6, 2) as month from rental
limit 20; -- and in this way if we want the output as the number of the month
select *, weekday(rental_date) as weekday, substring(rental_date, 6, 2) as month from rental
limit 20; -- even in this way if we want it as a number (being 0 = Monday, 1 = Tuesday ... 6 = Sunday)

/* 8.Add an additional column day_type with values 'weekend' and 'workday' 
depending on the rental day of the week. */
select *,  if(weekday(rental_date) IN (0,1,2,3,4), 'workday','weekend') as day_type from rental;

-- 9.Get release years.
select distinct(release_year) from film;

-- 10.Get all films with ARMAGEDDON in the title.
select title from film
where title like '%ARMAGEDDON%';

-- 11.Get all films which title ends with APOLLO.
select title from film
where title regexp 'APOLLO$';

-- 12.Get 10 the longest films.
select title, length from film
order by length desc limit 10;

-- 13.How many films include Behind the Scenes content?
select count(special_features) as films_with_behind_the_scenes_content from film
where special_features like '%Behind the Scenes%';
