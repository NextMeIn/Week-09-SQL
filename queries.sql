--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from employees e inner join salaries s on e.emp_no = s.emp_no;

--2. List employees who were hired in 1986.
select e.first_name ||' '|| e.last_name
from dept_emp d inner join employees e on d.emp_no = e.emp_no
where date_part('year',d.from_date) = 1986
order by e.first_name;

--3. List the manager of each department with the following information: 
	-- department number, department name, the manager's employee number, last name, first name, 
	-- and start and end employment dates.
select dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
from dept_manager dm inner join employees e on dm.emp_no = e.emp_no
inner join departments d on dm.dept_no = d.dept_no;

--4. List the department of each employee with the following information: 
	-- employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
from (select distinct on (de.emp_no) emp_no, dept_no, from_date
		from dept_emp de
		group by de.emp_no, de.dept_no, de.from_date
		order by de.emp_no, de.from_date desc) dept 
inner join employees e on dept.emp_no = e.emp_no
inner join departments d on dept.dept_no = d.dept_no;

--5. List all employees whose first name is "Hercules" and last names begin with "B."
select e.first_name ||' '|| e.last_name
from employees e
where e.first_name = 'Hercules' and e.last_name like 'B%';

--6. List all employees in the Sales department, including their employee number, last name, 
	--first name, and department name.

select de.emp_no, e.last_name, e.first_name, d.dept_name
from dept_emp de inner join departments d on de.dept_no = d.dept_no
inner join employees e on de.emp_no = e.emp_no
where d.dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their 
	-- employee number, last name, first name, and department name.
	
select de.emp_no, e.last_name, e.first_name, d.dept_name
from dept_emp de inner join departments d on de.dept_no = d.dept_no
inner join employees e on de.emp_no = e.emp_no
where d.dept_name in ('Sales','Development');

--8. In descending order, list the frequency count of employee last names, 
	--i.e., how many employees share each last name.
select e.last_name, count(e.emp_no) count
from employees e
group by e.last_name
order by count(e.emp_no) desc;