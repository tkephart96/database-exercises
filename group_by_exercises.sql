use employees;
select database();
show tables;
show create table employees;
select * from titles;

-- 2 unique titles 7
select distinct title from titles;
-- 3
select last_name
	from employees 
	where last_name 
    like 'e%e'
    group by last_name
;
-- 4
select first_name,last_name
	from employees 
	where last_name 
    like 'e%e'
    group by first_name,last_name
;
-- 5 Chelq, Lindqvist, Qiwen
select last_name
	from employees 
    where last_name 
    like '%q%' 
    and last_name 
    not like '%qu%'
    group by last_name
;
-- 6
select last_name, count(*)
	from employees 
    where last_name 
    like '%q%' 
    and last_name 
    not like '%qu%'
    group by last_name
;
-- 7
select first_name,gender,count(*)
	from employees 
    where first_name 
    in ('Irena', 'Vidya', 'Maya')
    group by first_name, gender
;
-- 8
select lower(concat(
	left(first_name,1),left(last_name,4)
    ,date_format(birth_date, '_%m%y')
	)) as username
    ,count(*)
	from employees
    group by username
;
-- 9 there are dupes, most dupes 6x, 13251 unique dupes, 27403 total dupes
select lower(concat( -- show dupes
		left(first_name,1),left(last_name,4)
		,date_format(birth_date,'_%m%y')
		)) as username
	,count(*) as duplicate
	from employees
    group by username
    having duplicate > 1
    order by duplicate desc
;
select count(*) -- count unique dupes
	from (select lower(concat(
		left(first_name,1),left(last_name,4)
		,date_format(birth_date,'_%m%y')
		)) as username,count(*) as duplicate
		from employees
		group by username
		having duplicate > 1) 
	as uniq_dupes
;
select sum(duplicate) -- count total dupes
	from (select lower(concat(
		left(first_name,1),left(last_name,4)
		,date_format(birth_date,'_%m%y')
		)) as username,count(*) as duplicate
		from employees
		group by username
		having duplicate > 1) 
	as tot_dupes
;

-- BONUS
show tables;
select * from salaries;
-- 
select emp_no, avg(salary)
	from salaries
    where to_date < now()
    group by emp_no
;
-- 
select * from dept_emp;
select dept_no, count(*) as emp_count
	from dept_emp
    where to_date > now()
    group by dept_no
;
-- 
select emp_no, count(salary)
	from salaries
    group by emp_no
;
-- 
select emp_no, max(salary)
	from salaries
    group by emp_no
;
--
select emp_no, min(salary)
	from salaries
    group by emp_no
;
-- 
select emp_no, std(salary) as std_dev_sal
	from salaries
    -- where to_date < now()
    group by emp_no
;
-- 
select emp_no, max(salary) as max_salary
	from salaries
    group by emp_no
    having max_salary > 150000
;
-- 
select emp_no, avg(salary) as avg_salary
	from salaries
    group by emp_no
    having avg_salary between 80000 and 90000
;




