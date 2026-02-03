-- 1
select *, nomde
from empleados join departamentos
using (numde);

-- 2
select extelem, nomce, nomem
from empleados join departamentos
using (numde) join centros 
using (numce)
where nomem = 'Juan' and ape1em = 'López';

-- 3
select concat_ws(' ' ,nomem, ape1em, ape2em) as NombreCompleto,
nomde
-- Calle y el telefono "C/ Agua nº10 (612381238)"
concat('C/' , calle, '(' , telefono , ')')
from empleados join departamentos
using (numde)
where nomde = 'PERSONAL' or nomde = 'FINANZAS';

-- 4
select nomem, nomde
from departamentos join dirigir 
	on departamentos.numde = dirigir.numdepto
    join empleados
    on empleados.numem = dirigir.numempdirec
where nomde = 'PERSONAL';

-- 5
select nomde, presude, nomce
from departamentos join centros
using (numce)
where nomce = ' SEDE CENTRAL';

-- 5 Obtener el nombre y el presupuesto de los departamentos que están 
-- ubicados en la "Sede Central". Este es el procedimiento de obtenga-muestra
delimiter $$;
create procedure apartado5a(in ubicacion varchar (20))
begin
	select nomde, presude, nomce
	from departamentos join centros
	using (numce)
	where nomce = ubicacion
    order by 1 desc;
end $$;

-- 5 ahora hay que hacerlo con el devuelva, varias datos "Procedimiento con 
-- parámetros de salida"
drop procedure if exists apartado5b;
delimiter $$;
create procedure apartado5b(in nombreCentro varchar (60), out nombreDpto varchar (60),
out presupuestoDpto decimal(10,2))
begin
	select departamentos.nomde, departamentos.presude into nombreDpto, presupuestoDpto
    from departamentos join centros
	using (numce)
    where centros.nomce = nombreCentro
    limit 1;
end $$;

-- Devuelve el presupuesto y el nombre del centro de un departamente dado (su nombre)

-- 6
select nomce, presude
from centros join departamentos
using (numce)
where presude between 100000 and 150000;

-- 7
select distinct extelem, nomde
from empleados join departamentos
using (numde)
where nomde = 'FINANZAS';

-- 8 
select concat_ws(' ' ,nomem, ape1em, ape2em) as NombreCompleto
from dirigir join empleados 
	on empleados.numem = dirigir.numempdirec
    join departamentos
    on departamentos.numde = dirigir.numdepto;
    
-- 9
drop procedure if exists apartado9;
delimiter $$;
create procedure apartado9(in empleado varchar(30), in apellido1 varchar(30))
begin 
	select extelem, nomce, nomem
	from empleados join departamentos
	using (numde) join centros 
	using (numce)
	where nomem = empleado and ape1em = apellido1;
end $$;

-- Para ver el nombre del centro de trabajo de cada empleado
select *
from empleados;

-- 10
drop procedure if exists apartado10;
delimiter $$
create procedure apartado10(in departamento varchar(20))
begin
	select concat_ws(' ' ,nomem, ape1em, ape2em) as NombreCompleto,
	nomde
	from empleados join departamentos
	using (numde)
	where nomde = departamento;
end $$
delimiter ;

-- 11
drop procedure if exists apartado11;
delimiter $$
create procedure apartado11(in departamento varchar(20))
begin
	select nomem, nomde
	from departamentos join dirigir 
	on departamentos.numde = dirigir.numdepto
    join empleados
    on empleados.numem = dirigir.numempdirec
	where nomde = departamento;
end $$
delimiter ;

-- Sirve para mirar todos los departamentos
select *
from departamentos;

-- 12 
drop procedure if exists apartado12;
delimiter $$
create procedure apartado12(in centro varchar(20))
begin
	select nomde, presude, nomce
	from departamentos join centros
	using (numce)
	where nomce = centro;
end $$
delimiter ;

-- 13
drop procedure if exists apartado13;
delimiter $$
create procedure apartado13(in presupuesto1 int(10), in presupuesto2 int(10))
begin 
	select nomce, presude
	from centros join departamentos
	using (numce)
	where presude between presupuesto1 and presupuesto2;
end $$
delimiter ;

-- 14
drop procedure if exists apartado14;
delimiter $$
create procedure apartado14(in departamento varchar(20))
begin
	select distinct extelem, nomde
	from empleados join departamentos
	using (numde)
	where nomde = departamento;
end $$
delimiter ;




