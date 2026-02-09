-- simulacro 2
-- 1
INSERT INTO reservas
(codcliente, codcasa, fecreserva, pagocuenta, feciniestancia, numdiasestancia, observaciones)
VALUES
(520, 315, CURDATE(), 100, '2026-08-05', 7, NULL);

describe reservas;

select *
from casas 
where codcasa = 315;

-- 2
insert into caracteristicasdecasas (codcasa, codcaracter)
values
(350, 17),
(350, 3),
(350, 5);

-- 3
delete 
from reservas
where codreserva = 2450;
insert into reservas 
(pagocuenta)
values
(200);

start transaction;

insert into devoluciones (numdevol, codreserva, importedevol)
values (226, 2450, 200);

update reservas 
set fecanulacion = curdate()
where codreserva = 2450;

commit;

-- 4
DROP PROCEDURE IF EXISTS baja_propietario;

DELIMITER $$

CREATE PROCEDURE baja_propietario(IN idprop INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Si hay error, revertimos toda la transacción
        ROLLBACK;
        SELECT 'Error: No se pudo completar la operación. Posibles dependencias.' AS mensaje;
    END;
    
    START TRANSACTION;
    
    -- Primero borramos las casas del propietario
    DELETE FROM casas
    WHERE codpropi = idprop;
    
    -- Luego borramos el propietario
    DELETE FROM propietarios
    WHERE codpropietario = idprop;
    
    COMMIT;
    
    SELECT 'Operación completada correctamente.' AS mensaje;
END $$

DELIMITER ;

-- 5 
update casas
set 
	numhabit = 3,
    m2 = 200,
    minpersonas = 4,
    maxpersonas = 8
where codcasa = 5789;

-- 6

-- FREE BUILD 

-- 1º Insertar una reserva nueva
insert into --
()
values
();

curdate() es para la fecha actual

-- 2º Añadir características a una casa
insert into --
()
values
(),
(),
();

-- 3º Anular una reserva y registrar la devolución
-- Primero tenemos que insertar la devolución
insert into --
()
values
() ;

-- Anulamos la reserva
delete from --
where -- = --;

-- 4º Procedimiento con transacción
drop procedure if exists p1;

delimiter $$
create procedure p1()
begin 
	declare exit handler for sqlexception
    begin
		rollback;
        select ' '  as ;
	end;
    
    strat transaction;
    delete from --
    where cod = name;
    
    delete from --
    where cod = name;
    
    COMMIT;
    
    select ' ' as ;
end $$
delimiter ;

-- 5
update --
set -- haces actualizaciones
where cod = num;

-- 6
-- Mover datos de una empresa a otra
drop procedure if exists p3;

delimiter $$
create procedure p3()
begin
	declare exit handler for sqlexception
    begin
		rollback;
		select ' ' as ;
    end;
    
    start transaction;
    
    set @ultimo... = (select ifnull(max(cod), 0) from)
	set @ultimo... = (select ifnull(max(cod), 0) from)
    
    insert into bd
		()
    select 
    @ultimo... + cod,
    nom,
    tel,
    email
    from bd;
    
    insert into bd
		()
	select @ultimo... + cod,
    ...,
    ...,
    ...
    from bd;
    
    commit;
    
    select ' ' as;
    end $$
    delimiter ;
    
    -- 7
    -- a
    delimiter $$
    create procedure lo1(in zona int(20))
    begin
		select codcasa
		from casas join zonas
		on casas.codzona = zonas.numzona
		where codzona = zona;
	end $$
    delimiter ;
    
    -- b
    insert into casas
    (codcasa, nomcasa, codzona)
    values
    (10, 'diego', 1);
    
    -- c 
    insert into reservas
    (codcliente, codreserva, codcasa)
    values
    (1000, 500, 10);
    
    
    
    

