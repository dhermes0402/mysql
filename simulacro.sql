-- 1
drop procedure if exists simulacro1;
delimiter $$
create procedure simulacro1()
begin 
	select *
    from reservas
    where 
    
-- 2
drop procedure if exists simulacro2;
delimiter $$
create procedure simlacro2()
begin
	select numdevol, importedevol,
    concat_ws(' ',codreserva, nomcli, ape1cli, ape2cli) as nombreCompletoYReserva
    from devoluciones join reservas
	using (codreserva) join clientes 
    using ...
    where ...
end $$
delimiter ;
    
-- 3
drop procedure if exists simulacro3;
delimiter $$
create procedure simulacro3(in codigoCaracteristica int(10))
begin
	select codcasa, nomcasa, poblacion, nomtipo
    from casas join caracteristicasdecasas 
    using (codcasa)
    where codcaracter = codigoCaracteristica;
end $$
delimiter ;

-- 4
drop procedure if exists simulacro4;
delimiter $$
create procedure simulacro4(in codigoCasa int(10))
begin
	select nomcaracter
    from caracteristicas 
    where codcasa = codigoCasa;
end $$
delimiter ;

-- 5
select numcaracter
from casas;

-- 6 
select preciobase/fecreserva
from casas join reservas
using ...
where ...

