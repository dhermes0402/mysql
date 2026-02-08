-- Ejercicio 3
-- 1
drop procedure if exists e1;
delimiter $$ 
create procedure e1()
begin
	select max(salarem) as maximo 
    from empleados;
end $$
delimiter ;

-- 2
delimiter $$ 
create procedure e2()
begin
	select min(salarem) as minimo
    from empleados;
end $$
delimiter ;

-- 3
delimiter $$ 
create procedure e3()
begin
	select avg(salarem) as media
    from empleados;
end $$
delimiter ;

-- 4
drop procedure if exists e4;
delimiter $$ 
create procedure e4()
begin
	select max(salarem) as maximo,
	min(salarem) as minimo,
	avg(salarem) as media
	from empleados join departamentos
    using (numde)
    where nomde = 'ORGANIZACION';
end $$
delimiter ;

-- 5
drop procedure if exists e5;
delimiter $$ 
create procedure e5(in departamento varchar(20))
begin
	select max(salarem) as maximo,
	min(salarem) as minimo,
	avg(salarem) as media
	from empleados join departamentos
    using (numde)
    where nomde = departamento;
end $$
delimiter ;

-- 6
delimiter $$ 
create procedure e6(in departamento varchar(20))
begin
	select sum(salarem) as sumaSalarios
    from empleados join departamentos
    using (numde)
    where nomde = departamento;
end $$
delimiter ;

-- 7
delimiter $$ 
create procedure e7()
begin
	select sum(presude) as presupuesto
    from departamentos;
end $$
delimiter ;

-- 8
drop procedure if exists e8;
delimiter $$ 
create procedure e8()
begin
	select max(salarem) as maximo,
	min(salarem) as minimo,
	avg(salarem) as media,
    nomde
	from empleados join departamentos
    using (numde)
    group by nomde;
end $$
delimiter ;

-- 9
delimiter $$ 
create procedure e9()
begin
	select count(extelem) 
    from empleados;
end $$
delimiter ;

-- 10
drop procedure if exists e10;
delimiter $$ 
create procedure e10(in departamento varchar(20))
begin
	select count(distinct extelem), nomde
    from empleados join departamentos
    using (numde)
    where nomde = departamento;
end $$
delimiter ;

-- 11
drop procedure if exists e10;
delimiter $$ 
create procedure e10()
begin
	select count(distinct extelem), nomde
    from empleados join departamentos
    using (numde)
    group by nomde;
end $$
delimiter ;