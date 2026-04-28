-- Ejercicios Triggers
-- 1 ---------------------------------
-- Comprueba que no podamos contratar a empleados que no tengan 16 años.
use empresaclase;
drop trigger if exists compruebaEdad
delimiter $$
create trigger compruebaEdad
before insert on empleados
for each row
begin 
	if (new.fecnaem > date_sub(curdate(),interval 16 year)) then
    signal sqlstate '45000'
    set message_text = 'edad insuficiente';
    end if;   
end $$
delimiter ;

-- Comprobar que existe
show triggers from empresaclase;

-- Comprobar que funciona
insert into empleados (numem, fecnaem, nomem, fecinem)
values (10, '2010-01-01', 'Diego', '2016-01-01');

select numem, fecnaem, nomem, fecinem from empleados;

-- 2 --------------------------------------
-- Comprueba que el departamento de las personas que ejercen la 
-- dirección de los departamentos pertenezcan a dicho departamento.
drop trigger if exists comprobarDepartamento;
delimiter $$ 
create trigger comprobarDepartamento 
before insert on dirigir
for each row
begin
	if  (select numde 
		from empleados 
        where numem = new.numempdirec )
        <> new.numdepto then
    begin    
	signal sqlstate '45000' 
    set message_text = 'Error de departamento';
    end;
    end if;
end $$
delimiter ;

insert into dirigir (numdepto, numempdirec, fecinidir, fecfindir, tipodir)
values (110, 150, '2010-01-01', '2012-01-01', '1');

-- 3 ---------------------------------------------
-- Añade lo que consideres oportuno para que las comprobaciones anteriores 
-- se hagan también cuando se modifiquen la fecha 
-- de nacimiento de un empleado o al director/a de un departamento.
-- Sobre ej 1
drop trigger if exists compruebaEdad2;
delimiter $$
create trigger compruebaEdad2
before update on empleados
for each row 
begin 
	if old.fecnaem <> new.fecnaem -- hay que comprobar si el campo modificado es el que nos afecta
	and (new.fecnaem > date_sub(curdate(),interval 16 year)) then
    signal sqlstate '45000'
    set message_text = 'Error de edad';
    end if;
end $$
delimiter ;

update empleados
set fecnaem = '2008-02-02'
where numem = 10;

select numem, fecnaem, nomem, fecinem from empleados;

-- Sobre ej 2
drop trigger if exists comprobarDepartamento2;
delimiter $$
create trigger comprobarDepartamento2
before update on dirigir
for each row 
begin 
	if old.numdepto<>new.numdepto 
    and (select numde 
		from empleados 
        where numem = new.numempdirec )
        <> new.numdepto then
        signal sqlstate '45000' 
        set message_text = 'Error de departamento';
	end if;
end $$
delimiter ;

-- 3.1 Update
update dirigir 
set fecinidir = curdate()
where numempdirec = 150
and numdepto = 121 and fecinidir = '2003-08-03';

select nomde, numempdirec, numdepto, fecinidir
from dirigir join departamentos
on dirigir.numdepto = departamentos.numde;

-- 3.2 Update
update dirigir 
set numdepto = 111
where numempdirec = 150
and numdepto = 121 and fecinidir = '2003-08-03';

select nomde, numempdirec, numdepto, fecinidir
from dirigir join departamentos
on dirigir.numdepto = departamentos.numde;

-- 4 -----------------------------------------------------
-- Añade una columna numempleados en la tabla departamentos.
-- En ella vamos a almacenar el número de empleados de cada departamento.
alter table departamentos
	add column numempleados int not null default 0;
    
select * from departamentos;

-- 5 ------------------------------------------------
-- Prepara un procecdimiento que para cada departamento calcule el número de 
-- empleados y guarde dicho valor en la columna creada en el apartado 4.
drop procedure if exists calcularEmpleados;
delimiter $$
create procedure calcularEmpleados()
begin
	update departamentos
    set numempleados = (select count(*)
    from empleados
    where empleados.numde = departamentos.numde);
end $$
delimiter ;

select * from departamentos;

-- 6 -------------------------------------------------------
-- Prepara lo que consideres necesario para que cada trimestre se compruebe y actualice, 
-- en caso de ser necesario, el número de empleados de cada departamento.
drop event if exists actualizarTrimestres;
delimiter $$
create event actualizarTrimestres
on schedule
	every 1 quarter
    starts curdate()
    
    do
    begin
		call calcularEmpleados();
	end $$
delimiter ;

SHOW EVENTS;
show variables like 'actualizarTrimestres';

-- 7 ----------------------------------------------------------------
-- Asegúrate de que cuando eliminemos a un empleado, se actualice el número de 
-- empleados del departamento al que pertenece dicho empleado.
drop trigger if exists comprobarEmpleados;
delimiter $$
create trigger comprobarEmpleados
after delete on empleados
for each row
begin
	update departamentos
    set numempleados = (select count(*)
    from empleados
    where numde = old.numde)
    where numde = old.numde; -- Te indica justo que actualice el departamento que 
							 -- acabo de borrar
