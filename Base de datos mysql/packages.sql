/*                                     paquetes   */
Create or replace package acciones_personal is
Function contratar (
     p_employee_id  employees.employee_id%type,
     p_first_name   employees.first_name%type,
     p_last_name    employees.last_name%type,
     p_email        employees.email%type,
     p_phone        employees.phone_number%type,
     p_hiredate     employees.hire_date%type,
     p_job_id       employees.job_id%type,
     p_salary       employees.salary%type,
     p_commission   employees.commission_pct%type,
     p_manager_id   employees.manager_id%type,
     p_department   employees.department_id%type) return number;
procedure despedir (
     p_employee_id employees.employee_id%type);
procedure aumento (
    p_employee_id employees.employee_id%type,
    p_sal_incre   number);
end;



/*-------------------------segundo paquete------------------------------------------*/


/*         https://unahedu-my.sharepoint.com/personal/jose_pagoaga_unah_edu_hn/_layouts/15/onedrive.aspx?ga=1&id=%2Fpersonal%2Fjose%5Fpagoaga%5Funah%5Fedu%5Fhn%2FDocuments%2FSesiones%20Grabadas%20BDII%2F20221PAC%2F3Parcial%2F2022%2E03%2E23%2FGMT20220324%2D020438%5FRecording%2Etxt&parent=%2Fpersonal%2Fjose%5Fpagoaga%5Funah%5Fedu%5Fhn%2FDocuments%2FSesiones%20Grabadas%20BDII%2F20221PAC%2F3Parcial%2F2022%2E03%2E23                                                                                 */
create or replace package body acciones_personal is
Function contratar (
     p_employee_id  employees.employee_id%type,
     p_first_name   employees.first_name%type,
     p_last_name    employees.last_name%type,
     p_email        employees.email%type,
     p_phone        employees.phone_number%type,
     p_hiredate     employees.hire_date%type,
     p_job_id       employees.job_id%type,
     p_salary       employees.salary%type,
     p_commission   employees.commission_pct%type,
     p_manager_id   employees.manager_id%type,
     p_department   employees.department_id%type) return number is
begin
   insert into employees
   Values(p_employee_id, 
     p_first_name,
     p_last_name,
     p_email,
     p_phone,
     p_hiredate,
     p_job_id ,
     p_salary,
     p_commission,
     p_manager_id,
     p_department );
end contratar;
procedure despedir (
     p_employee_id employees.employee_id%type) is
begin
    delete from employees
     where employee_id = p_employee_id;
end despedir;
	procedure aumento (
    p_employee_id employees.employee_id%type,
    p_sal_incre   number) is
begin
    update employees
      set salary = salary + p_sal_incre
     where employee_id = p_employee_id;
end aumento;
end;


