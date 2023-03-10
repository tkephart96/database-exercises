use employees;
select database();
show tables;
show create table employees;
select * from employees;
-- 2 
select concat(first_name,' ',last_name) 
	as full_name 
	from employees 
	where last_name 
    like 'e%e'
;
-- 3 
select upper(concat(first_name,' ',last_name)) 
	as full_name 
	from employees 
	where last_name 
    like 'e%e'
;
-- 4 
select count(concat(first_name,' ',last_name)) 
	as full_name 
	from employees 
	where last_name 
    like 'e%e'
;
-- 5 
select concat(first_name,' ',last_name) as full_name
    ,datediff(curdate(), hire_date) as days_hired
	,hire_date,birth_date
	from employees 
    where hire_date 
    like '199%' 
    and birth_date 
    like '%12-25' 
;
-- 6 
select min(salary),max(salary) 
	from salaries
	where to_date > now()
;
-- 7
select lower(
	concat(
	substr(first_name,1,1)
	,substr(last_name,1,4)
    ,'_'
    -- ,substr(birth_date,6,2)
    -- ,substr(birth_date,3,2)
    ,date_format(birth_date, '%m%y')
	))
    as username
    ,first_name,last_name,birth_date
	from employees
;


