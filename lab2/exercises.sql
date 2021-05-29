-- 1
SELECT LAST_NAME || ' ' || SALARY AS Wynagrodzenie
FROM EMPLOYEES
	WHERE (DEPARTMENT_ID = 20 OR DEPARTMENT_ID = 50) AND (SALARY BETWEEN  2000 AND 7000)
ORDER BY LAST_NAME;


-- 2
SELECT HIRE_DATE, LAST_NAME
FROM EMPLOYEES
	WHERE MANAGER_ID IS NOT NULL AND HIRE_DATE BETWEEN '2005-01-01' AND '2005-12-31'
ORDER BY HIRE_DATE;


-- 3
SELECT (FIRST_NAME || ' ' || LAST_NAME) AS FULL_NAME, SALARY, PHONE_NUMBER
FROM EMPLOYEES
    WHERE LAST_NAME LIKE '__e%'
ORDER BY FULL_NAME DESC, SALARY ASC;


-- 4
SELECT MONTHS, SALARY,
    (CASE WHEN MONTHS > 200 then 0.3
          WHEN MONTHS > 150 then 0.2
          ELSE 0.1
    END * SALARY) AS WYSOKOSC_DODATKU
FROM (SELECT FIRST_NAME, LAST_NAME, SALARY, ROUND(MONTHS_BETWEEN(CURRENT_DATE, HIRE_DATE)) AS MONTHS FROM EMPLOYEES)
ORDER BY MONTHS;


-- 5
SELECT JOBS.JOB_TITLE, JOBS.MIN_SALARY, SUM(EMPL.SALARY) AS SUMA, ROUND(AVG(EMPL.SALARY), 0) AS SREDNIA
FROM EMPLOYEES EMPL
    JOIN JOBS
        ON JOBS.JOB_ID = EMPL.JOB_ID
    GROUP BY JOBS.JOB_TITLE, JOBS.MIN_SALARY
    HAVING JOBS.MIN_SALARY > 5000;


-- 6

SELECT EMPLOYEES.LAST_NAME,
       DEPARTMENTS.DEPARTMENT_ID,
       DEPARTMENTS.DEPARTMENT_NAME,
       EMPLOYEES.JOB_ID
FROM EMPLOYEES
    JOIN DEPARTMENTS
        ON DEPARTMENTS.DEPARTMENT_ID = EMPLOYEES.DEPARTMENT_ID
    JOIN LOCATIONS
        ON DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
WHERE LOCATIONS.CITY LIKE 'Toronto'


-- 7
SELECT Empl.FIRST_NAME, Empl.LAST_NAME
    FROM EMPLOYEES Empl
WHERE FIRST_NAME LIKE 'Jennifer';


-- 8
SELECT DISTINCT DEPARTMENTS.DEPARTMENT_ID, DEPARTMENTS.DEPARTMENT_NAME
FROM DEPARTMENTS
    WHERE DEPARTMENT_ID NOT IN (SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES WHERE DEPARTMENT_ID IS NOT NULL)
ORDER BY DEPARTMENT_ID;

-- 9
CREATE TABLE job_grades AS SELECT * FROM HR.job_grades;

-- 10
SELECT EMPL.FIRST_NAME, EMPL.LAST_NAME, EMPL.JOB_ID, DEP.DEPARTMENT_NAME, EMPL.SALARY, JG.GRADE
FROM EMPLOYEES EMPL
    JOIN DEPARTMENTS DEP ON EMPL.DEPARTMENT_ID = DEP.DEPARTMENT_ID
    JOIN JOB_GRADES JG ON EMPL.EMPLOYEE_ID = JG.EMPLOYEE_ID

-- 11
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM EMPLOYEES
    WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
ORDER BY SALARY DESC

-- 12
SELECT EMPL.EMPLOYEE_ID, EMPL.FIRST_NAME, EMPL.LAST_NAME
FROM EMPLOYEES EMPL
    JOIN DEPARTMENTS DEP ON EMPL.DEPARTMENT_ID = DEP.DEPARTMENT_ID
    WHERE DEP.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME LIKE '%u%')
