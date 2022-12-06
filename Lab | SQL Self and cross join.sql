use sakila;

-- 1

select a.first_name, a.last_name, f.film_id from actor a
join film_actor f on a.actor_id = f.actor_id
where a.actor_id = f.actor_id
order by f.film_id
limit 100;

-- 2

select * from rental;
select * from inventory;

select * from (
	select distinct film_id ,customer_id
	from rental r
	inner join inventory i
    on r.inventory_id = i.inventory_id
	group by customer_id, film_id
	having count(film_id) >= 2
    ) sub1
cross join (
	select distinct customer_id
	from rental r
	inner join inventory i
    on r.inventory_id = i.inventory_id
	group by customer_id, film_id
	having count(film_id) >= 2
    ) sub2
where sub1.customer_id <> sub2.customer_id
order by film_id asc
limit 1000;

-- 3

select * from film_actor;

select * from (
	select film_id, actor_id from film_actor
    group by film_id, actor_id
    having count(film_id) >= 1
    ) sub1
cross join (
	select distinct actor_id from film_actor
    group by film_id, actor_id
	having count(film_id) >= 1
    ) sub2
where sub1.actor_id <> sub2.actor_id
limit 1000;


