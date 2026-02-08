-- Empezar a estudiar
-- 1
select *
from empleados;

-- 2 
select extelem
from empleados
where nomem = 'Juan' and ape1em = 'López';

-- 3
select nomem, ape1em, ape2em, numhiem
from empleados
where numhiem > 1;

-- 4 
select concat_ws(' ',nomem, ape1em, ape2em, numhiem) as numHijos
from empleados
where numhiem between 1 and 3;

-- 5
select concat_ws(' ', nomem, ape1em, ape2em) as Nombre, comisem
from empleados
where comisem is null;

-- 6
select dirce 
from centros
where nomce = ' Sede Central';

-- 7
select nomde, presude
from departamentos
where presude > 6000;

-- 8 
select nomde, presude
from departamentos
where presude >= 6000;

-- 9
select concat_ws(nomem, ape1em, ape2em) as empleados,
fecinem
from empleados
where fecinem <= '2025/02/06';

-- 10
select concat_ws(nomem, ape1em, ape2em) as empleados, 
fecinem
from empleados
where fecinem <= '2025/02/06' and fecinem >= '2000/02/06';

-- 11
drop procedure if exists proc1;
delimiter $$
create procedure proc1()
begin 
	select *
	from empleados;
	select concat_ws(' ', nomem, ape1em, ape2em) as Nombre, comisem
	from empleados
where comisem is null;
end $$
delimiter ;

-- 12
drop procedure if exists proc2;
delimiter $$
create procedure proc2(in nombre varchar(50), in apellido varchar(50))
begin 
	select extelem
	from empleados
	where nomem = nombre and ape1em = apellido;
end $$
delimiter ;

-- 13
drop procedure if exists proc3;
delimiter $$
create procedure proc3(in hijos int(10))
begin
	select nomem, ape1em, ape2em, numhiem
	from empleados
	where numhiem = hijos;
end $$
delimiter ;

drop procedure if exists proc4;
delimiter $$
create procedure proc4(in hijos1 int(10), hijos2 int(10))
begin
	select concat_ws(' ',nomem, ape1em, ape2em, numhiem) as numHijos
	from empleados
	where numhiem between hijos1 and hijos2;
end $$
delimiter ; 

-- 14
delimiter $$
create procedure proc5(in centro varchar(30))
begin
	select dirce
    from centros
    where nomce = centro;
end $$ 
delimiter ;

-- 15
delimiter $$
create procedure proc6(in presupuesto int(10))
begin
	select nomde, presude
	from departamentos
	where presude > presupuesto;
end $$
delimiter ;

-- 16
delimiter $$
create procedure proc7(in presupuesto int(10))
begin
	select nomde, presude
	from departamentos
	where presude >= presupuesto;
end $$
delimiter ;

-- 17
delimiter $$
create procedure proc8(in fecha int(10))
begin
	select concat_ws(nomem, ape1em, ape2em) as empleados,
	fecinem
	from empleados
	where fecinem = fecha;
end $$
delimiter ;

-- 18
drop procedure if exists proc9;
delimiter $$
create procedure proc9(in fecha1 date, in fecha2 date)
begin
	select concat_ws(' ', nomem, ape1em, ape2em) as empleados, 
	fecinem
	from empleados
	where fecinem between fecha1 and fecha2;
end $$
delimiter ;

-- 19
drop procedure if exists proc10;
delimiter $$
create procedure proc10(in fecha1 date, in fecha2 date)
begin
	select concat_ws(' ', nomem, ape1em, ape2em) as empleados, 
	fecinem
	from empleados
	where fecinem not between fecha1 and fecha2;
end $$
delimiter ;

-- Quiero saber la dirección donde trabaja un empleado, el que yo quiera en cada caso
-- a través de su número de empleado

drop procedure if exists proc11;
delimiter $$
create procedure proc11(in numeroEmpleado int(10))
begin
	select dirce, nomem, numem
    from centros join departamentos 
    using (numce) join empleados
    using (numde)
    where numem = numeroEmpleado;
end $$
delimiter ;

-- Actividades 2
-- 1
select *, nomde
from empleados join departamentos
using (numde);

-- 2
select nomce, extelem
from empleados join departamentos 
using (numde) join centros
using (numce)
where nomem = 'Juan' and ape1em = 'López';

-- 3
select concat_ws(' ', nomem, ape1em, ape2em) as nombreCompleto
from empleados join departamentos 
using (numde)
where nomde = 'PERSONAL' OR nomde = 'FINANZAS';

-- 4
select nomem
from empleados join dirigir
on empleados.numem = dirigir.numempdirec
join departamentos
on departamentos.numde = dirigir.numdepto
where nomde = 'PERSONAL';

-- 5
select nomde, presude
from departamentos join centros
using (numce)
where nomce = ' SEDE CENTRAL';

-- 6
select nomce, presude
from centros join departamentos
using (numce)
where presude between '100000' and '150000';

-- 7
select distinct extelem, nomde
from departamentos join empleados
using (numde)
where nomde = 'FINANZAS';

-- 8
select concat_ws(' ', nomem, ape1em, ape2em) as nombreCompleto
from departamentos join empleados
using (numde) join dirigir
on dirigir.numempdirec = empleados.numem;

-- 9
drop procedure if exists a1;
delimiter $$
create procedure a1(in nomEm varchar(20), in apeEm varchar(20))
begin
	select nomce, extelem, nomem
	from empleados join departamentos 
	using (numde) join centros
	using (numce)
	where nomem = nomEm and ape1em = apeEm;
end $$
delimiter ;

-- 10
drop procedure if exists a2;
delimiter $$
create procedure a2(in departamento varchar(20))
begin
	select concat_ws(' ', nomem, ape1em, ape2em) as nombreCompleto
	from empleados join departamentos 
	using (numde)
	where nomde = departamento;
end $$
delimiter ;

-- 11
delimiter $$
create procedure a3(in departamento varchar(20))
begin
	select nomem
	from empleados join dirigir
	on empxleados.numem = dirigir.numempdirec
	join departamentos
	on departamentos.numde = dirigir.numdepto
	where nomde = departamento;
end $$
delimiter ;

-- 12
delimiter $$
create procedure a4(in centro varchar(20))
begin 
	select nomde, presude
	from departamentos join centros
	using (numce)
	where nomce = centro;
end $$
delimiter ;

-- 13
delimiter $$
create procedure a5(in minimo int(10), in maximo int(10))
begin 
	select nomce, presude
	from centros join departamentos
	using (numce)
	where presude between minimo and maximo;
end $$
delimiter ;

-- 14
delimiter $$
create procedure a6(in departamento varchar(20))
begin
	select distinct extelem, nomde
	from departamentos join empleados
	using (numde)
	where nomde = departamento;
end $$
delimiter ;

-- Probar out
delimiter $$
CREATE PROCEDURE salario_maximo(OUT maxSal DECIMAL(10,2))
BEGIN
    SELECT MAX(salarem) INTO maxSal
    FROM empleados;
END $$
delimiter ;






