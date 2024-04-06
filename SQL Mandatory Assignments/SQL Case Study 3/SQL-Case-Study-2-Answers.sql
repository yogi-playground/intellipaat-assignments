/**SQL Case Study 02**/

/**Simple Queries:**/
/**1. List all the employee details.**/
SELECT * FROM EMPLOYEE;

/**2. List all the department details.**/
SELECT * FROM Department;

/**3. List all job details.**/
SELECT * from JOB;

/**4. List all the locations.**/
SELECT * FROM LOCATION;

/**5. List out the First Name, Last Name, Salary, Commission for all Employees.**/
SELECT First_Name, Last_Name, Salary, Comm as Commission FROM EMPLOYEE;

/**6. List out the Employee ID, Last Name, Department ID for all employees and alias
Employee ID as "ID of the Employee", Last Name as "Name of the
Employee", Department ID as "Dep_id".**/
SELECT Employee_Id AS "ID of the Employee", Last_Name AS "Name of the Employee", 
Department_Id AS Dep_id FROM EMPLOYEE;

/**7. List out the annual salary of the employees with their names only.
Assuming Salary provided in data is Annual Salary**/
SELECT CONCAT(First_Name, ' ', Last_Name) AS "Employee Name", Salary  AS "Annual Salary"
FROM EMPLOYEE;

/**WHERE Condition:**/
/**1. List the details about "Smith".**/
SELECT * FROM EMPLOYEE WHERE Last_Name = 'Smith';

/**2. List out the employees who are working in department 20.**/
SELECT * FROM EMPLOYEE WHERE Department_Id = 20;

/**3. List out the employees who are earning salaries between 3000 and 4500.**/
SELECT * FROM EMPLOYEE WHERE Salary BETWEEN 3000 AND 4500;

/**4. List out the employees who are working in department 10 or 20.**/
SELECT * FROM EMPLOYEE WHERE Department_Id IN (10, 20);

/**5. Find out the employees who are not working in department 10 or 30.**/
SELECT * FROM EMPLOYEE WHERE Department_Id NOT IN (10, 30);

/**6. List out the employees whose name starts with 'S'.**/
SELECT * FROM EMPLOYEE WHERE Last_Name LIKE 'S%';

/**7. List out the employees whose name starts with 'S' and ends with 'H'.**/
SELECT * FROM EMPLOYEE WHERE Last_Name LIKE 'S%H';

/**8. List out the employees whose name length is 4 and start with 'S'.**/
SELECT * FROM EMPLOYEE WHERE Last_Name LIKE 'S____';

/**9. List out employees who are working in department 10 and draw salaries more
than 3500.**/
SELECT * FROM EMPLOYEE WHERE Department_Id = 10 AND Salary > 3500;

/**10. List out the employees who are not receiving commission.**/
SELECT * FROM EMPLOYEE WHERE Comm IS NULL;

/**ORDER BY Clause:**/

/**1. List out the Employee ID and Last Name in ascending order based on the
Employee ID.**/
SELECT Employee_Id, Last_Name 
FROM EMPLOYEE 
ORDER BY Employee_Id ASC;

/**2. List out the Employee ID and Name in descending order based on salary.**/
SELECT Employee_Id, CONCAT(First_Name, ' ', Last_Name) AS 'Employee Name'
FROM EMPLOYEE 
ORDER BY Salary DESC;

/**3. List out the employee details according to their Last Name in ascending-order.**/
SELECT * 
FROM EMPLOYEE 
ORDER BY Last_Name ASC;

/**4. List out the employee details according to their Last Name in ascending
order and then Department ID in descending order.**/
SELECT * 
FROM EMPLOYEE 
ORDER BY Last_Name ASC, Department_Id DESC;

/**GROUP BY and HAVING Clause:**/
/**1. How many employees are in different departments in the organization?**/
SELECT Department_Id, COUNT(*) AS num_of_employees
FROM EMPLOYEE
GROUP BY Department_Id;

/**2. List out the department wise maximum salary, minimum salary and
average salary of the employees**/
SELECT Department_Id,
       MAX(Salary) AS max_salary,
       MIN(Salary) AS min_salary,
       AVG(Salary) AS avg_salary
FROM EMPLOYEE
GROUP BY Department_Id;


/**3. List out the job wise maximum salary, minimum salary and average
salary of the employees.**/
SELECT JOB_ID,
       MAX(Salary) AS max_salary,
       MIN(Salary) AS min_salary,
       AVG(Salary) AS avg_salary
FROM EMPLOYEE
GROUP BY JOB_ID;


