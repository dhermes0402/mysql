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
			