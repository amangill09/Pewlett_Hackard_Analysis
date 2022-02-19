SELECT emp_no, first_name, last_name FROM employees;

SELECT title, from_date, to_date FROM titles;

--join emp and titles and insert into new table
SELECT e.emp_no, first_name, last_name, title, from_date, to_date 
INTO retirement_titles
FROM employees e
INNER JOIN titles t on t.emp_no = e.emp_no

--filter data by birthdate
SELECT rt.* 
INTO retirement_titles_1
FROM retirement_titles rt
INNER JOIN employees e ON 
	e.emp_no = rt.emp_no
where EXTRACT(YEAR FROM e.birth_date) BETWEEN '1952' and '1955'
ORDER BY emp_no

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO retirement_titles_2
FROM retirement_titles_1
ORDER BY emp_no, from_date DESC;

SELECT rt2.* 
INTO unique_titles
FROM retirement_titles_2 rt2
INNER JOIN titles t ON t.emp_no = rt2.emp_no
WHERE t.to_date = '9999-01-01'
ORDER BY 1

SELECT COUNT(title) count, title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count desc

SELECT * FROM retiring_titles

SELECT emp_no,birth_date, first_name, last_name,gender, hire_date FROM employees
SELECT emp_no,dept_no, from_date, to_date FROM dept_emp where emp_no = '10291'
SELECT emp_no, title, from_date, to_date FROM titles where emp_no = '10291'

SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name,e.birth_date, de.from_date, de.to_date,title
INTO mentorship_eligibilty
FROM employees e
INNER JOIN dept_emp de ON de.emp_no = e.emp_no
INNER JOIN titles t ON t.emp_no = e.emp_no
WHERE 	de.to_date = '9999-01-01'
		AND birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no, de.from_date DESC

SELECT * FROM mentorship_eligibilty