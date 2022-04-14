CREATE TABLE projects
(
    project_id NUMBER(6) PRIMARY KEY ,
    project_descriptions VARCHAR(50) ,
    project_investments NUMBER(6,-3) NOT NULL,
    project_revenue NUMBER(5),
    CONSTRAINT CHK_Descriptions CHECK(LENGTH(project_descriptions)>10),
    CONSTRAINT CHK_Investments CHECK (project_investments >= 0)
);

CREATE SEQUENCE projects_seq NOCACHE;
ALTER TABLE projects MODIFY project_id DEFAULT projects_seq.nextval;

