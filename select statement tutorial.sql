SELECT *
FROM parks_and_recreation.employee_demographics;
# PEMDAS

SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;

SELECT 
employee_id, 
first_name, 
last_name
FROM parks_and_recreation.employee_demographics;

SELECT *
FROM parks_and_recreation.employee_salary
WHERE first_name = "Leslie"
;

SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary >= 50000
;

SELECT *
FROM parks_and_recreation.employee_salary
WHERE salary < 50000
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE gender = "Female"
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE gender != "Female"
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date > "1985-01-01"
;

#AND OR NOT -- logical operators

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date < "1985-01-01"
AND gender = "Male"
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date < "1985-01-01"
OR gender = "Male"
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE (first_name = "Leslie" AND age = 44) OR (age > 55)
;

#Like Statement -- % (Anything) or _ (exact amount of characters)
SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE "%n%"
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE first_name LIKE "A___"
;

SELECT *
FROM parks_and_recreation.employee_demographics
WHERE birth_date LIKE "1989%"
;

#Group by and Aggregate
SELECT gender
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender;

#Order by
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY gender, age DESC
;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY 5, 4 #position of column (can cause issues, not recommended)
;

SELECT gender, AVG(age)
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT dept_id, AVG(salary)
FROM parks_and_recreation.employee_salary
GROUP BY dept_id
HAVING AVG(salary) > 60000
;

SELECT occupation, AVG(salary)
FROM parks_and_recreation.employee_salary
WHERE occupation LIKE "%manager"
GROUP BY occupation
HAVING AVG(salary) > 60000
;


#Limit and Aliasing
SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 3
;

SELECT *
FROM parks_and_recreation.employee_demographics
ORDER BY age DESC
LIMIT 2, 1
;

#Aliasing (changing column names)
SELECT gender, AVG(age) AS average_age
FROM parks_and_recreation.employee_demographics
GROUP BY gender
HAVING average_age > 40
;

#Joins
SELECT dem.employee_id, age, occupation
FROM parks_and_recreation.employee_demographics AS dem
INNER JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;


SELECT *
FROM parks_and_recreation.employee_demographics AS dem
RIGHT JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

#self join
SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa, 
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name,
emp2.first_name AS first_name_employee, 
emp2.last_name AS last_name_employee
FROM parks_and_recreation.employee_salary AS emp1
JOIN parks_and_recreation.employee_salary AS emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

#joining multiple tables together
SELECT *
FROM parks_and_recreation.employee_demographics AS dem
INNER JOIN parks_and_recreation.employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_and_recreation.parks_departments AS pd
	ON sal.dept_id = pd.department_id
;

#unions
SELECT first_name, last_name
FROM parks_and_recreation.employee_demographics AS dem
UNION
SELECT first_name, last_name
FROM parks_and_recreation.employee_salary AS sal
;

#UNION is Distinc by default. If we want duplicate date, we have to UNION ALL 
SELECT first_name, last_name
FROM parks_and_recreation.employee_demographics AS dem
UNION ALL
SELECT first_name, last_name
FROM parks_and_recreation.employee_salary AS sal
;