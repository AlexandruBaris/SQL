-- Write a query to display: 
-- 1. the first name, last name, salary, and job grade for all employees.
SELECT first_name, last_name, salary, job_title
FROM employees
         LEFT JOIN jobs USING (job_id);

-- 2. the first and last name, department, city, and state province for each employee.
SELECT first_name, last_name, department_name, city, state_province
FROM employees
         LEFT JOIN departments USING (department_id)
         LEFT JOIN locations USING (location_id);


-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
SELECT A.first_name, A.last_name, A.department_id, B.department_name
FROM employees A
         JOIN departments B
              ON A.department_id = B.department_id
                  AND A.department_id IN (80, 40);

-- 4. those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
SELECT A.first_name, A.last_name, B.department_name, C.city, C.state_province
FROM employees A
         JOIN departments B on
    A.department_id = B.department_id
         JOIN locations C
              on B.location_id = C.location_id
WHERE first_name LIKE '%z%';

-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT first_name, last_name, salary
FROM employees
WHERE salary < (SELECT salary FROM employees WHERE employee_id = 182);

-- 6. the first name of all employees including the first name of their manager.
SELECT A.first_name AS "Employee Name", B.first_name AS "Manager"
FROM employees A
         JOIN employees B ON A.manager_id = B.manager_id;

-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
SELECT A.first_name AS "Employee Name",
       B.first_name AS "Manager"
FROM employees A
         JOIN employees B
              ON A.manager_id = B.employee_id;

-- 8. the details of employees who manage a department.
SELECT *
FROM employees
WHERE employee_id = ANY (SELECT manager_id FROM departments);

-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
SELECT A.first_name, A.last_name, A.department_id
FROM employees A
         JOIN employees B
              ON A.department_id = B.department_id
                  AND B.last_name = 'Taylor';

--10. the department name and number of employees in each of the department.
SELECT department_name, COUNT(*) AS "Number of employees"
FROM departments
         JOIN employees ON employees.department_id = departments.department_id
GROUP BY employees.department_id, department_name;

--11. the name of the department, average salary and number of employees working in that department who got commission.
SELECT A.department_name, AVG(B.salary), COUNT(commission_pct)
FROM employees B
         JOIN departments A ON B.department_id = A.department_id
WHERE commission_pct IS NOT NULL
GROUP BY A.department_name;

--12. job title and average salary of employees.
SELECT job_title, AVG(salary)
FROM employees
         JOIN jobs USING (job_id)
GROUP BY job_title;

--13. the country name, city, and number of those departments where at least 2 employees are working.
SELECT country_name, city, COUNT(department_id)
FROM countries
         JOIN locations USING (country_id)
         JOIN departments USING (location_id)
WHERE department_id IN (
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING COUNT(employees.department_id) >= 2)
GROUP BY country_name, city;

--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
SELECT employee_id, job_title, end_date - job_history.start_date days
FROM job_history
         JOIN jobs ON job_history.job_id = jobs.job_id
WHERE department_id = 80;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT first_name, last_name
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE employee_id = 163);

--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
SELECT employee_id, first_name, last_name
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
SELECT first_name, last_name, employee_id, salary
FROM employees
WHERE manager_id = (SELECT employee_id FROM employees WHERE first_name = 'Payam');

--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
SELECT A.department_id, A.first_name, A.last_name, B.job_title, C.department_name
FROM employees A,
     jobs B,
     departments C
WHERE C.department_id = A.department_id
  AND C.department_name = 'Finance';

--19. all the information of an employee whose id is any of the number 134, 159 and 183.
SELECT *
FROM employees
WHERE employee_id IN (134, 159, 183);

--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
SELECT *
FROM employees
WHERE salary BETWEEN (
    SELECT MIN(salary)
    FROM employees
) AND 2500;

--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
SELECT *
FROM employees
WHERE department_id NOT IN (
    SELECT department_id
    FROM departments
    WHERE employees.manager_id BETWEEN 100 AND 200);

--22. all the information for those employees whose id is any id who earn the second highest salary.
SELECT *
FROM employees
WHERE employee_id IN (
    SELECT employee_id
    FROM employees
    WHERE salary = (
        SELECT MAX(salary)
        FROM employees
        WHERE salary < (
            SELECT MAX(salary)
            FROM employees
        )
    )
);

--23. the employee name( first name and last name ) and hire_date for all employees in the same department as Clara. Exclude Clara.
SELECT first_name, last_name, hire_date
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM employees
    WHERE first_name = 'Clara')
  AND first_name != 'Clara';

--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
SELECT employee_id, first_name, last_name
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM employees
    WHERE first_name LIKE '%T%'
);

--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.
SELECT E.first_name || ' ' || E.last_name AS "FULL NAME", J.job_title, JH.start_date, JH.end_date
FROM employees E
         LEFT JOIN jobs J on E.job_id = J.job_id
         INNER JOIN job_history JH on E.employee_id = JH.employee_id
WHERE E.commission_pct IS NULL;

--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
SELECT employee_id, first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
  AND department_id IN (
    SELECT department_id
    FROM employees
    WHERE first_name LIKE '%J%'
);

--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.
SELECT employee_id, first_name, last_name, job_title
FROM employees
         JOIN jobs USING (job_id)
WHERE salary < ANY (SELECT salary FROM employees WHERE jobs.job_id = 'MK_MAN');

