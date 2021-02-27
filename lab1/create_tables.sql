CREATE TABLE REGIONS (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(30)
);

CREATE TABLE COUNTRIES (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(30) UNIQUE,
    region_id INT,
    FOREIGN KEY(region_id) REFERENCES REGIONS(region_id)
);

CREATE TABLE LOCATIONS (
    location_id INT PRIMARY KEY,
    street_address VARCHAR(30),
    city VARCHAR(30),
    state_province VARCHAR(30),
    country_id INT,
    FOREIGN KEY(country_id) REFERENCES COUNTRIES(country_id)
);

CREATE TABLE JOBS (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(30),
    min_salary FLOAT,
    max_salary FLOAT
);

CREATE TABLE JOB_HISTORY (
    employee_id INT,
    start_date DATE,
    end_date DATE,
    job_id INT,
    department_id INT
);

CREATE TABLE DEPARTMENTS (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(30),
    manager_id INT,
    location_id INT
);

CREATE TABLE EMPLOYEES (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    email VARCHAR(30),
    phone_number VARCHAR(15),
    hire_date DATE,
    job_id INT,
    salary FLOAT,
    commission_pct VARCHAR(30)
);

ALTER TABLE EMPLOYEES ADD manager_id INT;
ALTER TABLE EMPLOYEES ADD department_id INT;

ALTER TABLE EMPLOYEES
    ADD FOREIGN KEY (manager_id) REFERENCES EMPLOYEES(employee_id);

ALTER TABLE EMPLOYEES
    ADD FOREIGN KEY (department_id) REFERENCES DEPARTMENTS(department_id);

ALTER TABLE EMPLOYEES
    ADD FOREIGN KEY (job_id) REFERENCES JOBS(job_id);

ALTER TABLE JOB_HISTORY
    ADD FOREIGN KEY (job_id) REFERENCES JOBS(job_id);

ALTER TABLE JOB_HISTORY
    ADD FOREIGN KEY (department_id) REFERENCES DEPARTMENTS(department_id);

ALTER TABLE JOB_HISTORY
    ADD FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id);

ALTER TABLE DEPARTMENTS
    ADD FOREIGN KEY (manager_id) REFERENCES EMPLOYEES(employee_id);

ALTER TABLE DEPARTMENTS
    ADD FOREIGN KEY (location_id) REFERENCES LOCATIONS(location_id);

ALTER TABLE JOBS
    ADD CHECK (max_salary - min_salary >= 2000);