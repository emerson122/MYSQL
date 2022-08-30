/*

Cursores son sentencias sql

cursores implicitos:

sentecias de manipulacion de SQL

select
Insert
Update
delete

el optimiza levanta un cursor de sql para el manejod de los datos

cursores explicitos:

Definidos por el programador y sirven para procesando de manera individual
las filas que retornan una consulta
estos nos perminten realizar acciones mas especializadas


un cursor se declara en el el area de 

CURSOR nombre[(parametros)] is 
sentencia_select


Ejemplo funcionalidad del cursor
*/




/* Antes de utilizar un cursor se declara */


/* Declaracion del cursor*/
Declare 
    CURSOR cur_empleados(p_employee_id employees.employee_id%TYPE) is
    SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY
    from employees
    WHERE employee_id = p_employee_id;
BEGIN
    NULL;
END;
	
    
/*Manejo del Cursor*/

/*FUNCIONES PARA TRABAJAR CON CURSORES

open: abre el cursor y guarda memoria

FETCH: RECUPERA RECUPERA LA SIGUIENTE FILA DEL CURSOR

CLOSE: CIERRA EL CURSOR


                ATRIBUTOS
                %FOUND: TRUE si el ultimo fetch recupero filas y FALSE si NOT
                %NOTFOUND: opuesto de %FOUND
                %ISOPEN: TRUE si el cursor esta abierto y FALSE si no
                %ROWCOUNT: cantidad de filas ya procesadas  por el cursor

*/
/*-----------------------------------------------------------------------------------------------*/
/*nuevo cursor con solo 1 FETCH*/
DECLARE
    CURSOR c_emps IS
        SELECT first_name, last_name
            from employees;
V_first_name employees.first_name%TYPE;
V_last_name employees.last_name%TYPE;
BEGIN
    open c_emps;
        fetch c_emps into v_first_name, V_last_name;
        dbms_output.put_line(v_first_name ||' '||  V_last_name);
    CLOSE c_emps;
END;


/*Explicacion 

DECLARE 
    CURSOR c_emps IS  //declare el cursor
        SELECT first_name, last_name //mande a trae 2 campos
            from employees;          //traigo 2 campos de la table empleados
V_first_name employees.first_name%TYPE;     // creo las variables donde voy a almacenar los 2 datos que mande a traer
V_last_name employees.last_name%TYPE;       
BEGIN
    open c_emps; //abro el cursor
        fetch c_emps into v_first_name, V_last_name;    //traigo la primera fila
        dbms_output.put_line(v_first_name ||' '||  V_last_name);    //imprimo la primera fila 
    CLOSE c_emps;                           //cierro el cursor
END;                                        //ciero el begin

*/

/*-----------------------------------------------------------------------------------------------*/


/*nuevo cursor con 4 FETCH*/
DECLARE
    CURSOR c_emps IS
        SELECT first_name, last_name
            from employees;
V_first_name employees.first_name%TYPE;
V_last_name employees.last_name%TYPE;
BEGIN
    open c_emps;
        fetch c_emps into v_first_name, V_last_name;
        dbms_output.put_line(v_first_name ||' '||  V_last_name);
        fetch c_emps into v_first_name, V_last_name;
        dbms_output.put_line(v_first_name ||' '||  V_last_name);
        fetch c_emps into v_first_name, V_last_name;
        dbms_output.put_line(v_first_name ||' '||  V_last_name);
        fetch c_emps into v_first_name, V_last_name;
        dbms_output.put_line(v_first_name ||' '||  V_last_name);
    CLOSE c_emps;
END;


/*-----------------------------------------------------------------------------------------------------------*/


/*nuevo cursor combindao con la tabla de departamento */
DECLARE
    CURSOR c_emps IS
        SELECT e.first_name, e.last_name, d.department_name
            from hr.employees e, hr.departments d
            WHERE e.department_id = d.department_id;
V_first_name hr.employees.first_name%TYPE;
V_last_name hr.employees.last_name%TYPE;
v_deparment_name hr.departments.department_name%TYPE;
BEGIN
    open c_emps;
        fetch c_emps into v_first_name, V_last_name, v_deparment_name;
        dbms_output.put_line(v_first_name ||' '||  V_last_name ||' Trabaja en el departamento: '|| v_deparment_name );
        fetch c_emps into v_first_name, V_last_name, v_deparment_name;
        dbms_output.put_line(v_first_name ||' '||  V_last_name ||' Trabaja en el departamento: '|| v_deparment_name );
        fetch c_emps into v_first_name, V_last_name, v_deparment_name;
        dbms_output.put_line(v_first_name ||' '||  V_last_name ||' Trabaja en el departamento: '|| v_deparment_name );
        fetch c_emps into v_first_name, V_last_name, v_deparment_name;
        dbms_output.put_line(v_first_name ||' '||  V_last_name ||' Trabaja en el departamento: '|| v_deparment_name );
        fetch c_emps into v_first_name, V_last_name, v_deparment_name;
        dbms_output.put_line(v_first_name ||' '||  V_last_name ||' Trabaja en el departamento: '|| v_deparment_name );
    CLOSE c_emps;
