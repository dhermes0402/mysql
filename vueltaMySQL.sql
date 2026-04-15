-- Hallar el salario máximo y mínimo para
-- cada grupo de empledaos con igual número de hijos
-- y que tengas al menos un hijo, y solo si hay más de un
-- empleado en el grupo

select numhiem ,max(salarem) as salario_maximo, min(salarem) as salario_minimo
from empleados
where numhiem >= 2
group by numhiem -- unificar null a 0, ifnull(numhiem,0)
-- para que no me salga el valor null, ifnull(numhiem, 'indeterminado') (Poner tambien en la cabecera)
having count(*) >= 1
order by numhiem asc; -- Esto es adicional, para hacerlo en orden

-- Hallar el máximo valor de la suma de los salarios de los departamentos
select max(suma) as max_salarios
from (
select sum(salarem) as suma
    from empleados
    group by numde
) as subSelect;

select numde, sum(salarem)
from empleados
    group by numde
    having sum(salarem) > all (select sum(salarem)
from empleados
group by numde);
                               
-- Obtener los nombres de los centros, si hay alguno en la C/ Atocha. Si no hay
-- ninguno en la calle atocha no salen nombres de centros, si hay
-- si salen el nombre de todos los centros
select nomce
from centros
    where exists (select * from centros where dirce = ' C.ATOCHA, 405, MADRID');
    -- where exists (select * from centros where direce like '%C. atocha%');
    -- like ' _' sustituye a un carácter por _ mientras %sustituye los que hagan falta