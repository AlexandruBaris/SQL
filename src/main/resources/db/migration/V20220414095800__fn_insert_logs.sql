CREATE OR REPLACE PROCEDURE insert_log
(
    new_first_name IN VARCHAR2,
    new_last_name IN VARCHAR2,
    new_empl_action IN VARCHAR2
) IS
BEGIN
    INSERT INTO employment_logs (first_name,last_name,employment_action)
    VALUES (new_first_name,new_last_name,new_empl_action);
end;