use employees;
select database();
show tables;
show create table employees;
select * from employees;
-- 2 Irena Garrabrants, Vidya Simmen
select emp_no, first_name, last_name from employees where first_name in ('Irena', 'Vidya', 'Maya') order by first_name;
-- 3 Irena Acton, Vidya Zweizig
select first_name, last_name from employees where first_name in ('Irena', 'Vidya', 'Maya') order by first_name, last_name;
-- 4 Irena Acton, Maya Zyda
select first_name, last_name from employees where first_name in ('Irena', 'Vidya', 'Maya') order by last_name, first_name;
-- 5 899 employees, 10021 Ramzi Erde, 499648 Tadahiro Erde
select emp_no, first_name, last_name from employees where last_name like 'e%' and last_name like '%e' order by emp_no;
-- 6 899 employees, newest-hire Teiji Eldridge, oldest-hire Sergi Erde
select first_name, last_name, hire_date from employees where last_name like 'e%' and last_name like '%e' order by hire_date desc;
-- 7 362 employees, oldest newhire Khun Bernini, youngest oldhire Douadi Pettis
select * from employees where hire_date like '199%' and birth_date like '%12-25' order by birth_date, hire_date desc;

