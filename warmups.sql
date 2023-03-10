show databases;
use chipotle;
select database();
show tables;
select * from orders;

select * from orders where item_name in ('Chicken Bowl','Veggie Bowl');
select * from orders where quantity > 1 and item_name in ('Chicken Bowl','Veggie Bowl');

select soundex('all');
select soundex('ball');
select 'all' sounds like 'ball';


