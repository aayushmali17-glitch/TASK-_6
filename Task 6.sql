-- Subquery in SELECT

-- Find each employee’s salary as a percentage of the maximum salary in the company.

SELECT name, salary,
       (salary * 100.0 / (SELECT MAX(salary) FROM Employees)) AS salary_percent
FROM Employees;

-- Subquery in WHERE

-- Find employees who earn more than the average salary.

SELECT name, salary
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- Subquery in FROM (Derived Table)

-- ind departments with their average salary, using a subquery as a temporary table.

SELECT d.dept_name, t.avg_salary
FROM Departments d
JOIN (
    SELECT dept_id, AVG(salary) AS avg_salary
    FROM Employees
    GROUP BY dept_id
) t
ON d.dept_id = t.dept_id;

-- Correlated Subquery

-- Find employees whose salary is the highest in their department.

SELECT e.name, e.salary, e.dept_id
FROM Employees e
WHERE e.salary = (
    SELECT MAX(salary)
    FROM Employees
    WHERE dept_id = e.dept_id
);