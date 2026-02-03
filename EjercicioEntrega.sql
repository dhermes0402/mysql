-- Actividad para entregar
-- Nos piden que para la BD empresaclase y dado el número de empleado (numem), 
-- preparemos una rutina con la que podamos obtener la dirección en la que 
-- trabaja dicho empleado.
-- Diseña las siguientes rutinas:
-- a) Al llamarla (call), muestre la dirección del empleado.
-- b) Al llamarla (call), devuelva la dirección del empleado.
-- c) Al ejecutarla devuelva la dirección del empleado.

-- Obtenga- muestra  -> procedimiento
-- Devuelva 1 dato -> función
-- Devuelve varios datos -> procedimiento con parámetros de salida

drop procedure if exists tareaentregarA;
delimiter $$;
create procedure tareaentregarA(in ubicacion INT)
begin
select dirce
from empleados join departamentos
	using (numde)
    join centros
    using (numce)
where nomce = ubicacion
order by 1 desc;

end $$;

drop procedure if exists tareaentregarB;
delimiter $$;
create procedure tareaentregarB(in ubicacion INT)
begin

select dirce
from empleados join departamentos
	using (numde)
    join centros
    using (numce)
where nomce = ubicacion
limit 1;

end $$;

select dirce
from empleados join departamentos
	using (numde)
    join centros
    using (numce)
where nomce = ubicacion
limit 1;

delimiter $$
create function TareaDeClaseC(numeroEmpleado int (60))
returns VARCHAR(60)
deterministic
begin
declare direccion varchar(60);

select dirce into direccion 
from centros join departamentos 
	using (numce)
join empleados
	using (numde)
where numem = numeroEmpleado;
return direccion;
end $$
delimiter ;

-- Una FUNCION entre sumas
delimiter $$
drop function if exists SumaDosNumeros$$
create function SumaDosNumeros (n1 int, n2 int)
returns int 
deterministic 
begin
	return n1 + n2;
    return rtdo;
end $$ 
delimiter ;

-- devuelve el nombre completo de un empleado, dado su código
delimiter $$
	drop function if exists DevulveNombre$$
    
	create function DevuelveNombre (numEmpleado int)
	returns varchar(65)
	deterministic 
    begin
		declare DevuelveNombre varchar(65);
			select concat_ws(' ', nomem, ape1em, ape2em) into nombreEmpleado
            from empleados 
            where numem = numEmpleado;
            return nombreEmpleado;
	end $$ 
delimiter ;

-- Los procedimientos no pueden tener un return
delimiter $$
	drop procedure if exists ProcDevulveNombre$$
    
	create procedure ProcDevuelveNombre(numEmpleado int)
	deterministic 
    begin
			select concat_ws(' ', nomem, ape1em, ape2em) as nombreCompleto
            from empleados 
            where numem = numEmpleado;
	end $$ 
delimiter ;

-- Cuando hay procedimiento hay que llamarlo
call ProcDevuelveNombre (190);

-- devuelve el nombre completo de un empleado y su extensión teléfonica, dado su código 
delimiter $$
drop procedure if exists DevNombreYExtelEm$$
create procedure DevNombreYExtelEm(numEmpleado int, out nombre varchar(65)
, out extension char(3))
deterministic
begin
    select concat_ws(' ', nomem, ape1em, ape2em), extelem into nombre, extension
    from empleados
    where numem = numEmpleado;

end $$
delimiter ;

call DevNombreYExtelEm (210, @nombre, @extension);
select @nombre, @extension;

-- Dado un número de empleado devuelve el nombre del departamento en el que se encuentra
-- Base de datos alterna en la que la clave primaria es numde y numce
drop procedure if exists BaseDebil;
delimiter $$
create procedure BaseDebil(in numeroEmpleado int(10))
begin
	select nomde
	from empleados join departamentos
		using (numde, numce)
	where numem = numeroEmpleado;
end $$
delimiter ;


