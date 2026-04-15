-- BASE DE DATOS DE TURISMO RURAL.
-- PROCEDIMIENTOS CON OPERACIONES CRUD CON LAS BBDD RELACIONES

-- ZONAS
-- 1: Listar zonas (READ)
DELIMITER $$
DROP PROCEDURE IF EXISTS verZonas;
CREATE PROCEDURE verZonas()
BEGIN
    SELECT 
        numzona AS id,
        nomzona AS nombre
    FROM zonas
    ORDER BY nomzona;
END $$
DELIMITER ;

call verZonas();

-- 2: Ver una zona concreta
DELIMITER $$
DROP PROCEDURE IF EXISTS verZona;
CREATE PROCEDURE verZona(IN p_id INT)
BEGIN
    SELECT *
    FROM zonas
    WHERE numzona = p_id;
END $$
DELIMITER ;

-- 3: Insertar zona (CREATE)
DELIMITER $$
DROP PROCEDURE IF EXISTS nuevaZona $$
CREATE PROCEDURE nuevaZona(IN nombre VARCHAR(20), IN descripcion VARCHAR(50))
BEGIN
    INSERT INTO zonas (nomzona, deszona)
    VALUES (nombre, descripcion);
END $$
DELIMITER ;

-- 4: Actualizar zona (UPDATE)
DELIMITER $$
DROP PROCEDURE IF EXISTS modificarZona;
CREATE PROCEDURE modificarZona(IN id INT, IN nombre VARCHAR(20), IN descripcion VARCHAR(50))
BEGIN
    UPDATE zonas
    SET 
        nomzona = nombre,
        deszona = descripcion
    WHERE numzona = id;
END $$
DELIMITER ;

-- 5: Borrar zona (DELETE)
DELIMITER $$
DROP PROCEDURE IF EXISTS eliminarZona;
CREATE PROCEDURE eliminarZona(IN id INT)
BEGIN
    DELETE FROM zonas
    WHERE numzona = id;
END $$
DELIMITER ;

-- TIPOS DE CASA
-- 2.1 Listar tipos (READ)
DELIMITER $$
DROP PROCEDURE IF EXISTS verTiposCasa;
CREATE PROCEDURE verTiposCasa()
BEGIN
    SELECT 
        numtipo AS id,
        nomtipo AS nombre
    FROM tiposcasa
    ORDER BY nomtipo;
END $$
DELIMITER ;

call verTiposCasa();

-- 2.2 Ver un tipo
DELIMITER $$
DROP PROCEDURE IF EXISTS verTipoCasa;
CREATE PROCEDURE verTipoCasa(IN id INT)
BEGIN
    SELECT *
    FROM tiposcasa
    WHERE numtipo = id;
END $$
DELIMITER ;

call verTipoCasa(1);

-- 2.3 Insertar tipo (CREATE)
DELIMITER $$
DROP PROCEDURE IF EXISTS nuevaTipoCasa;
CREATE PROCEDURE nuevaTipoCasa( IN nombre VARCHAR(20))
BEGIN
    INSERT INTO tiposcasa (nomtipo)
    VALUES (nombre);
END $$
DELIMITER ;

call nuevaTipoCasa('Rural');

-- 2.4 Actualizar tipo (UPDATE)
DELIMITER $$
DROP PROCEDURE IF EXISTS modificarTipoCasa;
CREATE PROCEDURE modificarTipoCasa(IN id INT, IN nombre VARCHAR(20))
BEGIN
    UPDATE tiposcasa
    SET nomtipo = nombre
    WHERE numtipo = id;
END $$
DELIMITER ;

call modificarTipoCasa(1, 'Nuevo tipo');

-- 2.5 Borrar tipo (DELETE)
DELIMITER $$
DROP PROCEDURE IF EXISTS eliminarTipoCasa;
CREATE PROCEDURE eliminarTipoCasa(IN id INT)
BEGIN
    DELETE FROM tiposcasa
    WHERE numtipo = id;
END $$
DELIMITER ;

CALL eliminarTipoCasa(1);

-- CASAS 

