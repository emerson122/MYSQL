/*-----------------------------------------CON UN LOOP ------------------------------------------------*/

eclare
   v_emp employees%rowtype;
  cursor c_emps(p_dept_id number) is
         select e.first_name, e.last_name, d.department_name
           from employees e, departments d
           where e.department_id = d.department_id
             and e.department_id = p_dept_id;
v_department_name departments.department_name%type;
begin
   open c_emps(30);
   loop
      fetch c_emps into v_emp.first_name, v_emp.last_name, v_department_name;     
      dbms_output.put_line(v_emp.first_name||' '||v_emp.last_name||' trabaja en el departamento: '||v_department_name);
      exit when c_emps%notfound;
   end loop;
   close c_emps;
END;
/



/*----------------------------------------------------------------------------------------*/

declare
  cursor c_emps(p_dept_id number) is
         select e.first_name, e.last_name, d.department_name
           from employees e, departments d
           where e.department_id = d.department_id
             and e.department_id = p_dept_id;
begin 
   for i in  c_emps(30) loop
      dbms_output.put_line(i.first_name||' '||i.last_name||' trabaja en el departamento: '||i.department_name);
   end loop;
end;
/



/*-----------------------------------------------------------------------------------------------------------------*/

declare
     cursor c_emps(p_dept_id number) is
            select e.first_name, e.last_name, d.department_name
               from employees e, departments d
               where e.department_id = d.department_id
                 and e.department_id = p_dept_id
                for update;
    begin
       for i in  c_emps(30) loop
         dbms_output.put_line(i.first_name||' '||i.last_name||' trabaja en el departamento: '||i.department_name);
      end loop;
  end;