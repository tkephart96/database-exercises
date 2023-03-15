use employees;
select database();
show tables;

-- 1
select concat(e.first_name, ' ', e.last_name) as employee
	,de.dept_no,e.hire_date,de.to_date
	,de.to_date > now() as is_current_employee
from employees as e
join dept_emp as de
	using(emp_no)
;
select concat(e.first_name, ' ', e.last_name) as employee
	,de.dept_no,e.hire_date,de.to_date
	,if(ed.empdate > now(),1,0) as is_current_employee
from (
select emp_no, max(to_date) as empdate
from dept_emp
group by emp_no
) as ed
join employees as e using(emp_no)
join dept_emp as de on ed.empdate = de.to_date
;

-- 2
select substr(employee,12)
	,case 
		when substr(employee,12,1) <= 'H'
			then 'A-H'
		when substr(employee,12,1) <= 'Q'
			then 'I-Q'
		 else 'R-Z'
	end as alpha_group
from (
	select employee-- , count(emp_no)
	from (
		select *, concat(gender,birth_date,last_name, ', ', first_name) as employee
		from employees
		group by emp_no
		) as e
	group by employee
    -- order by count(emp_no) desc
	) as em
;

-- 3 182885 born in 1950s, 117134 born in 1960s
-- has dupes from rehires (182886 in 1950s, 117138 in 1960s)
select count(emp_no) as emps, birth_decade
from (
select emp_no
	,case 
		when left(birth_date,3) = 195 
			then '1950s'
		when left(birth_date,3) = 196
			then '1960s'
            else 'younger'
	end as birth_decade
from employees
) as bc
group by birth_decade
;
-- does not have dupes
select count(employee) as emps
	,case 
		when substr(employee,2,3) = 195 
			then '1950s'
		when substr(employee,2,3) = 196
			then '1960s'
            else 'younger'
	end as birth_decade
from (
	select employee-- , count(emp_no)
	from (
		select *, concat(gender,birth_date,first_name, ' ', last_name) as employee
		from employees
		group by emp_no
		) as e
	group by employee
    -- order by count(emp_no) desc
	) as em
group by birth_decade
;

-- 4
select case
		   when d.dept_name in ('research', 'development') then 'R&D'
		   when d.dept_name in ('sales', 'marketing') then 'Sales & Marketing'
		   when d.dept_name in ('Production', 'Quality Management') then 'Prod & QM'
		   when d.dept_name in ('Finance', 'Human Resources') then 'Finance & HR'
		   else d.dept_name
	   end as dept_group
    , round(avg(s.salary),0) as avg_salary
	from dept_emp as de
	join departments as d
		on de.dept_no = d.dept_no
	join salaries as s
		on de.emp_no = s.emp_no
        and s.to_date > now()
        and de.to_date > now()
    group by dept_group
;



