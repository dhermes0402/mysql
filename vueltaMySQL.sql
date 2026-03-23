-- Hallar el salario máximo y mínimo para
-- cada grupo de empledaos con igual número de hijos
-- y que tengas al menos un hijo, y solo si hay más de un 
-- empleado en el grupo

select numhiem ,max(salarem) as salario_maximo, min(salarem) as salario_minimo
from empleados
where numhiem >= 1
group by numhiem -- unificar null a 0, ifnull(numhiem,0)
-- para que no me salga el valor null, ifnull(numhiem, 'indeterminado') (Poner tambien en la cabecera)
having count(*) >= 1
order by numhiem asc; -- Esto es adicional, para hacerlo en orden