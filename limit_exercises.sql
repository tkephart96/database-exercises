use employees;
select database();
show tables;
select * from employees;

-- 2
select distinct last_name from employees order by last_name desc limit 10;
/* 3
Alselm Cappello
Utz Mandell
Bouchung Schreiter
Baocai Kushner
Petter Stroustrup
*/
select * from employees where hire_date like '199%' and birth_date like '%12-25' order by hire_date limit 5;
-- 4 LIMIT sets the page length, while OFFSET sets the start of the page
select * from employees where hire_date like '199%' and birth_date like '%12-25' order by hire_date limit 5 offset 45;



