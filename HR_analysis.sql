--Step 1: creation of the Tables

CREATE TABLE department (
  department_id INT PRIMARY KEY,
  department VARCHAR (25),
  category VARCHAR (25)
);


CREATE TABLE Employee (
  employee_id INT PRIMARY KEY,
  name VARCHAR(50),
  gender VARCHAR(25),
  age INT,
  department_id INT,
  location_id INT,
  Seniority VARCHAR(25),
  education VARCHAR(25),
  hire_date date,
  work_mode VARCHAR(25),
  performance_score NUMERIC,
  satisfaction_score NUMERIC,
  initial_salary NUMERIC,
  manager_id INT,
  departure_date date,
  
  FOREIGN KEY (department_id) REFERENCES department(department_id)
);

CREATE TABLE Promotion (
  employee_id INT,
  promotion_date date,
  from_level VARCHAR(25),
  to_level VARCHAR(25),
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

CREATE TABLE Salary(
  employee_id INT,
  salary_year INT,
  seniority_level VARCHAR(25),
  salary_usd NUMERIC,
  FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

--Step 2: Data integrity

CREATE TABLE annual_salary AS (
  SELECT s.employee_id,s.salary_year,s.seniority_level,s.salary_usd
  FROM Salary s
  JOIN Employee e ON  s.employee_id = e.employee_id
--ensure the consistency between the last salary year and the departure_date
  WHERE e.departure_date is NULL
        or
        s.salary_year <= EXTRACT(year from e.departure_date)
);

CREATE TABLE Promotion_clean AS (
  SELECT p.employee_id,p.promotion_date,p.from_level,p.to_level
  FROM Promotion p
  JOIN Employee e ON p.employee_id = e.employee_id
--ensure the consistency between the last promotion_date and departure_date
  WHERE e.departure_date is NULL
         or 
        p.promotion_date <= e.departure_date
);

--Step 3: data enrichment

ALTER TABLE employee
ADD COLUMN Anciennete NUMERIC;
UPDATE Employee
set Anciennete =  ROUND((departure_date - hire_date)/365.25,1);

--Step 4: Global turnover analysis
--Turnover rate and length of service  

  SELECT count(hire_date), 
         count(departure_date),
         ROUND((count(departure_date)::NUMERIC/count(hire_date))*100,2)
         AS Taux_depart,
         ROUND(avg(anciennete),1) as avg_anciennete     
  FROM employee;
                  
/*comparison of the average salary before departure of former employees
with that of current employees*/


WITH CTE AS
   (SELECT s.employee_id,
           max(s.salary_usd) as max_salary
   FROM salary s
   JOIN employee e ON s.employee_id = e.employee_id
   WHERE e.departure_date is NOT NULL
   GROUP BY s.employee_id) 

SELECT ROUND(avg(max_salary),2) AS avgsalary_FormerEmployee,
       (SELECT ROUND(avg(max_salary),2)
         FROM ( SELECT s.employee_id,
                           max(s.salary_usd) AS max_salary
                 FROM salary S
                 JOIN employee e ON s.employee_id = e.employee_id
                 WHERE e.departure_date is NULL
                GROUP BY s.employee_id
                   )
         ) As avgsalary_currentEmployee

FROM CTE;


--Step 4: analysis by department
-- Turnover rate by department

WITH total_employee_left AS
(SELECT d.department,
       count(employee_id) AS employee_left
FROM department d
JOIN employee e ON d.department_id = e.department_id
WHERE e.departure_date is NOT NULL
GROUP BY d.department
)

SELECT d.department,
       count(employee_id) AS total_employee,
       t.employee_left,
       Round((t.employee_left::NUMERIC/count(employee_id))*100,2) 
        AS turnover_rate
       
FROM department d
JOIN employee e ON d.department_id = e.department_id

LEFT JOIN total_employee_left t ON d.department = t.department
GROUP BY d.department,t.employee_left
ORDER BY turnover_rate DESC


--Step 5: further analysis for the 3 most affected departments
--A) QA & Testing

SELECT avg(e.anciennete) --avg time before departure
FROM employee e
JOIN department d ON e.department_id = d.department_id
WHERE d.department = 'QA & Testing' 
        and e.departure_date is NOT NULL;


/*comparaison of average salary and average performance_score between
 former and current employee*/

WITH maxSalary_FormerEmployee AS
(
  SELECT s.employee_id,max(s.salary_usd) as max
FROM salary s 
JOIN employee e ON s.employee_id = e.employee_id
WHERE e.departure_date is NOT NULL
  and e.department_id = '8'
  GROUP BY s.employee_id  )

  SELECT ROUND(avg(max),2) as avg_salaryFormer,
         (SELECT ROUND(avg(performance_score),1) As perf_former
         FROM employee
         WHERE departure_date is NOT NULL
         and department_id = '8'),
         (SELECT ROUND(avg(performance_score),1) As perf_current
         FROM employee
         WHERE departure_date is NULL
        and department_id = '8'),
        ( SELECT ROUND(avg(max),2)
          FROM (SELECT s.employee_id,max(s.salary_usd) as max
          FROM salary s 
          JOIN employee e ON s.employee_id = e.employee_id
          WHERE e.departure_date is NULL
          and e.department_id = '8'
          GROUP BY s.employee_id  )
        ) AS avg_SalaryCurrent

   FROM maxSalary_FormerEmployee;

--average time after the last promotion before leaving
SELECT ROUND(avg(time_after_promotion),1) AS avg_time
FROM
      (SELECT p.employee_id,
              e.departure_date,
              max(p.promotion_date) AS last_promotion,
              ROUND((e.departure_date-max(p.promotion_date))/325.25,1)
              AS time_after_promotion     
      FROM Promotion_clean p       
      JOIN employee e ON p.employee_id = e.employee_id
      WHERE e.departure_date is NOT NULL
      and e.department_id = '8'
      GROUP BY p.employee_id, e.departure_date)


--number of departure for each each seniority level
SELECT seniority_level,count(seniority_level) AS nbr_of_departure
FROM
     (SELECT DISTINCT ON(e.employee_id)

             e.employee_id,
             p.promotion_date,
             COALESCE(p.to_level,e.Seniority) as seniority_level
      FROM   employee e
      LEFT JOIN Promotion_clean p ON e.employee_id=p.employee_id
      WHERE  e.departure_date is  NOT NULL
              and
             e.department_id='8'
      ORDER BY e.employee_id,
             p.promotion_date DESC) 
GROUP BY seniority_level


--B) Design

