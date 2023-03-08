show databases;
use albums_db;
select database();
show tables;
use employees;
select database();
show tables;
select * from employees;
show create table employees;

/*
CREATE TABLE `employees` (
  `emp_no` int NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
*/

-- 10 int date varchar enum
-- 11 salaries for sure and maybe all have an employee id number column
-- 12 probably all tables but salary since it can have just numbers and maybe date
-- 13 probably all tables but department unless you maybe have the date department was created
-- 14 dept_no and emp_no are used in the dept_emp table
/* 15
CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1
*/
show create table dept_manager;

