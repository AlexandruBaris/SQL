CREATE TABLE employment_logs
(
    employment_log_id NUMBER(5) PRIMARY KEY,
    first_name VARCHAR (20) NOT NULL,
    last_name VARCHAR (20) NOT NULL,
    employment_action VARCHAR (5) NOT NULL,
    employment_status_updtd_tmstmp DATE DEFAULT SYSDATE,
    CONSTRAINT emp_action CHECK ( employment_action IN ('HIRED','FIRED') )
);

CREATE SEQUENCE log_sequence NOCACHE;
ALTER TABLE employment_logs MODIFY employment_log_id DEFAULT log_sequence.nextval;


SELECT * FROM employment_logs;