SELECT avg(e.anciennete) --avg time before departure
FROM employee e
JOIN department d ON e.department_id = d.department_id
WHERE d.department = 'Design' 
        and e.departure_date is NOT NULL;


/*comparaison of average salary and average performance_score between
 former and current employee*/

WITH maxSalary_FormerEmployee AS
(
  SELECT s.employee_id,max(s.salary_usd) as max
FROM salary s 
JOIN employee e ON s.employee_id = e.employee_id
WHERE e.departure_date is NOT NULL
  and e.department_id = '11'
  GROUP BY s.employee_id  )

  SELECT ROUND(avg(max),2) as avg_salaryFormer,
         (SELECT ROUND(avg(performance_score),1) As perf_former
         FROM employee
         WHERE departure_date is NOT NULL
         and department_id = '11'),
         (SELECT ROUND(avg(performance_score),1) As perf_current
         FROM employee
         WHERE departure_date is NULL
        and department_id = '11'),
        ( SELECT ROUND(avg(max),2)
          FROM (SELECT s.employee_id,max(s.salary_usd) as max
          FROM salary s 
          JOIN employee e ON s.employee_id = e.employee_id
          WHERE e.departure_date is NULL
          and e.department_id = '11'
          GROUP BY s.employee_id  )
        ) AS avg_SalaryCurrent

   FROM maxSalary_FormerEmployee;

