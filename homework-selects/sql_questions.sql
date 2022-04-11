-- Write a query to display: 
-- 1. the first name, last name, salary, and job grade for all employees.
SELECT first_name, last_name, salary, job_title
FROM employees
         LEFT JOIN jobs USING (job_id);

-- 2. the first and last name, department, city, and state province for each employee.
SELECT first_name, last_name, department_name, city, state_province
FROM employees
LEFT JOIN departments using (department_id)
LEFT JOIN locations using (location_id);

-- 3. the first name, last name, department number and department name, for all employees for departments 80 or 40.
SELECT first_name, last_name, department_id, department_name
FROM employees
LEFT JOIN departments USING (DEPARTMENT_ID)
WHERE DEPARTMENT_ID = 40 OR DEPARTMENT_ID = 80;

-- 4. those employees who contain a letter z to their first name and also display their last name, department, city, and state province.
SELECT FIRST_NAME,LAST_NAME,DEPARTMENT_NAME,CITY,STATE_PROVINCE
FROM EMPLOYEES
LEFT JOIN DEPARTMENTS D on EMPLOYEES.EMPLOYEE_ID = D.MANAGER_ID
LEFT JOIN LOCATIONS L on D.LOCATION_ID = L.LOCATION_ID
WHERE FIRST_NAME LIKE '%z%';

-- 5. the first and last name and salary for those employees who earn less than the employee earn whose number is 182.
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 182);

-- 6. the first name of all employees including the first name of their manager.
SELECT A.FIRST_NAME AS "Employee Name", B.FIRST_NAME AS "Manager"
FROM EMPLOYEES A
JOIN EMPLOYEES B ON A.MANAGER_ID = B.MANAGER_ID;

-- 7. the first name of all employees and the first name of their manager including those who does not working under any manager.
SELECT A.FIRST_NAME AS "EMPLOYEE NAME", B.FIRST_NAME AS "Manager"
FROM EMPLOYEES A
LEFT OUTER JOIN EMPLOYEES B ON A.MANAGER_ID = B.MANAGER_ID;

-- 8. the details of employees who manage a department.
SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID = ANY(SELECT MANAGER_ID FROM DEPARTMENTS);

-- 9. the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor.
SELECT A.FIRST_NAME, A.LAST_NAME, A.DEPARTMENT_ID
FROM EMPLOYEES A
    JOIN EMPLOYEES B
ON A.DEPARTMENT_ID = B.DEPARTMENT_ID
AND B.LAST_NAME = 'Taylor';

--10. the department name and number of employees in each of the department.
SELECT DEPARTMENT_NAME, COUNT(*) AS "Number of employees"
FROM DEPARTMENTS
JOIN EMPLOYEES ON EMPLOYEES.DEPARTMENT_ID=Departments.DEPARTMENT_ID
GROUP BY EMPLOYEES.DEPARTMENT_ID, DEPARTMENT_NAME;

--11. the name of the department, average salary and number of employees working in that department who got commission.
SELECT DEPARTMENT_NAME, AVG(SALARY),COUNT(COMMISSION_PCT)
FROM DEPARTMENTS
JOIN EMPLOYEES USING (DEPARTMENT_ID)
GROUP BY DEPARTMENT_NAME;

--12. job title and average salary of employees.
SELECT JOB_TITLE, AVG(SALARY)
FROM EMPLOYEES
JOIN JOBS USING(JOB_ID)
GROUP BY JOB_TITLE;

--13. the country name, city, and number of those departments where at least 2 employees are working.
SELECT COUNTRY_NAME,CITY,COUNT(DEPARTMENT_ID)
FROM COUNTRIES
JOIN LOCATIONS USING(COUNTRY_ID)
JOIN DEPARTMENTS USING(LOCATION_ID)
WHERE DEPARTMENT_ID IN (
    SELECT DEPARTMENT_ID
    FROM EMPLOYEES
    GROUP BY DEPARTMENT_ID
    HAVING COUNT(EMPLOYEES.DEPARTMENT_ID)>=2)
GROUP BY COUNTRY_NAME, CITY;

--14. the employee ID, job name, number of days worked in for all those jobs in department 80.
SELECT EMPLOYEE_ID, JOB_TITLE, END_DATE-JOB_HISTORY.START_DATE DAYS
FROM JOB_HISTORY
JOIN JOBS ON JOB_HISTORY.JOB_ID = JOBS.JOB_ID
WHERE DEPARTMENT_ID=80;

--15. the name ( first name and last name ) for those employees who gets more salary than the employee whose ID is 163.
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 163);

--16. the employee id, employee name (first name and last name ) for all employees who earn more than the average salary.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

