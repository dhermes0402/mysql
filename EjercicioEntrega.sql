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


