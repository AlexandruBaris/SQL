alter table locations add department_amount NUMBER(3);

COMMENT ON COLUMN locations.department_amount IS 'Contains the amount of departments in the location';