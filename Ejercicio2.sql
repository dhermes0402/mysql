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



