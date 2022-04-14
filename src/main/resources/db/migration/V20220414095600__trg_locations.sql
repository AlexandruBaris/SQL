CREATE
    OR REPLACE TRIGGER trg_location
    AFTER INSERT OR DELETE
    ON DEPARTMENTS
DECLARE
BEGIN
    MERGE INTO LOCATIONS L
    USING (SELECT count(department_id) AS dpt_amount, location_id AS loc_id
           FROM departments D
           GROUP BY location_id) S
    ON (L.location_id = S.loc_id)
    WHEN MATCHED THEN
        UPDATE SET L.department_amount = S.dpt_amount;
END;
