create or replace package pkg_jobs is
 procedure insertar (p_emp_id job_history.employee_id%type, p_start_date job_history.start_date%type, p_end_date  job_history.end_date%type, p_job_id job_history.job_id%type, p_department_id   job_history.department_id%type);  
 procedure actualizar  (p_emp_id job_history.employee_id%type, p_start_date job_history.start_date%type, p_end_date  job_history.end_date%type, p_job_id job_history.job_id%type, p_department_id   job_history.department_id%type);  
  procedure borrar   (p_job_id job_history.job_id%type);    
  end; 
  
CREATE OR REPLACE PACKAGE body pkg_jobs is
    procedure insertar (p_emp_id job_history.employee_id%type, p_start_date job_history.start_date%type, p_end_date  job_history.end_date%type, p_job_id job_history.job_id%type, p_department_id   job_history.department_id%type);  is 
BEGIN 

INSERT INTO job_history
    Values(p_emp_id job_history.employee_id%type, p_start_date job_history.start_date%type, p_end_date  job_history.end_date%type, p_job_id job_history.job_id%type, p_department_id   job_history.department_id%type); 
END;
BEGIN  
    UPDATE job_history
     SET  start_date = p_start_date,
     end_date = p_end_date,
     where employee_id = p_emp_id;
end;

PROCEDURE borrar(p_emp_id = job_history.employee_id%type);
BEGIN 
    DELETE job_history   
    WHERE employee_id = p_emp_id;
END;

