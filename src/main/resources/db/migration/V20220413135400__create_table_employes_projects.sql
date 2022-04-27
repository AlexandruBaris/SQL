CREATE TABLE employees_projects
(
    id NUMBER(10) PRIMARY KEY,
    hours NUMBER(4),
    project_id NUMBER,
    fk_employee_id NUMBER
);

ALTER TABLE employees_projects ADD CONSTRAINT key_project_id FOREIGN KEY (project_id) REFERENCES projects(project_id);
ALTER TABLE employees_projects ADD CONSTRAINT key_employee_id FOREIGN KEY (fk_employee_id) REFERENCES employees (employee_id);

select * from projects;