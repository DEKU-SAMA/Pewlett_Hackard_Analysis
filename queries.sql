-- Creating tables for PH-EmployeeDB
-- Each .csv is going to need a table
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
	emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (dept_no, emp_no)    
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR	NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL
);

CREATE TABLE titles ( 
	emp_no INT NOT NULL, 
	title VARCHAR NOT NULL, 
	from_date DATE NOT NULL, 
	to_date DATE NOT NULL, 
	FOREIGN KEY (emp_no) REFERENCES salaries (emp_no)
); 

SELECT * FROM dept_manager;

-- Employees Born From 1952 - 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';
	
-- Employees Born in 1952
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Employees Born in 1953
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

--Employees Born in 1954
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- Employees Born in 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31'); 

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Create a basic Table for Employess elgible for Retirement
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check Retirement Table
SELECT * FROM retirement_info;
-- Delete Basic Table 
DROP TABLE retirement_info;

-- Create New Table for Retiring Employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the Table
SELECT * FROM retirement_info;

-- Inner Joining departments and dept_manager tables
SELECT departments.dept_name,dept_manager.emp_no,dept_manager.from_date,
	dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Inner Joining departments and dept_manager tables. Done W/ Aliases
SELECT d.dept_name,dm.emp_no,dm.from_date,dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Left Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,retirement_info.first_name,retirement_info.last_name,dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Left Joining retirement_info and dept_emp tables. Done W/ Aliases
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
    de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Check the Table
SELECT * FROM current_emp;

-- Employee count by department number. Done W/ Aliases
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--7.3.5 Queries

-- Make sure salries aligns with employment date
SELECT * FROM salaries;

--  Make sure salries aligns with employment date, filtered in decending order
SELECT * FROM salaries
ORDER BY to_date DESC;

--List 1: Employee Information
SELECT emp_no,first_name,last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the retirement_info Table 
SELECT * FROM retirement_info;

-- Creating Employee Information List
SELECT emp_no,first_name,last_name,gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the Employee Information Table
SELECT * FROM emp_info;

-- Join the 3 tables holding all the employee information. Done W/ Aliases
SELECT e.emp_no,e.first_name,e.last_name,e.gender,s.salary,de.to_date
INTO emp_info              -- Create a new table to hold the data  
FROM employees as e
INNER JOIN salaries as s   -- First join employees to salary on emp_no
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de  -- Second join employees to dept_emp on emp_no
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- Check to make sure your new table has properly joined all 3 tables
SELECT * FROM emp_info;

--List 2: Management
-- List of managers per department. Done W/ Aliases
SELECT  dm.dept_no,d.dept_name,dm.emp_no,ce.last_name,ce.first_name,dm.from_date,dm.to_date
INTO manager_info
FROM dept_manager AS dm
INNER JOIN departments AS d
ON (dm.dept_no = d.dept_no)
INNER JOIN current_emp AS ce
ON (dm.emp_no = ce.emp_no);

-- Check the Management Table Info
SELECT * FROM manager_info;

-- List 3: Department Retirees
-- An updated current_emp list, but also has the employee's departments. Done W/ Aliases
SELECT  ce.emp_no,ce.first_name,ce.last_name,d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- Check the "Department Retirees" Table
SELECT * FROM dept_info;

-- 7.3.6 Queries 

-- Get All of the Retirees from the Sales Departnent
select * 
from dept_info
where dept_name = 'Sales';

-- Get All of the Retirees from The Sales and Development Department
SELECT * 
FROM dept_info
WHERE dept_name IN ('Sales', 'Development')
ORDER BY dept_name;