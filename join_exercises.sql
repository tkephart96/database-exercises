use join_example_db;
select database();
show tables;

-- Join Example DB
-- 1
select * 
	from users, roles
;
-- 2
select users.name, roles.name as role
	from users
    join roles on users.role_id = roles.id
;
select users.name, roles.name as role
	from users
    left join roles on users.role_id = roles.id
;
select users.name, roles.name as role
	from users
    right join roles on users.role_id = roles.id
;
-- 3
select roles.name as role, count(users.name)
	from users
    right join roles on users.role_id = roles.id
    group by role
;

-- Employees DB
-- 1
use employees;
select database();
-- 2
show tables;
select * from departments, dept_manager, employees;
select d.dept_name as department
	, concat(e.first_name, ' ', e.last_name) as manager
	from employees as e
	join dept_manager as dm
		on e.emp_no = dm.emp_no
	join departments as d
		on dm.dept_no = d.dept_no
	where dm.to_date > now()
    order by department
;
-- 3
select d.dept_name as department
	, concat(e.first_name, ' ', e.last_name) as manager
	from employees as e
	join dept_manager as dm
		on e.emp_no = dm.emp_no
	join departments as d
		on dm.dept_no = d.dept_no
	where dm.to_date > now()
		and gender = 'F'
    order by department
;
-- 4
select * from titles, dept_emp, departments;
select t.title
	, count(t.emp_no) as count
	from titles as t
	join dept_emp as de
		on t.emp_no = de.emp_no
	where de.to_date > now()
		and t.to_date > now()
		and de.dept_no = 'd009'
    group by title
    order by title
;
-- 5
select * from departments, dept_manager, employees, salaries;
select d.dept_name as department
	, concat(e.first_name, ' ', e.last_name) as manager
    , s.salary
	from employees as e
	join dept_manager as dm
		on e.emp_no = dm.emp_no
	join departments as d
		on dm.dept_no = d.dept_no
	join salaries as s
		on e.emp_no = s.emp_no
	where dm.to_date > now()
		and s.to_date > now()
    order by department
;
-- 6
select * from departments, dept_emp, employees;
select d.dept_no
	, d.dept_name as department
	, count(de.emp_no) as count
	from employees as e
	join dept_emp as de
		on e.emp_no = de.emp_no
	join departments as d
		on de.dept_no = d.dept_no
	where de.to_date > now()
    group by dept_no
    order by dept_no
;
-- 7 sales
select * from departments, dept_emp, salaries;
select d.dept_name as department
    , avg(s.salary) as avg_salary
	from dept_emp as de
	join departments as d
		on de.dept_no = d.dept_no
	join salaries as s
		on de.emp_no = s.emp_no
	where s.to_date > now() and de.to_date > now()
    group by department
    order by avg_salary desc
    limit 1
;
-- 8 Akemi Warwick
select * from departments, dept_emp, employees, salaries;
select e.first_name
    , e.last_name
    -- , s.salary
	from dept_emp as de
    join employees as e
		on de.emp_no = e.emp_no
	join departments as d
		on de.dept_no = d.dept_no
	join salaries as s
		on de.emp_no = s.emp_no
	where s.to_date > now()
		and de.to_date > now()
		and d.dept_no = 'd001'
    order by s.salary desc
    limit 1
;
-- 9 Vishwani Minakawa
select * from departments, dept_manager, employees, salaries;
select e.first_name
    , e.last_name
    , s.salary
    , d.dept_name
	from dept_manager as dm
    join employees as e
		on dm.emp_no = e.emp_no
	join departments as d
		on dm.dept_no = d.dept_no
	join salaries as s
		on dm.emp_no = s.emp_no
	where s.to_date > now()
		and dm.to_date > now()
    order by s.salary desc
    limit 1
;
-- 10 
select * from departments, dept_emp, salaries;
select d.dept_name as department
    , round(avg(s.salary),0) as avg_salary
	from dept_emp as de
	join departments as d
		on de.dept_no = d.dept_no
	join salaries as s
		on de.emp_no = s.emp_no
    group by department
    order by avg_salary desc
;
-- 11 Bonus
select * from departments, dept_manager, dept_emp, employees;
select -- count(*) 
	emp.employee, emp.dept, mgr.manager
	from ( -- emp and dept
	select concat(e.first_name, ' ', e.last_name) as employee
			, d.dept_name as dept
		from employees as e
		join dept_emp as de
			on de.emp_no = e.emp_no
		join departments as d
			on d.dept_no = de.dept_no
		where de.to_date > now()
		order by dept
	) as emp
	join ( -- dept and mgr
	select d.dept_name as dept
		,concat(e.first_name, ' ', e.last_name) as manager
		from dept_manager as dm
		join employees as e
			on dm.emp_no = e.emp_no
		join departments as d
			on d.dept_no = dm.dept_no
		where dm.to_date > now()
		order by dept
	) as mgr
		on emp.dept = mgr.dept
;

-- 12 Bonus: Who is the highest paid employee for each department?
select * from employees, departments, dept_emp, salaries;
select empsal.employee, dptsal.dept, dptsal.max_salary
from ( -- dept and sal
	select d.dept_name as dept
		, max(s.salary) as max_salary
		from dept_emp as de
		join departments as d
			on de.dept_no = d.dept_no
		join salaries as s
			on de.emp_no = s.emp_no
		where s.to_date > now() and de.to_date > now()
		group by dept
		) as dptsal
	join ( -- emp and sal
	select concat(e.first_name, ' ', e.last_name) as employee
		, max(s.salary) as max_salary
		from dept_emp as de
		join employees as e
			on e.emp_no = de.emp_no
		join salaries as s
			on de.emp_no = s.emp_no
		where s.to_date > now() and de.to_date > now()
		group by employee
		) as empsal
			on empsal.max_salary = dptsal.max_salary
;
