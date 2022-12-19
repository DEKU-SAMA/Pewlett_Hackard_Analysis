-- DELIVERABLE 1
-- Create a Joint Table from 'employee' and 'titles' to Get a List of Retirees 
-- (Employees Born: 1952-1955) and Their Titles. Done W/ Aliases
SELECT e.emp_no,e.first_name,e.last_name,ti.title,ti.from_date,ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no
;

-- Check the "retirement_titles" Table
SELECT * FROM retirement_titles;

-- Extract Any Duplicates From the retirement_titles Table
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, from_date DESC
;

-- Check the "unique_titles" Table
SELECT * FROM unique_titles;

-- Group the Count of Retirees by title
SELECT COUNT(title) count, title
INTO retiring_titles
FROM unique_titles
GROUP BY (title) 
ORDER BY count DESC
;

-- Check the "retiring_titles" Table
SELECT * FROM retiring_titles;

-- DELIVERABLE 2
-- Create a Mentorship Eligibility Table for Current Employees Who 
-- Were Born Between January 1, 1965 and December 31, 1965
SELECT DISTINCT ON (emp_no),e.emp_no,e.first_name,e.last_name,e.birth_date,de.from_date,de.to_date,ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND de.to_date = '9999-01-01'
ORDER BY emp_no, ti.from_date DESC
;

-- Check the "mentorship_eligibility" Table
SELECT * FROM mentorship_eligibility;

-- ADDITIONAL QUERIES
-- Create  a List for the Number of Eligible Mentors Grouped by Title 
SELECT COUNT(title) count, title
INTO mentor_count_title
FROM mentorship_eligibility
GROUP BY (title) 
ORDER BY count DESC

-- Check the "mentor_count_title" Table
SELECT * FROM mentor_count_title;

-- Create a Table for Current Employees Eligible for Retirement 
SELECT DISTINCT ON (emp_no),ce.emp_no,ce.first_name,ce.last_name,ti.title,ti.from_date,ti.to_date
INTO current_retirement_titles
FROM current_emp as ce
INNER JOIN titles as ti
ON ce.emp_no = ti.emp_no
ORDER BY emp_no, from_date DESC
;

-- Check the "current_retirement_titles" Table
SELECT * FROM current_retirement_titles;

-- Check the "current_retirement_titles" Table
SELECT * FROM current_retirement_titles;

-- Create a Table for the Title Count for Current Employees
SELECT COUNT(title) count, title
INTO current_count_title
FROM current_retirement_titles
GROUP BY (title) 
ORDER BY count DESC;