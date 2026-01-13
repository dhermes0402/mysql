/* 1 */
select *
from empleados;

/* 2 */
select *
from empleados
where nomem = 'Juan' and ape1em = 'Lopez';

/* 3 */
select nomem, ape1em, ape2em
from empleados
where numhiem > 0;

/* 9 */
select nomem, ape1em, ape2em
from empleados
where fecinem <= '2025/1/12'
order by fecinem;

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
			