--17. the employee name ( first name and last name ), employee id and salary of all employees who report to Payam.
SELECT FIRST_NAME, LAST_NAME, EMPLOYEE_ID, SALARY
FROM EMPLOYEES
WHERE MANAGER_ID = (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Payam');

--18. the department number, name ( first name and last name ), job and department name for all employees in the Finance department.
SELECT A.DEPARTMENT_ID, A.FIRST_NAME, A.LAST_NAME, B.JOB_TITLE, C.DEPARTMENT_NAME
FROM EMPLOYEES A, JOBS B, DEPARTMENTS C
WHERE C.DEPARTMENT_ID = A.DEPARTMENT_ID
AND C.DEPARTMENT_NAME = 'Finance';

--19. all the information of an employee whose id is any of the number 134, 159 and 183.
SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN(134, 159, 183);

--20. all the information of the employees whose salary is within the range of smallest salary and 2500.
SELECT *
FROM EMPLOYEES
WHERE SALARY BETWEEN (
    SELECT MIN(SALARY)
    FROM EMPLOYEES
    ) AND 2500;

--21. all the information of the employees who does not work in those departments where some employees works whose id within the range 100 and 200.
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID NOT IN(
    SELECT DEPARTMENT_ID
    FROM DEPARTMENTS
    WHERE EMPLOYEES.MANAGER_ID BETWEEN 100 AND 200
    );

--22. all the information for those employees whose id is any id who earn the second highest salary.
SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (
    SELECT EMPLOYEE_ID
    FROM EMPLOYEES
    WHERE SALARY = (
        SELECT MAX(SALARY)
        FROM EMPLOYEES
        WHERE SALARY < (
            SELECT MAX(SALARY)
            FROM EMPLOYEES
            )
        )
    );

--23. the employee name( first name and last name ) and hire_date for all employees in the same department as Clara. Exclude Clara.
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (
    SELECT DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE FIRST_NAME = 'Clara')
AND NOT FIRST_NAME = 'Clara';

--24. the employee number and name( first name and last name ) for all employees who work in a department with any employee whose name contains a T.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (
    SELECT DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE FIRST_NAME LIKE '%T%'
    );

--25. full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.


--26. the employee number, name( first name and last name ), and salary for all employees who earn more than the average salary and who work in a department with any employee with a J in their name.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (
    SELECT AVG(SALARY)
    FROM EMPLOYEES
    ) AND DEPARTMENT_ID IN (
        SELECT DEPARTMENT_ID
        FROM EMPLOYEES
        WHERE FIRST_NAME LIKE '%J'
        );

--27. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN.


--28. the employee number, name( first name and last name ) and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN. Exclude Job title MK_MAN.


--29. all the information of those employees who did not have any job in the past.
SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID NOT IN(
    SELECT EMPLOYEE_ID
    FROM JOB_HISTORY
    );

--30. the employee number, name( first name and last name ) and job title for all employees whose salary is more than any average salary of any department.
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_TITLE
FROM EMPLOYEES, JOBS
WHERE SALARY > (
    SELECT AVG(SALARY)
    FROM EMPLOYEES
    WHERE EMPLOYEES.JOB_ID = JOBS.JOB_ID
    GROUP BY JOB_TITLE
    );

--31. the employee id, name ( first name and last name ) and the job id column with a modified title SALESMAN for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
--32. the employee id, name ( first name and last name ), salary and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than the average salary of all employees.
--33. the employee id, name ( first name and last name ), SalaryDrawn, AvgCompare (salary - the average salary of all employees)
    -- and the SalaryStatus column with a title HIGH and LOW respectively for those employees whose salary is more than and less than
    -- the average salary of all employees.
--34. all the employees who earn more than the average and who work in any of the IT departments.
SELECT *
FROM EMPLOYEES
    WHERE DEPARTMENT_ID IN(
        SELECT DEPARTMENT_ID
        FROM DEPARTMENTS
        WHERE DEPARTMENT_NAME LIKE 'IT%'
        )
AND SALARY > (
    SELECT AVG(SALARY)
    FROM EMPLOYEES
        );

--35. who earns more than Mr. Ozer.
SELECT CONCAT(FIRST_NAME, LAST_NAME) AS Employee
FROM EMPLOYEES
WHERE SALARY > (
    SELECT SALARY
    FROM EMPLOYEES
    WHERE LAST_NAME = 'Ozer'
    );


--36. which employees have a manager who works for a department based in the US.
--37. the names of all employees whose salary is greater than 50% of their department’s total salary bill.
--38. the employee id, name ( first name and last name ), salary, department name and city for all
--the employees who gets the salary as the salary earn by the employee which is maximum within the joining person January 1st, 2002 and December 31st, 2003.  
--39. the first and last name, salary, and department ID for all those employees who earn more than the average salary and arrange the list in descending order on salary.
--40. the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department which ID is 40.
--41. the department name and Id for all departments where they located, that Id is equal to the Id for the location where department number 30 is located.
--42. the first and last name, salary, and department ID for all those employees who work in that department where the employee works who hold the ID 201.
--43. the first and last name, salary, and department ID for those employees whose salary is equal to the salary of the employee who works in that department which ID is 40.
--44. the first and last name, salary, and department ID for those employees who earn more than the minimum salary of a department which ID is 40.
--45. the first and last name, salary, and department ID for those employees who earn less than the minimum salary of a department which ID is 70.
--46. the first and last name, salary, and department ID for those employees who earn less than the average salary, and also work at the department where the employee Laura is working as a first name holder.
--47. the full name (first and last name) of manager who is supervising 4 or more employees.
--48. the details of the current job for those employees who worked as a Sales Representative in the past.
--49. all the infromation about those employees who earn second lowest salary of all the employees.
--50. the department ID, full name (first and last name), salary for those employees who is highest salary drawar in a department.
