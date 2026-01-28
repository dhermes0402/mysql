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

-- 1
select *
from reservas
where fecreserva between '2021/01/01' and '2021/03/30'
and numdiasestancia >= 3;
    
-- 2
select codreserva, importedevol,
concat_ws(' ', nomcli, ape1cli, ape2cli) as nombreCompletoYReserva
from devoluciones join reservas
using (codreserva) join clientes 
on reservas.codcliente = clientes.codcli
where fecreserva between '2000/01/01' and '2026/01/01';
    
-- 3
drop procedure if exists simulacro3;
delimiter $$
create procedure simulacro3(in numcaracter int(10))
begin
	select numcaracter, nomcasa, poblacion, codtipocasa
    from casas join caracteristicasdecasas 
    using (codcasa) join caracteristicas
    on caracteristicas.numcaracter = caracteristicasdecasas.codcasa
    order by casas.m2 desc;
end $$
delimiter ;

-- 4
drop procedure if exists simulacro4;
delimiter $$
create procedure simulacro4(in numcaracter int(10))
deterministic
begin
	select caracteristicas.nomcaracter
    from casas join caracteristicasdecasas
    using (codcasa) join caracteristicas
    on caracteristicas.numcaracter = caracteristicasdecasas.codcasa
    where numcaracter;
end $$
delimiter ;

delimiter $$
drop procedure if exists simulacroP4;
$$
create procedure simulacroP4(codigoCasa int(30))
deterministic
begin
	select nomcaracter
    from caracteristicas
    where numcaracter = codigoCasa;
end $$
delimiter ;

-- 5
drop procedure if exists simulacro5;
delimiter $$
create procedure simulacro5(nombreCasa varchar(80))
deterministic
begin
	select nombreCasa, caracteristicas.numcaracter
	from casas join caracteristicasdecasas
    using (codcasa) join caracteristicas
    on caracteristicas.numcaracter = caracteristicasdecasas.codcasa
    where nomcasa = nombreCasa;
end $$
delimiter ;

-- 6 
select preciobase/fecreserva
from casas join reservas
using ...
where ...

-- 7 
drop procedure if exists simulacro7;
delimiter $$
create procedure simulacro7(in codigoReserva int(10))
begin
	select nompropietario, concat_ws(' ', tlf_contacto, '//', correoelectronico) 
    as CorreoYTelefono
	from propietarios
    where codreserva = codigoReserva;
end $$
delimiter ;

-- Sirve para ver todos los datos de las reservas
select *
from reservas;

-- 8 
drop procedure if exists simulacro8;
delimiter $$
create procedure simulacro8()
begin
	select 
    
-- 9
drop procedure if exists simulacro9;
delimiter $$
create procedure simulacro9()
begin 
	select 
    
delimiter $$
drop procedure if exists simulacroP5;
$$
create procedure simulacroP5(nombreCasa varchar (80))
deterministic
begin
select nombreCasa, numcaracter as numeroCaracteristicas
    from casas join caracteristicasdecasas
    using(codcasa)
    join caracteristicas
    on caracteristicasdecasas.codcaracter = caracteristicas.numcaracter
    where nomcasa = nombreCasa;
end $$
delimiter ;
call simulacroP5("jazmin");
    