end $$
delimiter ;

-- 8
-- Añade el campo dni en la tabla de alumnado.
-- Añade la tabla profesorado (codprof, nomprof, ape1prof, ape2prof, dniprof).
-- Añade una clave foránea en materias ⇒ codprof references a profesorado (codprof).
-- Introduce datos en las tablas y campos creados para hacer pruebas.
use gbdgestionatests;
alter table alumnos
	add column dnialum char(9) null;

create table profesorado
(
	codprof int, 
	nomprof varchar(60) not null, 
	ape1prof varchar(60) not null, 
	ape2prof varchar(60) null, 
	dniprof char(9) not null,
    constraint pk_profesorado primary key (codprof)
);

alter table materias
	add column codprof int,
	add constraint fk_materias_profesorado foreign key (codprof) references profesorado(codprof);

INSERT INTO alumnos (numexped, nomalum, ape1alum, ape2alum, dnialum) 
VALUES
(100, 'Ana', 'Martínez', 'Ruiz', '11111111A'),
(200, 'Luis', 'Gómez', 'Pérez', '22222222B'),
(300, 'Elena', 'Navarro', NULL, '33333333C');

INSERT INTO profesorado (codprof, nomprof, ape1prof, ape2prof, dniprof) 
VALUES
(1, 'Juan', 'Pérez', 'García', '12345678A'),
(2, 'María', 'López', 'Sánchez', '23456789B'),
(3, 'Carlos', 'Ruiz', NULL, '34567890C');

UPDATE materias SET codprof = 1 WHERE codmateria = 1;
UPDATE materias SET codprof = 2 WHERE codmateria = 2;
UPDATE materias SET codprof = 3 WHERE codmateria = 3;

-- 10
-- La fecha de publicación de un test no puede ser anterior a la de creación.
drop trigger if exists comprobarFechaCreacion;
delimiter $$
create trigger comprobarFechaCreacion
before insert ON tests
for each row
begin 
	if new.fecpublic < new.feccreacion then
    signal sqlstate '45000'
    set message_text = 'La fecha de publicación no puede ser anterior a la de creacion';
    end if;
end $$
delimiter ;

drop trigger if exists comprobarFechaCreacionEditar;
delimiter $$
create trigger comprobarFechaCreacionEditar
before update ON tests
for each row
begin 
	if (new.fecpublic <> old.fecpublic or new.feccreacion <> old.feccreacion)
    and new.fecpublic < new.feccreacion then
    signal sqlstate '45000'
    set message_text = 'La fecha de publicación no puede ser anterior a la de creacion';
    end if;
end $$
delimiter ;

-- 11 -------------------------------------------------
-- El alumnado no podrá hacer más de una vez un test (ya existe el registro de dicho 
-- test para el alumno/a) si dicho test no es repetible (tests.repetible = 0|false).
drop trigger if exists noRepetirTests;
delimiter $$
create trigger noRepetirTests
before insert on respuestas
for each row
begin 
	if (
	select repetible 
    from tests 
    where codtest = new.codtest) = false and
    (select count(*) from respuestas where codtest = new.codtest
    and numexped = new.numexped) > 0 then
    signal sqlstate '45000'
    set message_text = 'No se puede repetir el test';
    end if;
end $$
delimiter ;

-- abs (Valor absoluto)
-- Ejercicio 2 BDALMACEN
DROP TRIGGER IF EXISTS cantidadPositivaYCompruebaStock;

DELIMITER $$

CREATE TRIGGER cantidadPositivaYCompruebaStock
BEFORE INSERT ON pedidos
FOR EACH ROW
BEGIN
    -- 1. Evitar negativos
    SET NEW.cantidad = ABS(NEW.cantidad);

    -- 2. Comprobar stock
    IF (SELECT stock 
        FROM productos 
        WHERE codproducto = NEW.codproducto) < NEW.cantidad THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No hay suficiente stock para este pedido';
    END IF;

    -- 3. Si no ha fallado, aquí sigue el código (stock suficiente)
    UPDATE productos
    SET stock = stock - NEW.cantidad
    WHERE codproducto = NEW.codproducto;

END $$

DELIMITER ;

-- ejer 3
delimiter $$
drop trigger if exists actualizaStock $$
create trigger actualizaStock
	after update on productos
for each row
begin
	declare nuevopedido int;
	if old.stock <> new.stock and new.stock < 5 then
    begin
		set nuevopedido = (select max(codpedido) from pedidos) + 1;
		insert into pedidos
			(codpedido, fecpedido, fecentrega, codproducto, cantidad)
		values
			(nuevopedido, curdate(), null, new.codprudto, 5);
    end;
    end if;
end $$
delimiter ;








    



