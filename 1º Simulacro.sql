/*
   preparar una rutina 
	--> obetener/mostrar --> procedure 
	--> devolver 
		--> 1 valor --> funcion
		--> +1 valor --> procedure con parametro de salida
 */	
 -- rutinas mysql
/* procedures --> no devuelven nada
	--> podemos usar parametros de salida (pueden ser varios)(escalar)
   function --> funciones que devuelven valores 
				deterministic */
 
 -- Obtenga- muestra  -> procedimiento
-- Devuelva 1 dato -> función
-- Devuelve varios datos -> procedimiento con parámetros de salida

-- 1
select *
from reservas
where feciniestancia between '2021-01-01' and '2021-03-30'and
numdiasestancia > 3;

-- 2
select devoluciones.codreserva, concat_ws(' ', nomcli, ape1cli, ape2cli) 
as nombreCompleto, importedevol
from reservas join devoluciones 
using (codreserva) join
clientes on reservas.codcliente = 
clientes.codcli
where fecreserva <= '2025-08-02';

-- 3
drop procedure if exists s1;
delimiter $$
create procedure s1(in caracteristica varchar(40))
begin
	select codcasa, nomcasa, poblacion, tiposcasa.nomtipo
    from tiposcasa join casas
    on tiposcasa.numtipo = casas.codtipocasa
    join caracteristicasdecasas
    using (codcasa) join caracteristicas
    on caracteristicasdecasas.codcaracter = caracteristicas.numcaracter
    where codcaracter = caracteristica
    order by poblacion, m2 asc;
end $$
delimiter ;

-- 4
drop procedure if exists s2;
delimiter $$
create procedure s2(in casa int(20))
begin
	select caracteristicas.nomcaracter
    from casas join caracteristicasdecasas
    using (codcasa) join caracteristicas
    on caracteristicasdecasas.codcaracter = caracteristicas.numcaracter
    where codcasa = casa;
end $$
delimiter ;

-- 5
drop procedure if exists s3;
delimiter $$
create procedure s3()
begin 
	select codcasa, count(numcaracter) as numeroCaracteristica
    from caracteristicasdecasas
    group by codcasa;
end $$
delimiter ;

-- 6


-- 7
drop procedure if exists s4;
delimiter $$
create procedure s4()
begin
	select nomcli, concat_ws(' ', tlf_contacto, '//', correoelectronico) as telefYcorreo
	from reservas join clientes
    on reservas.codcliente = clientes.codcli
	where codreserva;
end $$
delimiter ;

-- 8
drop procedure if exists s5;
delimiter $$
create procedure s5()
begin
	select count(codreserva) as numeroReservas, numzona, nomzona
	from reservas join casas
    using (codcasa) join zonas 
    on casas.codzona = zonas.numzona
    where year (fecreserva) = year(curdate())
    group by numzona, nomzona;
end $$
delimiter ;

-- 9
drop procedure if exists s6;
delimiter $$
create procedure s6(in zona int(10))
begin
	select count(codreserva) as numeroReservas, nomzona, numzona
	from reservas join casas
    using (codcasa) join zonas 
    on casas.codzona = zonas.numzona
	where year (fecreserva) = year(curdate()) and numzona = zona
    group by numzona, nomzona;
end $$
delimiter ;
    
-- 10
select avg(m2),
max(numbanios),
max(numhabit)
from casas;