--average time after the last promotion before leaving
SELECT ROUND(avg(time_after_promotion),1) AS avg_time
FROM
      (SELECT p.employee_id,
              e.departure_date,
              max(p.promotion_date) AS last_promotion,
              ROUND((e.departure_date-max(p.promotion_date))/325.25,1)
              AS time_after_promotion     
      FROM Promotion_clean p       
      JOIN employee e ON p.employee_id = e.employee_id
      WHERE e.departure_date is NOT NULL
      and e.department_id = '11'
      GROUP BY p.employee_id, e.departure_date)


--number of departure for each each seniority level
SELECT seniority_level,count(seniority_level) AS nbr_of_departure
FROM
     (SELECT DISTINCT ON(e.employee_id)
             e.employee_id,
             p.promotion_date,
             COALESCE(p.to_level,e.Seniority) as seniority_level
      FROM   employee e
      LEFT JOIN Promotion_clean p ON e.employee_id=p.employee_id
      WHERE  e.departure_date is  NOT NULL
              and
             e.department_id='11'
      ORDER BY e.employee_id,
             p.promotion_date DESC) 
GROUP BY seniority_level


--C) Engeneering

SELECT avg(e.anciennete) --avg time before departure
FROM employee e
JOIN department d ON e.department_id = d.department_id
WHERE d.department = 'Engineering' 
        and e.departure_date is NOT NULL;


/*comparaison of average salary and average performance_score between
 former and current employee*/

WITH maxSalary_FormerEmployee AS
(
  SELECT s.employee_id,max(s.salary_usd) as max
FROM salary s 
JOIN employee e ON s.employee_id = e.employee_id
WHERE e.departure_date is NOT NULL
  and e.department_id = '1'
  GROUP BY s.employee_id  )

  SELECT ROUND(avg(max),2) as avg_salaryFormer,
         (SELECT ROUND(avg(performance_score),1) As perf_former
         FROM employee
         WHERE departure_date is NOT NULL
         and department_id = '1'),
         (SELECT ROUND(avg(performance_score),1) As perf_current
         FROM employee
         WHERE departure_date is NULL
        and department_id = '1'),
        ( SELECT ROUND(avg(max),2)
          FROM (SELECT s.employee_id,max(s.salary_usd) as max
          FROM salary s 
          JOIN employee e ON s.employee_id = e.employee_id
          WHERE e.departure_date is NULL
          and e.department_id = '1'
          GROUP BY s.employee_id  )
        ) AS avg_SalaryCurrent

   FROM maxSalary_FormerEmployee;

--average time after the last promotion before leaving
SELECT ROUND(avg(time_after_promotion),1) AS avg_time
FROM
      (SELECT p.employee_id,
              e.departure_date,
              max(p.promotion_date) AS last_promotion,
              ROUND((e.departure_date-max(p.promotion_date))/325.25,1)
              AS time_after_promotion     
      FROM Promotion_clean p       
      JOIN employee e ON p.employee_id = e.employee_id
      WHERE e.departure_date is NOT NULL
      and e.department_id = '8'
      GROUP BY p.employee_id, e.departure_date)


--number of departure for each each seniority level
SELECT seniority_level,count(seniority_level) AS nbr_of_departure
FROM
     (SELECT DISTINCT ON(e.employee_id)

             e.employee_id,
             p.promotion_date,
             COALESCE(p.to_level,e.Seniority) as seniority_level
      FROM   employee e
      LEFT JOIN Promotion_clean p ON e.employee_id=p.employee_id
      WHERE  e.departure_date is  NOT NULL
              and
             e.department_id='1'
      ORDER BY e.employee_id,
             p.promotion_date DESC) 
GROUP BY seniority_level