/**4. List out the number of employees who joined each month in ascending order.**/
SELECT DATEPART(MONTH, Hire_Date) AS join_month,
       COUNT(*) AS num_employees_joined
FROM EMPLOYEE
GROUP BY DATEPART(MONTH, Hire_Date)
ORDER BY join_month ASC;


/**5. List out the number of employees for each month and year in
ascending order based on the year and month.**/
SELECT YEAR(Hire_Date) AS join_year,
       MONTH(Hire_Date) AS join_month,
       COUNT(*) AS num_of_employees_joined
FROM EMPLOYEE
GROUP BY YEAR(Hire_Date), MONTH(Hire_Date)
ORDER BY join_year ASC, join_month ASC;



/**6. List out the Department ID having at least four employees.**/
SELECT Department_Id
FROM EMPLOYEE
GROUP BY Department_Id
HAVING COUNT(*) >= 4;


/**7. How many employees joined in the month of January?**/
SELECT COUNT(*) AS num_of_employees_joined
FROM EMPLOYEE
WHERE MONTH(Hire_Date) = 1;

/**8. How many employees joined in the month of January or September?**/
SELECT COUNT(*) AS num_of_employees_joined
FROM EMPLOYEE
WHERE MONTH(Hire_Date) IN (1, 9);

/**9. How many employees joined in 1985?**/
SELECT COUNT(*) AS num_of_employees_joined
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985;

/**10. How many employees joined each month in 1985?**/
SELECT MONTH(Hire_Date) AS join_month,
       COUNT(*) AS num_of_employees_joined
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985
GROUP BY MONTH(Hire_Date);

/**11. How many employees joined in March 1985?**/
SELECT COUNT(*) AS num_employees_joined
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985
AND MONTH(Hire_Date) = 3;

/**Which is the Department ID having greater than or equal to 3 employees
joining in April 1985?**/
SELECT Department_Id
FROM EMPLOYEE
WHERE YEAR(Hire_Date) = 1985
AND MONTH(Hire_Date) = 4
GROUP BY Department_Id
HAVING COUNT(*) >= 3;

/**Joins:**/
/**1. List out employees with their department names.**/
SELECT E.*, D.Name AS Department_Name
FROM EMPLOYEE E
JOIN Department D ON E.Department_Id = D.Department_Id;

/**2. Display employees with their designations.**/
SELECT E.*, J.Designation
FROM EMPLOYEE E
JOIN JOB J ON E.Job_Id = J.Job_ID;

/**3. Display the employees with their department names and regional groups.**/
SELECT E.*, D.Name AS Department_Name,L.City
FROM EMPLOYEE E
JOIN Department D ON E.Department_Id = D.Department_Id
JOIN LOCATION L ON D.Location_Id = L.Location_ID;

/**4. How many employees are working in different departments? Display with
department names.**/
SELECT  E.Department_Id, D.Name AS Department_Name, Count(*) as num_of_employees
FROM EMPLOYEE E
JOIN Department D ON E.Department_Id = D.Department_Id
group by  E.Department_Id,D.Name;


/**5. How many employees are working in the sales department?**/
SELECT COUNT(*) AS num_of_employees
FROM EMPLOYEE E
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Sales';

/**6. Which is the department having greater than or equal to 5
employees? Display the department names in ascending
order.**/
SELECT D.Name AS Department_Name, COUNT(*) AS num_of_employees
FROM EMPLOYEE E
JOIN Department D ON E.Department_Id = D.Department_Id
GROUP BY D.Name
HAVING COUNT(*) >= 5
ORDER BY Department_Name ASC;

/**7. How many jobs are there in the organization? Display with designations.**/
SELECT COUNT(*) AS num_of_jobs, Designation
FROM JOB
GROUP BY Designation;

/**8. How many employees are working in "New York"?**/
SELECT COUNT(*) AS num_of_employees
FROM EMPLOYEE E
JOIN Department D ON E.Department_Id = D.Department_Id
JOIN LOCATION L ON D.Location_Id = L.Location_ID
WHERE L.City = 'New York';

/**9. Display the employee details with salary grades. Use conditional statement to
create a grade column**/
SELECT *,
       CASE
           WHEN Salary < 1000 THEN 'Grade 1'
           WHEN Salary >= 1000 AND Salary < 3000 THEN 'Grade 2'
           ELSE 'Grade 3'
       END AS Salary_Grade
FROM EMPLOYEE;

/**10. List out the number of employees grade wise. Use conditional statementto
create a grade column.**/
SELECT Salary_Grade, COUNT(*) AS num_employees
FROM (
    SELECT *,
           CASE
               WHEN Salary < 1000 THEN 'Grade 1'
			   WHEN Salary >= 1000 AND Salary < 3000 THEN 'Grade 2'
			   ELSE 'Grade 3'
           END AS Salary_Grade
    FROM EMPLOYEE
) AS SalaryGrades
GROUP BY Salary_Grade;

