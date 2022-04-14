CREATE TABLE pay
(
    cardNr NUMBER(10) PRIMARY KEY,
    salary NUMBER(10),
    commission_pct NUMBER(2,2),
    CONSTRAINT min_salary CHECK (salary > 0)
);