END;

/*
DECLARE
    CURSOR c_emps IS                                        //se declara cursor con el nombre
        SELECT e.first_name, e.last_name, d.department_name //selecciono los datos que quiero traer de la tabla que quiero traer por eso se diferencia con e y d
            from hr.employees e, hr.departments d
            WHERE e.department_id = d.department_id;        //hago referencia al id
V_first_name hr.employees.first_name%TYPE;                  // creo las variables que voy a necesitar
V_last_name hr.employees.last_name%TYPE;
v_deparment_name hr.departments.department_name%TYPE;
BEGIN
    open c_emps;
        fetch c_emps into v_first_name, V_last_name, v_deparment_name; //agrego la nueva variable que cree
        dbms_output.put_line(v_first_name ||' '||  V_last_name ||' Trabaja en el departamento: '|| v_deparment_name ); //concanteno todo en un fetch 
        fetch c_emps into v_first_name, V_last_name, v_deparment_name;
        dbms_output.put_line(v_first_name ||' '||  V_last_name ||' Trabaja en el departamento: '|| v_deparment_name );
        fetch c_emps into v_first_name, V_last_name, v_deparment_name;
        dbms_output.put_line(v_first_name ||' '||  V_last_name ||' Trabaja en el departamento: '|| v_deparment_name );
        fetch c_emps into v_first_name, V_last_name, v_deparment_name;
        dbms_output.put_line(v_first_name ||' '||  V_last_name ||' Trabaja en el departamento: '|| v_deparment_name );
        fetch c_emps into v_first_name, V_last_name, v_deparment_name;
        dbms_output.put_line(v_first_name ||' '||  V_last_name ||' Trabaja en el departamento: '|| v_deparment_name );
    CLOSE c_emps;
END;
*/

/*minuto 21:32*/



Declare
   v_emp hr.employees%rowtype;
  cursor c_emps is
         select e.first_name, e.last_name, d.department_name
           from hr.employees e, hr.departments d
           where e.department_id = d.department_id;
v_department_name hr.departments.department_name%type;
begin
   open c_emps;
    fetch c_emps into v_emp.first_name, v_emp.last_name, v_department_name;
    dbms_output.put_line(v_emp.first_name||' '||v_emp.last_name||' trabaja en el departamento: '||v_department_name);
fetch c_emps into v_emp.first_name, v_emp.last_name, v_department_name;
    dbms_output.put_line(v_emp.first_name||' '||v_emp.last_name||' trabaja en el departamento: '||v_department_name);
fetch c_emps into v_emp.first_name, v_emp.last_name, v_department_name;
    dbms_output.put_line(v_emp.first_name||' '||v_emp.last_name||' trabaja en el departamento: '||v_department_name);
fetch c_emps into v_emp.first_name, v_emp.last_name, v_department_name;
    dbms_output.put_line(v_emp.first_name||' '||v_emp.last_name||' trabaja en el departamento  '||v_department_name);
    close c_emps;
end;
/





/*---------------------------------otro----------------------------------------------------*/

declare
   v_emp employees%rowtype;
  cursor c_emps is
         select e.first_name, e.last_name, d.department_name
           from employees e, departments d
           where e.department_id = d.department_id;
v_department_name departments.department_name%type;
begin
   open c_emps;
    fetch c_emps into v_emp.first_name, v_emp.last_name, v_department_name;
    dbms_output.put_line(v_emp.first_name||' '||v_emp.last_name||' trabaja en el departamento: '||v_department_name);
fetch c_emps into v_emp.first_name, v_emp.last_name, v_department_name;
    dbms_output.put_line(v_emp.first_name||' '||v_emp.last_name||' trabaja en el departamento: '||v_department_name);
fetch c_emps into v_emp.first_name, v_emp.last_name, v_department_name;
    dbms_output.put_line(v_emp.first_name||' '||v_emp.last_name||' trabaja en el departamento: '||v_department_name);
   close c_emps;
end;
/

/*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>otro>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/

declare
   v_emp employees%rowtype;
  cursor c_emps(p_dept_id number) is
         select e.first_name, e.last_name, d.department_name
           from employees e, departments d
           where e.department_id = d.department_id
             and e.department_id = p_dept_id;
v_department_name departments.department_name%type;
begin
   open c_emps(30);
    fetch c_emps into v_emp.first_name, v_emp.last_name, v_department_name;
    dbms_output.put_line(v_emp.first_name||' '||v_emp.last_name||' trabaja en el departamento: '||v_department_name);
fetch c_emps into v_emp.first_name, v_emp.last_name, v_department_name;
    dbms_output.put_line(v_emp.first_name||' '||v_emp.last_name||' trabaja en el departamento: '||v_department_name);
fetch c_emps into v_emp.first_name, v_emp.last_name, v_department_name;
    dbms_output.put_line(v_emp.first_name||' '||v_emp.last_name||' trabaja en el departamento: '||v_department_name);
   close c_emps;
end;
/


