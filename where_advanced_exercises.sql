use employees;
select database();
show tables;
show create table employees;
select * from employees;
-- 1 10200, 10397, 10610
select emp_no, first_name from employees where first_name in ('Irena', 'Vidya', 'Maya');
-- 2 10200, 10397, 10610. it does match
select emp_no, first_name from employees where first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya';
-- 3 10200, 10397, 10821
select emp_no, first_name from employees where gender = 'M' and (first_name = 'Irena' or first_name = 'Vidya' or first_name = 'Maya');
-- 4 
select distinct last_name from employees where last_name like 'e%';
-- 5
select distinct last_name from employees where last_name like 'e%' or last_name like '%e';
-- 6
select distinct last_name from employees where last_name not like 'e%' and last_name like '%e';
-- 7
select distinct last_name from employees where last_name like 'e%' and last_name like '%e';
select distinct last_name from employees where last_name like 'e%e';
-- 8 10008, 10011, 10012
select emp_no, hire_date from employees where hire_date like '199%';
-- 9 10078, 10115, 10261
select emp_no, birth_date from employees where birth_date like '%12-25';
-- 10 10261, 10438, 10681
select emp_no, birth_date, hire_date from employees where hire_date like '199%' and birth_date like '%12-25';
-- 11
select distinct last_name from employees where last_name like '%q%';
-- 12
select distinct last_name from employees where last_name like '%q%' and last_name not like '%qu%';


-- LIKE does work on integer
select * from employees where emp_no like '1000%';