--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.
SELECT employee_id AS "EMPLOYEE NUMBER", first_name || ' ' || last_name AS "FULL NAME", J.job_title
FROM employees
         LEFT JOIN jobs J on employees.job_id = J.job_id
WHERE salary < ANY (SELECT salary
                    FROM employees
                             LEFT JOIN jobs J on employees.job_id = J.job_id
                    WHERE UPPER(J.job_id) = 'MK_MAN')
  AND NOT J.job_title = (SELECT job_title
                         FROM jobs
                         WHERE UPPER(job_id) = 'MK_MAN');

--29. all the information of those employees who did not have any job in the past.
SELECT *
FROM employees
WHERE employee_id NOT IN (
    SELECT employee_id
    FROM job_history
);

--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
SELECT employee_id, first_name, last_name, job_title
FROM employees,
     jobs
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE employees.job_id = jobs.job_id
    GROUP BY job_title
);

--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
SELECT employee_id,
       first_name || ' ' || last_name AS "FULL NAME",
       CASE
           WHEN job_id = 'ST_MAN' THEN 'SALESMAN'
           WHEN job_id = 'IT_PROG' THEN 'DEVELOPER'
           ELSE job_id END            AS job_id_MOD
FROM employees;

--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
SELECT employee_id,
       first_name || ' ' || last_name AS "FULL NAME",
       salary,
       CASE
           WHEN salary >= (
               SELECT AVG(salary)
               FROM employees
           ) THEN 'HIGH'
           ELSE 'LOW' END             AS salary_STATUS
FROM employees;

--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
-- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
-- the average salary of all employees.

SELECT employee_id,
       first_name || ' ' || last_name      AS "FULL NAME",
       salary                              AS "salary DRAWN",
       ROUND(salary - (SELECT AVG(salary)
                       FROM employees), 2) AS "AVG COMPARE",
       CASE
           WHEN salary >= (SELECT AVG(salary)
                           FROM employees) THEN 'HIGH'
           ELSE 'LOW' END                  AS salary_STATUS
FROM employees;

--34. all the employees who earn more than the average and who work in any of the IT departments.
SELECT *
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE department_name LIKE 'IT%'
)
  AND salary > (
    SELECT AVG(salary)
    FROM employees
);

--35. who earns more than Mr. Ozer.
SELECT CONCAT(first_name, last_name) AS Employee
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE last_name = 'Ozer'
);


--36. which employees have a manager who works for a department based in the US.
SELECT first_name, last_name
FROM employees
WHERE manager_id IN (
    SELECT employee_id
    FROM employees
    WHERE department_id IN (
        SELECT department_id
        FROM departments
        WHERE location_id IN (
            SELECT location_id
            FROM locations
            WHERE country_id = 'US'
        )
    )
);

--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
SELECT A.first_name || ' ' || A.last_name AS "FULL NAME"
FROM employees A
WHERE salary > (
    SELECT (SUM(salary)) * .5
    FROM employees B
    WHERE A.department_id = B.department_id
);

--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.
SELECT E.employee_id, E.first_name || ' ' || E.last_name AS "FULL NAME", E.salary, L.city
FROM employees E
         LEFT JOIN departments D on E.department_id = D.department_id
         LEFT JOIN locations L on D.location_id = L.location_id
WHERE E.salary = (SELECT MAX(salary)
                  FROM employees
                  WHERE hire_date
                            BETWEEN '01-jan-2002' AND '31-dec-2003');

--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary DESC;

--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
SELECT first_name, last_name, department_id
FROM employees
WHERE salary IN (
    SELECT salary
    FROM employees
    WHERE department_id = 40
);

--41. the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
SELECT department_name, department_id
FROM departments
WHERE location_id = (
    SELECT location_id
    FROM departments
    WHERE department_id = 30
);

--42. the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM employees
    WHERE employee_id = 201
);

--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary IN (
    SELECT salary
    FROM employees
    WHERE department_id = 40
);

--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary > ANY (
    SELECT MIN(salary)
    FROM employees
    WHERE department_id = 40
);

--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary < ALL (
    SELECT salary
    FROM employees
    WHERE department_id = 70
);

--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE salary < (SELECT AVG(salary)
                FROM employees)
  AND department_id = (SELECT department_id
                       FROM employees
                       WHERE UPPER(first_name) = 'LAURA'
                           FETCH FIRST 1 ROW ONLY);

--47. the full name (first and last name) of manager who is supervising 4 or more employees.
SELECT first_name, last_name
FROM employees
WHERE employee_id IN (
    SELECT manager_id
    FROM employees
    GROUP BY manager_id
    HAVING COUNT(*) >= 4
);

--48. the details of the current job for those employees who worked as a Sales Representative in the past.
SELECT *
FROM jobs
WHERE job_id IN (
    SELECT job_id
    FROM employees
    WHERE employee_id IN (
        SELECT employee_id
        FROM job_history
        WHERE jobs.job_id = 'SA_REP'
    )
);

--49. all the information about those employees who earn second lowest salary of all the employees.
SELECT *
FROM employees A
WHERE 2 = (SELECT COUNT(DISTINCT salary)
           FROM employees
           WHERE salary < A.salary);

--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.
SELECT department_id, first_name, last_name, salary
FROM employees A
WHERE salary = (SELECT MAX(salary)
                FROM employees
                WHERE department_id = A.department_id);