-- 3.1 Listar casas (READ)
DELIMITER $$
DROP PROCEDURE IF EXISTS verCasas;
CREATE PROCEDURE verCasas()
BEGIN
    SELECT 
        codcasa AS id,
        nomcasa AS nombre,
        nomzona AS zona,
        nomtipo AS tipo,
        preciobase AS precio
    FROM casas 
    LEFT JOIN zonas ON codzona = numzona
    LEFT JOIN tiposcasa t ON codtipocasa = numtipo
    ORDER BY codcasa;
END $$
DELIMITER ;

CALL verCasas();

-- 3.2 Ver una casa
DELIMITER $$
DROP PROCEDURE IF EXISTS verCasa;
CREATE PROCEDURE verCasa(IN id INT)
BEGIN
    SELECT *
    FROM casas
    WHERE codcasa = id;
END $$
DELIMITER ;

CALL verCasa(1);

-- 3.3 Insertar Casa (CREATE)
DELIMITER $$
DROP PROCEDURE IF EXISTS nuevaCasa;
CREATE PROCEDURE nuevaCasa(IN nombre VARCHAR(20), IN precio DECIMAL(10,2), 
IN zona INT, IN tipo INT)
BEGIN
    INSERT INTO casas (nomcasa, preciobase, codzona, codtipocasa)
    VALUES (nombre, precio, zona, tipo);
END $$
DELIMITER ;

CALL nuevaCasa('Casa prueba', 100.00, 1, 1);

-- 3.4 Actualizar casa (UPDATE)
DELIMITER $$
DROP PROCEDURE IF EXISTS modificarCasa;
CREATE PROCEDURE modificarCasa(IN id INT, IN nombre VARCHAR(20), IN precio DECIMAL(10,2))
BEGIN
    UPDATE casas
    SET 
        nomcasa = nombre,
        preciobase = precio
    WHERE codcasa = id;
END $$
DELIMITER ;

CALL modificarCasa(1, 'Casa nueva', 120.00);

-- 3.5 Borrar casa (DELETE)
DELIMITER $$
DROP PROCEDURE IF EXISTS eliminarCasa;
CREATE PROCEDURE eliminarCasa(IN id INT)
BEGIN
    DELETE FROM casas
    WHERE codcasa = id;
END $$
DELIMITER ;

CALL eliminarCasa(1);

-- PROPIETARIOS

-- 4.1 Listar Propietarios (READ)
DELIMITER $$
DROP PROCEDURE IF EXISTS verPropietarios;
CREATE PROCEDURE verPropietarios()
BEGIN
    SELECT 
        codpropietario AS id,
        nompropietario AS nombre
    FROM propietarios
    ORDER BY nompropietario;
END $$
DELIMITER ;

CALL verPropietarios();

-- 4.2 Ver un propietario
DELIMITER $$
DROP PROCEDURE IF EXISTS verPropietario;
CREATE PROCEDURE verPropietario(IN id INT)
BEGIN
    SELECT *
    FROM propietarios
    WHERE codpropietario = id;
END $$
DELIMITER ;

CALL verPropietario(1);

-- 4.3 Insertar Propietario (Create)
DELIMITER $$
DROP PROCEDURE IF EXISTS nuevoPropietario;
CREATE PROCEDURE nuevoPropietario(IN nombre VARCHAR(100), IN contacto VARCHAR(100), IN dni CHAR(12))
BEGIN
    INSERT INTO propietarios (nompropietario, personacontacto, dni_cif)
    VALUES (nombre, contacto, dni);
END $$
DELIMITER ;

CALL nuevoPropietario('Juan', 'Pedro', '12345678A');

-- 4.4 Actualizar propietario (UPDATE)
DELIMITER $$
DROP PROCEDURE IF EXISTS modificarPropietario;
CREATE PROCEDURE modificarPropietario(IN id INT, IN nombre VARCHAR(100), IN contacto VARCHAR(100))
BEGIN
    UPDATE propietarios
    SET 
        nompropietario = nombre,
        personacontacto = contacto
    WHERE codpropietario = id;
END $$
DELIMITER ;

CALL modificarPropietario(1, 'Diego', '617666628');

-- 4.5 Borrar Propietario (DELETE)
DELIMITER $$
DROP PROCEDURE IF EXISTS eliminarPropietario;
CREATE PROCEDURE eliminarPropietario(IN id INT)
BEGIN
    DELETE FROM propietarios
    WHERE codpropietario = id;
END $$
DELIMITER ;

CALL eliminarPropietario(1);
-- 



