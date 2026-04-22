-- ============================================
-- BASE DE DATOS: Gestión de Torneos Deportivos
-- Diego Hernández. 1º DAW.
 
-- Crear y usar la base de datos
CREATE DATABASE IF NOT EXISTS torneos_deportivos;
USE torneos_deportivos;
 
-- ============================================
-- CREACIÓN DE TABLAS
 
-- Tabla ÁRBITRO
CREATE TABLE ARBITRO (
    id_arbitro INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL
);
 
-- Tabla TORNEO
CREATE TABLE TORNEO (
    id_torneo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    anio INT NOT NULL,
    deporte VARCHAR(50) NOT NULL
);
 
-- Primero se hace el código de equipo, ya que jugador tiene un foreing 
-- key, entonces hay que hacerlo por integridad referencial
-- Tabla EQUIPO
CREATE TABLE EQUIPO (
    id_equipo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL
);
 
-- Tabla JUGADOR
CREATE TABLE JUGADOR (
    id_jugador INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    dorsal INT NOT NULL,
    posicion VARCHAR(50) NOT NULL,
    id_equipo INT NOT NULL,
    FOREIGN KEY (id_equipo) REFERENCES EQUIPO(id_equipo) -- Un jugador solo puede en un equipo
														 -- si sabemos el jugador sabemos el equipo
);
 
-- Tabla CAMPO
CREATE TABLE CAMPO (
    id_campo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL,
    id_equipo INT NOT NULL UNIQUE,  -- 1:1 con EQUIPO
    FOREIGN KEY (id_equipo) REFERENCES EQUIPO(id_equipo) -- Lo mismo pasa con campo, si sabemos el
														 -- campo, vamos a saber el equipo
);
 
-- Tabla PARTIDO
CREATE TABLE PARTIDO (
    id_partido INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    jornada INT NOT NULL,
    resultado VARCHAR(20),
    id_torneo INT NOT NULL,
    id_campo INT NOT NULL,
    id_arbitro INT NOT NULL,
    id_equipo1 INT NOT NULL,
    id_equipo2 INT NOT NULL,
    FOREIGN KEY (id_torneo) REFERENCES TORNEO(id_torneo),	-- Con partido sabemos torneo
    FOREIGN KEY (id_campo) REFERENCES CAMPO(id_campo),		-- Con partido tenemos que saber campo
    FOREIGN KEY (id_arbitro) REFERENCES ARBITRO(id_arbitro), -- Lo mismo 
    FOREIGN KEY (id_equipo1) REFERENCES EQUIPO(id_equipo),	
    FOREIGN KEY (id_equipo2) REFERENCES EQUIPO(id_equipo),
    CHECK (id_equipo1 <> id_equipo2)
    -- Lo dificil del código, con este se permite que un partido solo tenga dos equipos, y
    -- con el check, que sean diferentes equipos. 
);
 
-- Tabla TORNEO_EQUIPO (relación N:M entre TORNEO y EQUIPO)
CREATE TABLE TORNEO_EQUIPO (
    id_torneo INT NOT NULL,
    id_equipo INT NOT NULL,
    PRIMARY KEY (id_torneo, id_equipo),
    FOREIGN KEY (id_torneo) REFERENCES TORNEO(id_torneo),
    FOREIGN KEY (id_equipo) REFERENCES EQUIPO(id_equipo)
);
 
-- ============================================
-- INSERCIÓN DE DATOS DE EJEMPLO (5 registros)
-- ============================================
-- (GRACIAS AL AUTO-INCREMENT, NOS AHORRA LA TAREA 
-- DE PONER EL ID EN CADA TABLA CREADA DE EJEMPLO
-- Y ASÍ A SU VEZ LA PROBABILIDAD DE COMETER ALGÚN ERROR
-- DE REPETICIÓN DE ID
 
-- ÁRBITROS
INSERT INTO ARBITRO (nombre, categoria) 
VALUES
('Diego Hernández', 'Nacional'),
('Ana Martínez', 'Regional'),
('Luis García', 'Nacional'),
('María López', 'Internacional'),
('Pedro Sánchez', 'Regional');
 
-- TORNEOS
INSERT INTO TORNEO (nombre, anio, deporte) 
VALUES
('Liga Primavera', 2024, 'Fútbol'),
('Copa Verano', 2024, 'Fútbol'),
('Liga Otoño', 2023, 'Baloncesto'),
('Torneo Ciudad', 2024, 'Fútbol'),
('Liga Invierno', 2024, 'Baloncesto');
 
-- EQUIPOS
INSERT INTO EQUIPO (nombre, ciudad) 
VALUES
('Real Madrid', 'Madrid'),
('Atlético de Madrid FC', 'Madrid'),
('FC Barcelona', 'Barcelona'),
('Málaga', 'Málaga'),
('Bayern De Munich', 'Munich');
 
-- JUGADORES
INSERT INTO JUGADOR (nombre, dorsal, posicion, id_equipo) 
VALUES
('Diego Hernández', 9, 'Delantero', 1),
('Juan Torres', 1, 'Portero', 1),
('Roberto Gómez', 4, 'Defensa', 2),
('Sergio Ruiz', 10, 'Centrocampista', 3),
('Antonio Navarro', 7, 'Delantero', 4);
 
-- CAMPOS
INSERT INTO CAMPO (nombre, ciudad, capacidad, id_equipo) 
VALUES
('Bernabeu', 'Madrid', 31179, 1),
('Wanda', 'Madrid', 12400, 2),
('Camp Nou', 'Barcelona', 8000, 3),
('Rosaleda', 'Málaga', 5000, 4),
('Allianz Arena', 'Munich', 6500, 5);
 
-- PARTIDOS
INSERT INTO PARTIDO (fecha, jornada, resultado, id_torneo, id_campo, 
id_arbitro, id_equipo1, id_equipo2) 
VALUES
('2026-03-10', 1, '2-1', 1, 1, 1, 1, 2),
('2026-03-17', 2, '0-0', 1, 2, 2, 2, 3),
('2026-03-24', 3, '1-3', 1, 3, 3, 3, 4),
('2026-03-31', 4, '2-0', 1, 4, 4, 4, 5),
('2026-04-07', 5, '1-1', 1, 5, 5, 5, 1);
 
-- TORNEO_EQUIPO (inscripciones)
INSERT INTO TORNEO_EQUIPO (id_torneo, id_equipo) 
VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 1), (2, 3),
(3, 2), (3, 4),
(4, 1), (4, 2), (4, 5),
(5, 3), (5, 4);