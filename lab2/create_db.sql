CREATE TABLE regions AS SELECT * FROM HR.regions;
CREATE TABLE countries AS SELECT * FROM HR.countries;
CREATE TABLE locations AS SELECT * FROM HR.locations;
CREATE TABLE jobs AS SELECT * FROM HR.jobs;
CREATE TABLE job_history AS SELECT * FROM HR.job_history;
CREATE TABLE employees AS SELECT * FROM HR.employees;
CREATE TABLE departments AS SELECT * FROM HR.departments;

ALTER TABLE regions
    ADD PRIMARY KEY (region_id);

ALTER TABLE countries
    ADD PRIMARY KEY (country_id);

ALTER TABLE locations
    ADD PRIMARY KEY (location_id);

ALTER TABLE jobs
    ADD PRIMARY KEY (job_id);

ALTER TABLE departments
    ADD PRIMARY KEY (department_id);

ALTER TABLE employees
    ADD PRIMARY KEY (employee_id);

ALTER TABLE countries
    ADD FOREIGN KEY (region_id) REFERENCES regions(region_id);

ALTER TABLE locations
    ADD FOREIGN KEY (country_id) REFERENCES countries(country_id);

ALTER TABLE employees
    ADD FOREIGN KEY (manager_id) REFERENCES employees(employee_id);

ALTER TABLE employees
    ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);

ALTER TABLE employees
    ADD FOREIGN KEY (job_id) REFERENCES jobs(job_id);

ALTER TABLE job_history
    ADD FOREIGN KEY (job_id) REFERENCES jobs(job_id);

ALTER TABLE job_history
    ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);

ALTER TABLE job_history
    ADD FOREIGN KEY (employee_id) REFERENCES employees(employee_id);

ALTER TABLE departments
    ADD FOREIGN KEY (manager_id) REFERENCES employees(employee_id);

ALTER TABLE departments
    ADD FOREIGN KEY (location_id) REFERENCES locations(location_id);