/**11. Display the employee salary grades and the number of employees
between 2000 to 5000 range of salary.**/
SELECT Salary_Grade, COUNT(*) AS num_employees
FROM (
    SELECT *,
           CASE
               WHEN Salary < 1000 THEN 'Grade 1'
			   WHEN Salary >= 1000 AND Salary < 3000 THEN 'Grade 2'
			   ELSE 'Grade 3'
           END AS Salary_Grade
    FROM EMPLOYEE
) AS SalaryGrades
Where Salary between 2000 and 5000
GROUP BY Salary_Grade;

/**12. Display all employees in sales or operation departments.**/
SELECT *
FROM EMPLOYEE E
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name IN ('Sales', 'Operations');

/**SET Operators:**/
/**1. List out the distinct jobs in sales and accounting departments.**/
SELECT DISTINCT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name IN ('Sales', 'Accounting');

/**2. List out all the jobs in sales and accounting departments.**/
SELECT DISTINCT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Sales' OR D.Name = 'Accounting';


/**3. List out the common jobs in research and accounting
departments in ascending order.**/
SELECT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Research'
INTERSECT
SELECT J.Designation
FROM JOB J
JOIN EMPLOYEE E ON J.Job_ID = E.Job_Id
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Accounting'
ORDER BY Designation ASC;

-- Subqueries:  
/**1. Display the employees list who got the maximum salary.**/
SELECT * FROM EMPLOYEE WHERE Salary = (   SELECT MAX(Salary)     FROM EMPLOYEE);

/**2. Display the employees who are working in the sales department.**/
SELECT *
FROM EMPLOYEE E
JOIN Department D ON E.Department_Id = D.Department_Id
WHERE D.Name = 'Sales';

/**3. Display the employees who are working as 'Clerk'.**/
SELECT *
FROM EMPLOYEE E
JOIN JOB J ON E.Job_Id = J.Job_ID
WHERE J.Designation = 'Clerk';

/***4. Display the list of employees who are living in "New York".**/
SELECT *
FROM EMPLOYEE E
Where Department_Id in (Select Department_Id FROM
Department D JOIN LOCATION L ON D.Location_Id = L.Location_ID
WHERE L.City = 'New York');

/**5. Find out the number of employees working in the sales department.**/
SELECT COUNT(*) AS num_employees
FROM EMPLOYEE  where DEPARTMENT_ID  in (Select  DEPARTMENT_ID
FROM Department Where Name = 'Sales');

/**Update the salaries of employees who are working as clerks on the basis of 10%.**/
UPDATE EMPLOYEE
SET Salary = Salary * 1.1
WHERE Job_Id IN (
    SELECT Job_ID
    FROM JOB
    WHERE Designation = 'Clerk'
);

/**7. Delete the employees who are working in the accounting department.**/
DELETE FROM EMPLOYEE
WHERE Department_Id IN (
    SELECT Department_Id
    FROM Department
    WHERE Name = 'Accounting'
);

/**8. Display the second highest salary drawing employee details.**/
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY Salary DESC) AS salary_rank
    FROM EMPLOYEE
) AS salary_rank_table
WHERE salary_rank = 2;

/**9. Display the nth highest salary drawing employee details.**/

DECLARE @N INT = 2; -- Change this value to the nth highest salary

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY Salary DESC) AS salary_rank
    FROM EMPLOYEE
) AS salary_rank_table
WHERE salary_rank = @N;

/**10. List out the employees who earn more than every employee in department 30.**/
SELECT *
FROM EMPLOYEE
WHERE Salary > ALL (
    SELECT Salary
    FROM EMPLOYEE
    WHERE Department_Id = 30
);

/**11. List out the employees who earn more than the lowest salary in
department.Find out whose department has no employees.**/
SELECT *
FROM EMPLOYEE E
WHERE Salary > (
    SELECT MIN(Salary)
    FROM EMPLOYEE
    WHERE Department_Id = E.Department_Id
);

/**12. Find out which department has no employees**/

SELECT D.*
FROM Department D
LEFT JOIN EMPLOYEE E ON D.Department_Id = E.Department_Id
WHERE E.Employee_Id IS NULL;

/**13. Find out the employees who earn greater than the average salary for
their departme**/
SELECT *
FROM EMPLOYEE E
WHERE Salary > (
    SELECT AVG(Salary)
    FROM EMPLOYEE
    WHERE Department_Id = E.Department_Id
);
















































