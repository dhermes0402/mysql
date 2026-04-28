-- Ejercicios Triggers
-- 1 ---------------------------------
-- Comprueba que no podamos contratar a empleados que no tengan 16 años.
use empresaclase;
drop trigger if exists compruebaEdad
delimiter $$
create trigger compruebaEdad
before insert on empleados
for each row
begin 
	if (new.fecnaem > date_sub(curdate(),interval 16 year)) then
    signal sqlstate '45000'
    set message_text = 'edad insuficiente';
    end if;   
end $$
delimiter ;

-- Comprobar que existe
show triggers from empresaclase;

-- Comprobar que funciona
insert into empleados (numem, fecnaem, nomem, fecinem)
values (10, '2010-01-01', 'Diego', '2016-01-01');

select numem, fecnaem, nomem, fecinem from empleados;

-- 2 --------------------------------------
-- Comprueba que el departamento de las personas que ejercen la 
-- dirección de los departamentos pertenezcan a dicho departamento.
drop trigger if exists comprobarDepartamento;
delimiter $$ 
create trigger comprobarDepartamento 
before insert on dirigir
for each row
begin
	if  (select numde 
		from empleados 
        where numem = new.numempdirec )
        <> new.numdepto then
    begin    
	signal sqlstate '45000' 
    set message_text = 'Error de departamento';
    end;
    end if;
end $$
delimiter ;

insert into dirigir (numdepto, numempdirec, fecinidir, fecfindir, tipodir)
values (110, 150, '2010-01-01', '2012-01-01', '1');

-- 3 ---------------------------------------------
-- Añade lo que consideres oportuno para que las comprobaciones anteriores 
-- se hagan también cuando se modifiquen la fecha 
-- de nacimiento de un empleado o al director/a de un departamento.
    



