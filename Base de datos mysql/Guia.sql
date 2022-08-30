/*
Crear un procedimiento que identifique de la tabla de empleados los N (N será un parámetro a
enviar al procedimiento) mejores empleados pagados y los inserte en una tabla llamada
TOP_salary( que deberá de tener la siguiente estructura: Employee_id, First_name, Last_name,
Salary, Job_name y Department_name).

*/

/*
Creamos la tabla TOP_salary
*/

CREATE TABLE TOP_SALARY(
    EMPLOYEE_ID number(6),
    FIRST_NAME varchar2(20),
    LAST_NAME   varchar2(25),
    SALARY      number(8,2),
    JOB_TITLE   varchar2(35),
    DEPARTMENT_NAME varchar2(30));
/*---------- se crean por separado----------------------*/
CREATE OR replace procedure TOP_SAL(p_N number) is 

CURSOR c_emp is 
    select e.employee_id, e.first_name, e.last_name, e.salary, j.Job_title, d.department_name
    from employees e, jobs j, departments d 
    where e.job_id = j.job_id
    and e.department_id = d.department_id
    and rownum < = p_n
    order by salary desc; -- ordenar de manera desendente
begin

    for i in c_emp loop
        insert into TOP_SALARY
            Values(i.employee_id, i.first_name,i.last_name,i.salary,i.Job_title,i.department_name);
    end loop;
end;
/


/*-------------------EJECUTAR PROCEDIMIENTO--------------------------*/

exec TOP_SAL(5);

/*-------------------ver que hizo el procedimiento--------------------------*/

select * from top_salary;















/*---------------------------EJERCICIO 2-------------------------------*/

/*

Crear un procedimiento que identifique los Jefes de la tabla de empleados, e inserte un registro
en una tabla llamada Subordinados(con la siguiente estructura: First_name, Last_name, cantidad
de empleados a su cargo)


*/


/*                    CREAR TABLA                  */
create TABLE Subordinados(
    FIRST_NAME varchar2(20),
    LAST_NAME  varchar2(25),
    cantidad   number

);

/*---------- se crean por separado----------------------*/

CREATE OR REPLACE PROCEDURE OBTENER_SUBORDINADOS is 

CURSOR c_emp is 
    select e2.first_name, e2.last_name, count(e1.employee_id) cant 
    from employees e1, employees e2
    where e1.manager_id = e2.employee_id
    group by e2.first_name, e2.last_name;

begin

    for i in c_emp loop
        insert into Subordinados
          values(i.first_name, i.last_name, i.cant);
    end loop;
end;
/


/*
ejecutar procedimieto 
*/

exec OBTENER_SUBORDINADOS;


/*----------------------------------*/

select * from subordinados;

/*
Elaborar una función en la cual dado un código de departamento(Parámetro) que retorne el código
de empleado y salario de todos aquellos empleados que tenga un salario menor que el salario
mínimo definido para su puesto o mayor al salario máximo definido para su puesto.

*/

CREATE OR REPLACE FUNCTION retornar_empleados(p_deparment_id employees.department_id%type) return varchar2 is 
cursor c_emp is select e.employee_id, e.salary, j.min_salary, j.max_salary, e.department_id
        from employees e, jobs j
        where e.job_id = j.job_id
        and (e.salary > j.max_salary or 
        e.salary    < j.min_salary);
v_empleados varchar2(2500);
begin
for i in c_emp loop
    v_empleados := (v_empleados ||' '||i.employee_id ||': '||i.salary );
end loop;
return v_empleados;
end;
/

/************ EJERCUTAR EL CODIGO */
declare
    v_valores varchar2(2500);
begin
v_valores := retornar_empleados(50);
dbms_output.put_line(v_valores);
end;
/



/*------------------  

Crear una función que al indicar el country_id (Párametro) retornara los nombres completos de
todos los empleados pertenecientes a ese país

------------------------------------*/


CREATE OR REPLACE FUNCTION listar_empleados(P_country_id countries.country_id%type) return varchar is 
cursor c_emp is select e.first_name, e.last_name
from employees e, departments d, locations l 
where e.department_id = d.department_id
and d.location_id = l.location_id and l.country_id = P_country_id;


v_listado varchar2(2500);
begin
for i in c_emp loop 
    v_listado := v_listado ||' '|| i.first_name ||' '|| i.last_name;
end loop;

return v_listado;
end;
/



declare
v_valores varchar2(2500);
begin
v_valores := listar_empleados('US');
dbms_output.put_line(v_valores);
end;
/

/*************************EJEMPLO 2 *******************/
declare
v_valores varchar2(2500);
begin
v_valores := listar_empleados('UK');
dbms_output.put_line(v_valores);
end;
/


/*
Crear paquete que contenga 3 procedimientos necesarios para realizar las operaciones de
Inserción, actualización y borrado de registros de la tabla Countries.
*/


CREATE OR REPLACE PACKAGE PKG_COUNTRIES IS 
    PROCEDURE INSERTAR(P_COUNTRY_ID COUNTRIES.COUNTRY_ID%TYPE, P_COUNTRY_NAME COUNTRIES.COUNTRY_NAME%TYPE, P_REGION_ID COUNTRIES.REGION_ID%TYPE);
    PROCEDURE ACTUALIZAR(P_COUNTRY_ID COUNTRIES.COUNTRY_ID%TYPE, P_COUNTRY_NAME COUNTRIES.COUNTRY_NAME%TYPE);
    PROCEDURE BORRAR(P_COUNTRY_ID COUNTRIES.COUNTRY_ID%TYPE);
    END;
/

CREATE OR REPLACE PACKAGE body PKG_COUNTRIES is 
    PROCEDURE INSERTAR(P_COUNTRY_ID COUNTRIES.COUNTRY_ID%TYPE, P_COUNTRY_NAME COUNTRIES.COUNTRY_NAME%TYPE, P_REGION_ID COUNTRIES.REGION_ID%TYPE); IS 
BEGIN 

INSERT INTO COUNTRIES 
    Values(P_COUNTRY_ID , P_COUNTRY_NAME, P_REGION_ID);
END;
BEGIN  
    UPDATE COUNTRIES 
        SET COUNTRY_NAME = P_COUNTRY_NAME,
        REGION_ID = P_REGION_ID
        WHERE COUNTRY_ID = P_COUNTRY_ID;
END;
PROCEDURE BORRAR(P_COUNTRY_ID COUNTRIES.COUNTRY_ID%TYPE) IS 
BEGIN 
    DELETE COUNTRIES    
    WHERE COUNTRY_ID = P_COUNTRY_ID;
END;







