select s.store_id, round(sum(p.amount),0) as 'sales_amount'
from store s
join inventory i on i.store_id = s.store_id
join rental r on r.inventory_id = i.inventory_id
join payment p on  p.rental_id = r.rental_id
group by s.store_id;

delimiter //
create procedure store_business()
select s.store_id, round(sum(p.amount),0) as 'sales_amount'
from store s
join inventory i on i.store_id = s.store_id
join rental r on r.inventory_id = i.inventory_id
join payment p on  p.rental_id = r.rental_id
group by s.store_id;

end;
//
delimiter ;

call store_business

#question 3

delimiter //
create procedure store_business2(in store int)
select s.store_id, round(sum(p.amount),0) as 'sales_amount'
from store s
join inventory i on i.store_id = s.store_id
join rental r on r.inventory_id = i.inventory_id
join payment p on  p.rental_id = r.rental_id
where s.store_id=store
group by s.store_id;

end;
//
delimiter ;

call store_business2(2)

#question 4

delimiter //
create procedure store_business3(in store int)
begin
declare total_sales_value float;
select round(sum(p.amount),0) into total_sales_value
from store s
join inventory i on i.store_id = s.store_id
join rental r on r.inventory_id = i.inventory_id
join payment p on  p.rental_id = r.rental_id
where s.store_id=store
group by s.store_id;
select total_sales_value;

end;
//
delimiter ;

call store_business3(2);

#Question 5

drop procedure if exists pro_sales_store;

delimiter //
create procedure pro_sales_store(In param_store int)
begin
  	select s.store_id, round(sum(p.amount),0) as 'sales_amount',
  	case
    when sum(p.amount) > 30000 then "green flag"
  	when sum(p.amount) < 30000 then "red_flag"
  	end as sales_flag
	from store s
	join inventory i on i.store_id = s.store_id
	join rental r on r.inventory_id = i.inventory_id
	join payment p on  p.rental_id = r.rental_id
	where s.store_id = param_store
	group by s.store_id;
end;
// delimiter ;

call pro_sales_store(2);
