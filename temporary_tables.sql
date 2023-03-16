use pagel_2181;
use employees;
select database();

-- 1
create temporary table pagel_2181.employees_with_departments as
select e.first_name, e.last_name, d.dept_name
from employees as e
join dept_emp as de using(emp_no)
join departments as d using(dept_no)
where de.to_date > now()
;

select * from employees_with_departments;
describe employees_with_departments;
-- 1a
alter table employees_with_departments
add full_name varchar(30)
;
-- 1b
update employees_with_departments
set full_name = concat(first_name,' ',last_name)
;
-- 1c
alter table employees_with_departments
drop column first_name
;
alter table employees_with_departments
drop column last_name
;
-- 1d
create temporary table ewd as
select concat(first_name,' ',last_name), dept_name
from employees.employees
join employees.dept_emp using(emp_no)
join employees.departments using(dept_no)
where to_date > now()
;
describe ewd;
select * from ewd;

-- 2
use sakila;
select database();
show tables;
select * from payment;

create temporary table pagel_2181.sakila_payments as
select amount * 100 as cents from payment
;

use pagel_2181;
select database();
select * from sakila_payments;
describe sakila_payments;

alter table sakila_payments
modify cents int not null
;

-- 3 best dept sales, worst dept human resources
use employees;
use pagel_2181;
select database();

create temporary table pagel_2181.agg_sal as
select avg(salary) as avg_salary, std(salary) as std_salary from salaries where to_date > now()
;

create temporary table pagel_2181.dsal as
select d.dept_name
		,avg(s.salary) as avg_dsal
	from dept_emp as de
	join departments as d
		on de.dept_no = d.dept_no
	join salaries as s
		on de.emp_no = s.emp_no
	where s.to_date > now()
		and de.to_date > now()
	group by d.dept_name
;

alter table dsal
add avg_sal float
;
alter table dsal
add std_sal float
;
update dsal
set avg_sal = (select avg_salary from agg_sal)
;
update dsal
set std_sal = (select std_salary from agg_sal)
;
select * from dsal;

alter table dsal
add zscore_dsal float
;
update dsal
set zscore_dsal = ((avg_dsal - avg_sal) / std_sal)
;






