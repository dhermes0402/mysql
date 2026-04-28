-- EJEMPLO TRIGGER
-- “En una empresa de ventas, no se puede vender un producto si no hay stock suficiente.
-- Además, cuando se realice una venta, se debe descontar automáticamente del stock.
-- Y si el stock baja de 5 unidades, se debe generar un pedido automático.”

-- 1 TRIGGER --> CONTROL (BEFORE INSERT)
delimiter $$
CREATE TRIGGER comprobar_stock
BEFORE INSERT ON detalleventa
FOR EACH ROW
BEGIN
   DECLARE stock_actual int;

   SELECT stock INTO stock_actual
   FROM producto
   WHERE id = NEW.idproducto;

   IF NEW.cantidad > stock_actual THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Stock insuficiente';
   END IF;
END $$
delimiter ;

-- 2 TRIGGER --> Acción (AFTER INSERT)
delimiter $$
CREATE TRIGGER actualizar_stock
AFTER INSERT ON detalleventa
FOR EACH ROW
BEGIN
   UPDATE producto
   SET stock = stock - NEW.cantidad
   WHERE id = NEW.idproducto;
END $$
delimiter ;

-- 3 TRIGGER --> Acción extra (AFTER)
delimiter $$
CREATE TRIGGER pedido_automatico
AFTER UPDATE ON producto
FOR EACH ROW
BEGIN
   IF NEW.stock < 5 THEN
      INSERT INTO pedido (idproducto, fecha)
      VALUES (NEW.id, NOW());
   END IF;
END $$
delimiter ;

-- Cuerpo del trigger
-- Update
BEGIN
   UPDATE tabla
   SET campo = nuevo_valor
   WHERE id = NEW.id;
END;

-- Otro
BEGIN
   UPDATE tabla
   SET total = (
       SELECT COUNT(*)
       FROM otra_tabla
       WHERE condicion
   )
   WHERE id = OLD.id;
END;

-- Insert 
BEGIN
   INSERT INTO pedidos (idproducto, fecha)
   VALUES (NEW.idproducto, NOW());
END;

-- Delete
BEGIN
   DELETE FROM detalles
   WHERE idpedido = OLD.id;
END;

-- Añadir tablas
alter table articulos
	add column stock int not null default 0;


-- EJEMPLO EVENTOS
-- Cada mes, la empresa debe generar automáticamente los recibos de los clientes.
CREATE EVENT generar_recibos
ON SCHEDULE
   EVERY 1 MONTH
   STARTS '2026-05-01'
   ENDS '2027-05-01'
DO
   CALL crearRecibosMes();

-- 🔹 IMPORTANTE
-- Si no funciona:
-- SET GLOBAL event_scheduler = ON;

-- EJEMPLO ÍNDICES
-- Tengo una tabla con 1 millón de clientes y busco por NIF.

-- SIN Índice: SELECT * FROM cliente WHERE nif = '12345678A';
-- CON Índice: CREATE INDEX idx_nif ON cliente(nif);

-- Tipos importantes: 
-- UNIQUE
CREATE UNIQUE INDEX idx_nif ON cliente(nif);

-- MULTICOLUMNA
CREATE INDEX idx_nombre_apellido ON cliente(nombre, apellido);


