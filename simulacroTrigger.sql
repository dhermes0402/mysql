-- Simulacro trigger
-- p1 --------------
drop trigger if exists controlarPromocion;
delimiter $$
create trigger controlarPromocion
before insert on catalogospromos
for each row
begin
declare precioVenta decimal(10,2);

	-- valor absoluto
	select precioventa into precioVenta
    from articulos
    where refart = new.refart;
    
    set new.precioartpromo = abs(new.precioartpromo);
    if new.precioartpromo >= precioVenta then
    signal sqlstate '45000'
    set message_text = 'El precio con promoción no puede ser mayor o igual';
    end if;
end $$
delimiter ;

insert into catalogospromos (refart, codpromo, precioartpromo)
values ('C1_01', 6, 10.00);
select * from catalogospromos;
select * from articulos;

-- editar
drop trigger if exists controlarPromocionEditar;
delimiter $$
create trigger controlarPromocionEditar
before update on catalogospromos
for each row
begin

    if (new.precioartpromo <> old.precioartpromo) and
    new.precioartpromo >= (select precioventa 
    from articulos
    where refart = new.refart)
    then
    signal sqlstate '45000'
    set message_text = 'El nuevo precio con promoción no puede ser mayor o igual';
    end if;
end $$
delimiter ;

update catalogospromos
set precioartpromo = 0.90
where refart = 'C1_01' and codpromo = 6;

-- 2 -----------------------
-- editar pero pones el precio de antes
drop trigger if exists controlarPromocionEditarAntes;
delimiter $$
create trigger controlarPromocionEditarAntes
before update on catalogospromos
for each row
begin

    if (new.precioartpromo <> old.precioartpromo) and
    new.precioartpromo >= (select precioventa 
    from articulos
    where refart = new.refart)
    then
    set new.precioartpromo = old.precioartpromo;
    end if;
end $$
delimiter ;

-- 3 --------------------------------
drop event if exists evento1;
delimiter $$
create event evento1
on schedule
	every 2 quarter
    starts curdate() + interval 5 day
    ends (curdate() + interval 5 day) + interval 1 year
    
    do
    
    call OptimizaCatalogosPromos();
$$
delimiter ;
    
    

    
    
