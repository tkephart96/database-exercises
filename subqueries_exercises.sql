use employees;
select database();
show tables;

-- 1 
select * 
from employees as e
join salaries as s
	on s.emp_no = e.emp_no
where hire_date = (
	select hire_date
    from employees
	where emp_no = 101010
    )
    and s.to_date > now()
;

-- 2
select title 
from titles
where emp_no in (
	select emp_no
    from employees
    where first_name = 'Aamod'
    )
	and to_date > now()
    group by title
;

-- 3 59900 employees no longer w/company
select count(emp_no)
from employees
where emp_no not in (
	select emp_no
    from dept_emp
    where to_date > now()
    )
;
-- 4 Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil
select *
from employees
where emp_no in (
	select emp_no
    from dept_manager
    where to_date > now()
    )
    and gender = 'F'
;

-- 5
select *
from employees
where emp_no in (
	select emp_no
	from salaries
	where to_date > now()
		and salary > (
		select avg(salary)
		from salaries
		)
	)
;

-- 6 83 current salaries within 1 std of max current salary, .0346% for current .0029% for all salaries
select count(salary) as wthn_std_max
	, concat(round((count(salary)
    / (select count(salary) 
	from salaries 
	-- where to_date > now()
	) * 100),4),'%') as percentage
from salaries
where salary > (
	select max(salary) - std(salary)
	from salaries
	where to_date > now()
	)
    and to_date > now()
;

-- Bonus
-- 1
select dept_name
from departments
where dept_no in (
	select dept_no
    from dept_manager
    where emp_no in (
		select emp_no
        from employees
        where gender = 'F'
        ) and to_date > now()
	)
;

-- 2 Tokuyasu Pesch
select first_name, last_name
from employees
where emp_no in (
	select emp_no
    from salaries
    where salary = (
		select max(salary)
        from salaries
        )
    )
;

-- 3 Sales
select dept_name
from departments
where dept_no in (
	select dept_no
    from dept_emp
	where emp_no in (
		select emp_no
		from salaries
		where salary = (
			select max(salary)
			from salaries
			)
		)
	)
;

-- 4
select * from employees, departments, dept_emp, salaries;
select d.dept_name
	,concat(e.first_name,' ',e.last_name) as empployee
    ,s.salary
    from salaries as s
    join dept_emp as de using(emp_no)
    join employees as e using(emp_no)
    join departments as d using(dept_no)
    join (select max(salary) as maxsal
			,dept_no
            from salaries as s
            join dept_emp as de using(emp_no)
            group by de.dept_no
            ) as dsal
            on dsal.maxsal = s.salary and dsal.dept_no = de.dept_no
;




