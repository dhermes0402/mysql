/* 1 */
select *
from empleados;

/* 2 */
select extelem
from empleados
where nomem = 'Juan' and ape1em = 'Lopez';

/* 3 */
select nomem, ape1em, ape2em
from empleados
where numhiem > 0;

-- 4
select concat_ws(' ',nomem, ape1em, ape2em) as nombreCompleto,
numhiem
from empleados
where numhiem > 0 and numhiem < 4;

-- 5
select concat_ws(' ',nomem, ape1em, ape2em) as nombreCompleto,
comisem
from empleados
where comisem is null;

-- 6
select dirce
from centros
where nomce = ' SEDE CENTRAL';

-- 7
select nomde, presude
from departamentos
where presude > 6000;

-- 8
select nomde, presude
from departamentos
where presude >= 6000;

-- 9
select concat_ws(' ',nomem, ape1em, ape2em) as nombreCompleto,
fecinem
from empleados
where fecinem <= '2025/1/14';

-- 10
select concat_ws(' ',nomem, ape1em, ape2em) as nombreCompleto,
fecinem
from empleados
where fecinem between '2023/1/14' and '2025/1/14';


-- apuntes
select concat(nomem, ' ',
			ape1em, ' ',
            ifnull(ape2em, ' ')) as nomcompleto1,
            CONCAT_WS(' ', nomem,
					ape1em,
                    ape2em) as nomcompleto2
from empleados
where fecinem <= '2025/1/12'
order by fecinem;
			-- , fecinem
            -- select nomem, ape1em, ape2em, fecinem
            
-- 10
select CONCAT(nomem, ' ',
			ape1em, ' ',
            ifnull(ape2em, ' ')
            )
from empleados
-- where fecinem >= '2022/1/12 
where fecinem between '2022/1/12' and '2025/1/12';

-- (Otra manera de hacerlo con date_sub)
-- where fecinem between date_sub(curdate(), interval 3 year)
				-- and date_sub(curdate(), interval 1 year);
                
-- 11
delimiter $$;
create procedure apartado11a()
begin
	select *
    from empleados;
end $$;

delimiter $$;
create procedure apartado11b()
begin
	select concat_ws(' ',nomem, ape1em, ape2em) as nombreCompleto,
	comisem
	from empleados
	where comisem is null;
end $$;

-- 12
delimiter $$;
create procedure apartado12(in nombre varchar (20), in apellido1 varchar (20))
begin
	select extelem
	from empleados
	where nomem = nombre and ape1em = apellido1;
end $$;

-- 13
delimiter $$;
create procedure apartado13a(in numerohijos varchar (20))
begin
	select nomem, ape1em, ape2em
	from empleados
	where numhiem = numerohijos;
end $$;

delimiter $$;
create procedure apartado13b(in numerohijos varchar (20))
begin
	select concat_ws(' ',nomem, ape1em, ape2em) as nombreCompleto,
	numhiem
	from empleados
	where numhiem = numerohijos;
end $$;

-- 14
delimiter $$;
create procedure apartado14(in nombrecentro varchar (20))
begin
	select dirce
    from centros
    where nomce = nombrecentro;
end $$;

-- Sirve para ver el nombre de los centros de trabajo
select *
from centros

-- 15
drop procedure if exists apartado15;
delimiter $$;
create procedure apartado15(in presupuesto int(10))
begin
	select nomde, presude
	from departamentos
	where presude > presupuesto;
end $$;

-- Sirve para ver el presupuesto de los empleados del departamento
select nomde, presude as presupuesto
from departamentos 

-- 16 
drop procedure if exists apartado16;
delimiter $$;
create procedure apartado16(in presupuesto int(10))
begin
	select nomde, presude
	from departamentos
	where presude >= presupuesto;
end $$;

-- 17
drop procedure if exists apartado17;
delimiter $$;
create procedure apartado17(in fecha date)
begin
	select concat_ws(' ',nomem, ape1em, ape2em) as nombreCompleto,
	fecinem
	from empleados
	where fecinem >= fecha;
end $$;

-- Sirve para ver la fecha
select fecinem
from empleados

-- 18
drop procedure if exists apartado18;
delimiter $$;
create procedure apartado18(in fecha1 date, in fecha2 date)
begin
	select concat_ws(' ',nomem, ape1em, ape2em) as nombreCompleto,
	fecinem
	from empleados
	where fecinem between fecha1 and fecha2;
end $$;

-- 19 
drop procedure if exists apartado19;
delimiter $$;
create procedure apartado19(in fecha1 date, in fecha2 date)
begin
	select concat_ws(' ',nomem, ape1em, ape2em) as nombreCompleto,
	fecinem
	from empleados
	where fecinem not between fecha1 and fecha2;
end $$;



-- Quiero saber la dirección donde trabaja un empleado, el que yo quiera en cada caso
-- a través de su número de emplead

delimiter $$;
create procedure empleado (in numero INT)
begin

select dirce
from empleados join depe
