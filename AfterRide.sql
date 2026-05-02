--- CICLO 1: TABLAS
 
CREATE TABLE Puntos (
    orden        NUMBER(2)    NOT NULL,
    nombre       VARCHAR2(10) NOT NULL PRIMARY KEY,
    tipo         VARCHAR2(20) NOT NULL,
    distancia    NUMBER(8,2)  NOT NULL,
    tiempoLimite DATE         NOT NULL
);
 
CREATE TABLE Carreras (
    codigo       VARCHAR2(20) NOT NULL PRIMARY KEY,
    nombre       VARCHAR2(30) NOT NULL,
    pais         VARCHAR2(50) NOT NULL,
    categoria    VARCHAR2(20) NOT NULL,
    periodicidad VARCHAR2(20) NOT NULL,
    nombrePunto  VARCHAR2(10)
);
 
CREATE TABLE Segmentos (
    tipo        VARCHAR2(20) NOT NULL,
    nombre      VARCHAR2(10) NOT NULL PRIMARY KEY,
    nombrePunto VARCHAR2(10)
);
 
CREATE TABLE PropiedadDe (
    porcentaje     NUMBER(3),
    idParticipante NUMBER       NOT NULL,
    codigoCarrera  VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_propiedadDe PRIMARY KEY (idParticipante, codigoCarrera)
);
 
CREATE TABLE Versiones (
    nombre        VARCHAR2(20) NOT NULL PRIMARY KEY,
    fecha         DATE         NOT NULL,
    codigoCarrera VARCHAR2(20)
);
 
CREATE TABLE Organizaciones (
    versionOrganizacion VARCHAR2(30),
    idParticipante      NUMBER       NOT NULL,
    nombreVersion       VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_organizacion PRIMARY KEY (idParticipante, nombreVersion)
);
 
CREATE TABLE Participaciones (
    idParticipante       NUMBER       NOT NULL,
    nombreVersion        VARCHAR2(20) NOT NULL,
    versionParticipacion VARCHAR2(30),
    CONSTRAINT pk_participacion PRIMARY KEY (idParticipante, nombreVersion)
);
 
CREATE TABLE AgrupacionSegmento (
    versionSegmento VARCHAR2(30),
    nombreVersion   VARCHAR2(20) NOT NULL,
    nombreSegmento  VARCHAR2(10) NOT NULL,
    CONSTRAINT pk_agrupacionSegmento PRIMARY KEY (nombreVersion, nombreSegmento)
);
 
CREATE TABLE Participantes (
    id     NUMBER        NOT NULL PRIMARY KEY,
    idt    VARCHAR2(20)  NOT NULL,
    idn    VARCHAR2(30)  NOT NULL,
    pais   VARCHAR2(50)  NOT NULL,
    correo VARCHAR2(100) NOT NULL UNIQUE
);
 
CREATE TABLE Personas (
    idParticipante NUMBER       NOT NULL PRIMARY KEY,
    nombre         VARCHAR2(50)
);
 
CREATE TABLE Ciclistas (
    idParticipante NUMBER       NOT NULL PRIMARY KEY,
    nacimiento     DATE,
    categoria      VARCHAR2(20)
);
 
CREATE TABLE Empresas (
    idParticipante NUMBER       NOT NULL PRIMARY KEY,
    razonSocial    VARCHAR2(30)
);
 
CREATE TABLE Encuestas (
    idEncuesta            NUMBER       NOT NULL PRIMARY KEY,
    criterioEvaluado      VARCHAR2(50),
    presupuestoDisponible NUMBER,
    valorUnitario         NUMBER,
    fechaInicio           DATE,
    fechaFin              DATE
);
 
CREATE TABLE ParticipacionEncuesta (
    idParticipante NUMBER       NOT NULL,
    idEncuesta     NUMBER       NOT NULL,
    fechaRespuesta DATE,
    estado         VARCHAR2(20),
    CONSTRAINT pk_participacionEncuesta PRIMARY KEY (idParticipante, idEncuesta)
);
 
CREATE TABLE Evaluaciones (
    id              NUMBER        NOT NULL PRIMARY KEY,
    fecha           DATE,
    referenciaAutor NUMBER,
    bienEspecifico  VARCHAR2(50),
    puntuacion      NUMBER(1),
    comentarios     VARCHAR2(500),
    estado          VARCHAR2(20),
    idEncuesta      NUMBER
);
 
CREATE TABLE Comentarios (
    id           NUMBER        NOT NULL PRIMARY KEY,
    contenido    VARCHAR2(500),
    idEvaluacion NUMBER
);
 
CREATE TABLE Registros (
    numero         NUMBER(10)  PRIMARY KEY,
    fecha          DATE          NOT NULL,
    tiempo         NUMBER(10)    NOT NULL,
    posicion       NUMBER(10)    NOT NULL,
    revision       NUMBER(10),
    dificultad     NUMBER(10)    NOT NULL,  
    comentarios    VARCHAR2(500), 
    nombreVersion  VARCHAR2(20)  NOT NULL,
    nombreSegmento VARCHAR2(10)  NOT NULL,
    idParticipante NUMBER(10)    NOT NULL
);
 
CREATE TABLE Foto (
    idFoto         NUMBER        NOT NULL PRIMARY KEY,
    numeroRegistro NUMBER,
    descripcion    VARCHAR2(200)
);
 
 
--- CICLO 1: ATRIBUTOS

--- CHECKS
ALTER TABLE Evaluaciones  
ADD CONSTRAINT ck_evaluacion_puntuacion CHECK (puntuacion BETWEEN 1 AND 5);
ALTER TABLE PropiedadDe 
ADD CONSTRAINT ck_propiedadDe_porcentaje CHECK (porcentaje BETWEEN 0 AND 100);
ALTER TABLE Registros    
ADD CONSTRAINT ck_registro_posicion CHECK (posicion > 0);
ALTER TABLE Registros    
ADD CONSTRAINT ck_registro_dificultad CHECK (dificultad BETWEEN 1 AND 5);
 
 
-- FOREIGN KEYS
 
ALTER TABLE Carreras               
ADD CONSTRAINT fk_carrera_punto FOREIGN KEY (nombrePunto) REFERENCES Puntos(nombre);
ALTER TABLE Segmentos              
ADD CONSTRAINT fk_segmento_punto FOREIGN KEY (nombrePunto) REFERENCES Puntos(nombre);
ALTER TABLE PropiedadDe           
ADD CONSTRAINT fk_propiedadDe_participante FOREIGN KEY (idParticipante) REFERENCES Participantes(id);
ALTER TABLE PropiedadDe           
ADD CONSTRAINT fk_propiedadDe_carrera FOREIGN KEY (codigoCarrera) REFERENCES Carreras(codigo);
ALTER TABLE Versiones               
ADD CONSTRAINT fk_version_carrera FOREIGN KEY (codigoCarrera) REFERENCES Carreras(codigo);
ALTER TABLE Organizaciones          
ADD CONSTRAINT fk_organizacion_participante FOREIGN KEY (idParticipante) REFERENCES Participantes(id);
ALTER TABLE Organizaciones          
ADD CONSTRAINT fk_organizacion_version FOREIGN KEY (nombreVersion) REFERENCES Versiones(nombre);
ALTER TABLE Participaciones         
ADD CONSTRAINT fk_participacion_participante FOREIGN KEY (idParticipante) REFERENCES Participantes(id);
ALTER TABLE Participaciones         
ADD CONSTRAINT fk_participacion_version FOREIGN KEY (nombreVersion) REFERENCES Versiones(nombre);
ALTER TABLE AgrupacionSegmento    
ADD CONSTRAINT fk_agrupacionSegmento_version FOREIGN KEY (nombreVersion) REFERENCES Versiones(nombre);
ALTER TABLE AgrupacionSegmento    
ADD CONSTRAINT fk_agrupacionSegmento_segmento FOREIGN KEY (nombreSegmento) REFERENCES Segmentos(nombre);
ALTER TABLE Personas               
ADD CONSTRAINT fk_persona_participante FOREIGN KEY (idParticipante) REFERENCES Participantes(id);
ALTER TABLE Ciclistas              
ADD CONSTRAINT fk_ciclista_participante FOREIGN KEY (idParticipante) REFERENCES Participantes(id);
ALTER TABLE Empresas               
ADD CONSTRAINT fk_empresa_participante FOREIGN KEY (idParticipante) REFERENCES Participantes(id);
ALTER TABLE ParticipacionEncuesta 
ADD CONSTRAINT fk_participacionEncuesta_participante FOREIGN KEY (idParticipante) REFERENCES Participantes(id);
ALTER TABLE ParticipacionEncuesta 
ADD CONSTRAINT fk_participacionEncuesta_encuesta FOREIGN KEY (idEncuesta) REFERENCES Encuestas(idEncuesta);
ALTER TABLE Evaluaciones            
ADD CONSTRAINT fk_evaluacion_participante FOREIGN KEY (referenciaAutor) REFERENCES Participantes(id);
ALTER TABLE Evaluaciones            
ADD CONSTRAINT fk_evaluacion_encuesta FOREIGN KEY (idEncuesta) REFERENCES Encuestas(idEncuesta);
ALTER TABLE Comentarios            
ADD CONSTRAINT fk_comentario_evaluacion FOREIGN KEY (idEvaluacion) REFERENCES Evaluaciones(id);
ALTER TABLE Registros              
ADD CONSTRAINT fk_registro_version FOREIGN KEY (nombreVersion) REFERENCES Versiones(nombre);
ALTER TABLE Registros              
ADD CONSTRAINT fk_registro_segmento FOREIGN KEY (nombreSegmento) REFERENCES Segmentos(nombre);
ALTER TABLE Registros              
ADD CONSTRAINT fk_registro_ciclista FOREIGN KEY (idParticipante) REFERENCES Ciclistas(idParticipante);
ALTER TABLE Foto                  
ADD CONSTRAINT fk_foto_registro FOREIGN KEY (numeroRegistro) REFERENCES Registros(numero);
 
 
--- CICLO 1: PoblarOK
 
INSERT INTO Puntos VALUES (1, 'Salida',  'Partida', 0,   TO_DATE('2025-03-04', 'YYYY-MM-DD'));
INSERT INTO Puntos VALUES (2, 'Control', 'Control', 50,  TO_DATE('2025-03-04', 'YYYY-MM-DD'));
INSERT INTO Puntos VALUES (3, 'Meta',    'Llegada', 100, TO_DATE('2025-03-05', 'YYYY-MM-DD'));
 
INSERT INTO Carreras VALUES ('C01', 'Tour Andes',    'Colombia', 'Montaña', 'Anual', 'Salida');
INSERT INTO Carreras VALUES ('C02', 'Ruta Caribe',   'Colombia', 'Ruta',    'Anual', 'Control');
INSERT INTO Carreras VALUES ('C03', 'Vuelta Bogota', 'Colombia', 'Urbana',  'Anual', 'Meta');
 
INSERT INTO Segmentos VALUES ('Plano',   'S1', 'Salida');
INSERT INTO Segmentos VALUES ('Montaña', 'S2', 'Control');
INSERT INTO Segmentos VALUES ('Sprint',  'S3', 'Meta');

INSERT INTO Versiones VALUES ('V1', TO_DATE('2025-03-04', 'YYYY-MM-DD'), 'C01');
 
INSERT INTO Participantes VALUES (1, 'CC', '111', 'Colombia', 'a@mail.com');
INSERT INTO Participantes VALUES (2, 'CC', '222', 'Colombia', 'b@mail.com');
INSERT INTO Participantes VALUES (3, 'CC', '333', 'Colombia', 'c@mail.com');
 
INSERT INTO Personas  VALUES (1, 'Juan');
INSERT INTO Personas  VALUES (2, 'Maria');
INSERT INTO Personas  VALUES (3, 'Carlos');
 
INSERT INTO Ciclistas VALUES (1, TO_DATE('2000-01-01', 'YYYY-MM-DD'), 'Elite');
INSERT INTO Ciclistas VALUES (2, TO_DATE('1999-02-02', 'YYYY-MM-DD'), 'Elite');
INSERT INTO Ciclistas VALUES (3, TO_DATE('2002-03-03', 'YYYY-MM-DD'), 'Sub23');
 
INSERT INTO Encuestas VALUES (1, 'Organizaciones', 1000000, 2000, TO_DATE('2025-03-01', 'YYYY-MM-DD'), TO_DATE('2025-04-01', 'YYYY-MM-DD'));
INSERT INTO Encuestas VALUES (2, 'Seguridad',    2000000, 3000, TO_DATE('2025-04-01', 'YYYY-MM-DD'), TO_DATE('2025-05-01', 'YYYY-MM-DD'));
INSERT INTO Encuestas VALUES (3, 'Logistica',    1500000, 2500, TO_DATE('2025-05-01', 'YYYY-MM-DD'), TO_DATE('2025-06-01', 'YYYY-MM-DD'));
 
INSERT INTO Evaluaciones VALUES (1, TO_DATE('2025-04-10', 'YYYY-MM-DD'), 1, 'Casco',     5, 'Muy bueno',   'Activo', 1);
INSERT INTO Evaluaciones VALUES (2, TO_DATE('2025-04-11', 'YYYY-MM-DD'), 2, 'Bicicleta', 4, 'Buen estado', 'Activo', 1);
INSERT INTO Evaluaciones VALUES (3, TO_DATE('2025-04-12', 'YYYY-MM-DD'), 3, 'Guantes',   3, 'Aceptable',   'Activo', 2);
 
INSERT INTO Registros VALUES (1, TO_DATE('2025-04-05', 'YYYY-MM-DD'), 30, 1, 1, 2, 'Buen tiempo',   'V1', 'S1', 1);
INSERT INTO Registros VALUES (2, TO_DATE('2025-04-05', 'YYYY-MM-DD'), 32, 2, 1, 3, 'Buen esfuerzo', 'V1', 'S2', 2);
INSERT INTO Registros VALUES (3, TO_DATE('2025-04-05', 'YYYY-MM-DD'), 35, 3, 1, 4, 'Regular',       'V1', 'S3', 3);
 
INSERT INTO Foto VALUES (1, 1, 'Ganador');
INSERT INTO Foto VALUES (2, 2, 'Montaña');
INSERT INTO Foto VALUES (3, 3, 'Meta');
 
 
-- --- CICLO 1: PoblarNoOK
 
-- Carreras

-- PK duplicada
INSERT INTO Puntos (orden, nombre, tipo, distancia, tiempoLimite) VALUES (99, 'Salida', 'Control', 10, TO_DATE('2025-01-01', 'YYYY-MM-DD'));
-- FK inválida (nombrePunto no existe en Puntos)
INSERT INTO Carreras (codigo, nombre, pais, categoria, periodicidad, nombrePunto) VALUES ('C99', 'Carreras Falsa', 'Colombia', 'Ruta', 'Anual', 'NoExiste');
 
-- Segmentos
-- FK inválida (codigoCarrera no existe en Carreras)
INSERT INTO Versiones (nombre, fecha, codigoCarrera) VALUES ('V99', TO_DATE('2026-01-01', 'YYYY-MM-DD'), 'CXX');
-- FK inválida (nombreVersion no existe en Segmentos)
INSERT INTO Participaciones (idParticipante, nombreVersion, versionParticipacion) VALUES (1, 'VXX', 'PP999');
 
-- Participantes
-- PK duplicada
INSERT INTO Participantes (id, idt, idn, pais, correo) VALUES (1, 'CC', '9999', 'Colombia', 'nuevo@mail.com');
-- UNIQUE violado (correo ya registrado)
INSERT INTO Participantes (id, idt, idn, pais, correo) VALUES (99, 'CC', '9999', 'Colombia', 'a@mail.com');
 
-- Encuestas
-- PK duplicada
INSERT INTO Encuestas (idEncuesta, criterioEvaluado, presupuestoDisponible, valorUnitario, fechaInicio, fechaFin) VALUES (1, 'Duplicada', NULL, NULL, SYSDATE, SYSDATE + 30);
-- NOT NULL en idEncuesta
INSERT INTO Encuestas (idEncuesta, criterioEvaluado, presupuestoDisponible, valorUnitario, fechaInicio, fechaFin) VALUES (NULL, 'Sin id', NULL, NULL, SYSDATE, SYSDATE + 30);
 
-- Evaluaciones
-- CHECK violado (puntuacion = 0, fuera del rango 1-5)
INSERT INTO Evaluaciones (id, fecha, referenciaAutor, bienEspecifico, puntuacion, comentarios, estado, idEncuesta) VALUES (991, SYSDATE, 1, 'Casco', 0, 'Puntuacion invalida', 'Activo', 1);
-- Comentarios: FK inválida (idEvaluacion no existe en Evaluaciones)
INSERT INTO Comentarios (id, contenido, idEvaluacion) VALUES (999, 'Evaluaciones inexistente', 999);
 
-- Registros
-- CHECK violado (posicion = -1, debe ser > 0)
INSERT INTO Registros (numero, fecha, tiempo, posicion, revision, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante) VALUES (991, SYSDATE, 20, -1, 1, 2, 'Posicion negativa', 'V1', 'S1', 1);
-- FK inválida (numeroRegistro no existe en Registros)
INSERT INTO Foto (idFoto, numeroRegistro, descripcion) VALUES (999, 999, 'Registros inexistente');
 
 
-- CICLO 1: XPoblar
 
DELETE FROM Foto;
DELETE FROM Registros;
DELETE FROM Comentarios;
DELETE FROM Evaluaciones;
DELETE FROM ParticipacionEncuesta;
DELETE FROM Encuestas;
DELETE FROM AgrupacionSegmento;
DELETE FROM Ciclistas;
DELETE FROM Empresas;
DELETE FROM Personas;
DELETE FROM Organizaciones;
DELETE FROM Participaciones;
DELETE FROM PropiedadDe;
DELETE FROM Participantes;
DELETE FROM Versiones;
DELETE FROM Segmentos;
DELETE FROM Carreras;
DELETE FROM Puntos;

--  CICLO 1: TUPLAS
 
INSERT INTO Participantes (id, idt, idn, correo, pais) VALUES (1,  'CC', '5016', 'nsherbrook0@hibu.com', 'Philippines');
INSERT INTO Participantes (id, idt, idn, correo, pais) VALUES (2,  'TI', '8247', 'lwince1@yahoo.com', 'Cameroon');
INSERT INTO Participantes (id, idt, idn, correo, pais) VALUES (3,  'CE', '6783', 'uedsall2@sourceforge.net', 'Sri Lanka');
INSERT INTO Participantes (id, idt, idn, correo, pais) VALUES (4,  'TI', '9053', 'ewegman3@scientificamerican.com', 'Kenya');
INSERT INTO Participantes (id, idt, idn, correo, pais) VALUES (5,  'TI', '6701', 'hgronou4@jimdo.com', 'Tunisia');
INSERT INTO Participantes (id, idt, idn, correo, pais) VALUES (6,  'CE', '2879', 'emacbane5@oaic.gov.au', 'Egypt');
INSERT INTO Participantes (id, idt, idn, correo, pais) VALUES (7,  'CC', '3197', 'dzorzenoni6@bloomberg.com', 'Tanzania');
INSERT INTO Participantes (id, idt, idn, correo, pais) VALUES (8,  'TI', '7900', 'lkarpe7@sogou.com', 'Albania');
INSERT INTO Participantes (id, idt, idn, correo, pais) VALUES (9,  'TI', '7257', 'jjoseland8@t.co', 'Mexico');
INSERT INTO Participantes (id, idt, idn, correo, pais) VALUES (10, 'CC', '5782', 'pflory9@aol.com', 'Malawi');
 
INSERT INTO Personas VALUES (1, 'Nicole Sherbrook');
INSERT INTO Personas VALUES (2, 'Laura Wince');
INSERT INTO Personas VALUES (3, 'Uma Edsall');
INSERT INTO Personas VALUES (4, 'Ethan Wegman');
INSERT INTO Personas VALUES (5, 'Harold Gronou');
INSERT INTO Personas VALUES (6, 'Eva Macbane');
INSERT INTO Personas VALUES (7, 'Daniel Zorzenoni');
INSERT INTO Personas VALUES (8, 'Lena Karpe');
INSERT INTO Personas VALUES (9, 'James Joseland');
INSERT INTO Personas VALUES (10, 'Paul Flory');
 
INSERT INTO Ciclistas VALUES (1, TO_DATE('2000-01-15', 'YYYY-MM-DD'), 'Elite');
INSERT INTO Ciclistas VALUES (2, TO_DATE('1999-02-20', 'YYYY-MM-DD'), 'Elite');
INSERT INTO Ciclistas VALUES (3, TO_DATE('2002-03-10', 'YYYY-MM-DD'), 'Sub23');
INSERT INTO Ciclistas VALUES (4, TO_DATE('1998-07-05', 'YYYY-MM-DD'), 'Elite');
INSERT INTO Ciclistas VALUES (5, TO_DATE('2001-11-30', 'YYYY-MM-DD'), 'Sub23');
INSERT INTO Ciclistas VALUES (6, TO_DATE('1997-04-22', 'YYYY-MM-DD'), 'Elite');
INSERT INTO Ciclistas VALUES (7, TO_DATE('2003-08-14', 'YYYY-MM-DD'), 'Sub23');
INSERT INTO Ciclistas VALUES (8, TO_DATE('1996-12-01', 'YYYY-MM-DD'), 'Elite');
INSERT INTO Ciclistas VALUES (9, TO_DATE('2000-06-18', 'YYYY-MM-DD'), 'Elite');
INSERT INTO Ciclistas VALUES (10, TO_DATE('1995-09-25', 'YYYY-MM-DD'), 'Elite');
 
INSERT INTO Puntos (orden, nombre, tipo, distancia, tiempoLimite) VALUES (1, 'Salida', 'Control', 17,  TO_DATE('2025-08-07', 'YYYY-MM-DD'));
INSERT INTO Puntos (orden, nombre, tipo, distancia, tiempoLimite) VALUES (2, 'Salida2', 'Control', 38,  TO_DATE('2025-12-11', 'YYYY-MM-DD'));
INSERT INTO Puntos (orden, nombre, tipo, distancia, tiempoLimite) VALUES (3, 'Salida3', 'Meta',    39,  TO_DATE('2026-02-14', 'YYYY-MM-DD'));
INSERT INTO Puntos (orden, nombre, tipo, distancia, tiempoLimite) VALUES (4, 'Control2', 'Salida',  61,  TO_DATE('2025-10-29', 'YYYY-MM-DD'));
INSERT INTO Puntos (orden, nombre, tipo, distancia, tiempoLimite) VALUES (5, 'Control1', 'Salida',  167, TO_DATE('2026-02-27', 'YYYY-MM-DD'));
INSERT INTO Puntos (orden, nombre, tipo, distancia, tiempoLimite) VALUES (6, 'Control1b', 'Control', 136, TO_DATE('2025-08-10', 'YYYY-MM-DD'));
INSERT INTO Puntos (orden, nombre, tipo, distancia, tiempoLimite) VALUES (7, 'Meta', 'Salida',  140, TO_DATE('2025-04-04', 'YYYY-MM-DD'));
INSERT INTO Puntos (orden, nombre, tipo, distancia, tiempoLimite) VALUES (8, 'Control2b', 'Control', 101, TO_DATE('2025-06-04', 'YYYY-MM-DD'));
INSERT INTO Puntos (orden, nombre, tipo, distancia, tiempoLimite) VALUES (9, 'Meta2', 'Salida',  181, TO_DATE('2026-02-20', 'YYYY-MM-DD'));
INSERT INTO Puntos (orden, nombre, tipo, distancia, tiempoLimite) VALUES (10, 'Meta3', 'Meta', 83,  TO_DATE('2025-12-24', 'YYYY-MM-DD'));
 
INSERT INTO Carreras VALUES ('C01', 'Tour Andes', 'Colombia', 'Montaña', 'Anual', 'Salida');
INSERT INTO Carreras VALUES ('C02', 'Ruta Caribe', 'Colombia', 'Ruta', 'Anual', 'Control1');
INSERT INTO Carreras VALUES ('C03', 'Vuelta Bogota', 'Colombia', 'Urbana',  'Anual', 'Meta');
 
INSERT INTO Segmentos VALUES ('Plano',   'S1', 'Salida');
INSERT INTO Segmentos VALUES ('Montaña', 'S2', 'Control1');
INSERT INTO Segmentos VALUES ('Sprint',  'S3', 'Meta');
 
INSERT INTO Versiones (nombre, fecha, codigoCarrera) VALUES ('V1',  TO_DATE('2026-01-08', 'YYYY-MM-DD'), 'C01');
INSERT INTO Versiones (nombre, fecha, codigoCarrera) VALUES ('V2',  TO_DATE('2025-09-29', 'YYYY-MM-DD'), 'C01');
INSERT INTO Versiones (nombre, fecha, codigoCarrera) VALUES ('V3',  TO_DATE('2026-02-21', 'YYYY-MM-DD'), 'C02');
INSERT INTO Versiones (nombre, fecha, codigoCarrera) VALUES ('V4',  TO_DATE('2025-05-11', 'YYYY-MM-DD'), 'C02');
INSERT INTO Versiones (nombre, fecha, codigoCarrera) VALUES ('V5',  TO_DATE('2026-01-29', 'YYYY-MM-DD'), 'C03');
INSERT INTO Versiones (nombre, fecha, codigoCarrera) VALUES ('V6',  TO_DATE('2026-02-10', 'YYYY-MM-DD'), 'C03');
INSERT INTO Versiones (nombre, fecha, codigoCarrera) VALUES ('V7',  TO_DATE('2026-03-09', 'YYYY-MM-DD'), 'C01');
INSERT INTO Versiones (nombre, fecha, codigoCarrera) VALUES ('V8',  TO_DATE('2025-10-04', 'YYYY-MM-DD'), 'C02');
INSERT INTO Versiones (nombre, fecha, codigoCarrera) VALUES ('V9',  TO_DATE('2026-03-02', 'YYYY-MM-DD'), 'C03');
INSERT INTO Versiones (nombre, fecha, codigoCarrera) VALUES ('V10', TO_DATE('2025-04-24', 'YYYY-MM-DD'), 'C01');
 
INSERT INTO Participaciones (idParticipante, nombreVersion, versionParticipacion) VALUES (1,  'V1',  'PP001');
INSERT INTO Participaciones (idParticipante, nombreVersion, versionParticipacion) VALUES (2,  'V2',  'PP002');
INSERT INTO Participaciones (idParticipante, nombreVersion, versionParticipacion) VALUES (3,  'V3',  'PP003');
INSERT INTO Participaciones (idParticipante, nombreVersion, versionParticipacion) VALUES (4,  'V4',  'PP004');
INSERT INTO Participaciones (idParticipante, nombreVersion, versionParticipacion) VALUES (5,  'V5',  'PP005');
INSERT INTO Participaciones (idParticipante, nombreVersion, versionParticipacion) VALUES (6,  'V6',  'PP006');
INSERT INTO Participaciones (idParticipante, nombreVersion, versionParticipacion) VALUES (7,  'V7',  'PP007');
INSERT INTO Participaciones (idParticipante, nombreVersion, versionParticipacion) VALUES (8,  'V8',  'PP008');
INSERT INTO Participaciones (idParticipante, nombreVersion, versionParticipacion) VALUES (9,  'V9',  'PP009');
INSERT INTO Participaciones (idParticipante, nombreVersion, versionParticipacion) VALUES (10, 'V10', 'PP010');
 
INSERT INTO Encuestas (idEncuesta, criterioEvaluado, presupuestoDisponible, valorUnitario, fechaInicio, fechaFin)
    VALUES (1, 'congue etiam justo', NULL, NULL, TO_DATE('2025-03-24', 'YYYY-MM-DD'), TO_DATE('2025-04-24', 'YYYY-MM-DD'));
INSERT INTO Encuestas (idEncuesta, criterioEvaluado, presupuestoDisponible, valorUnitario, fechaInicio, fechaFin)
    VALUES (2, 'semper porta volutpat', NULL, NULL, TO_DATE('2025-10-27', 'YYYY-MM-DD'), TO_DATE('2025-11-27', 'YYYY-MM-DD'));
INSERT INTO Encuestas (idEncuesta, criterioEvaluado, presupuestoDisponible, valorUnitario, fechaInicio, fechaFin)
    VALUES (3, 'pede ac diam cras', NULL, NULL, TO_DATE('2026-01-05', 'YYYY-MM-DD'), TO_DATE('2026-02-05', 'YYYY-MM-DD'));
INSERT INTO Encuestas (idEncuesta, criterioEvaluado, presupuestoDisponible, valorUnitario, fechaInicio, fechaFin)
    VALUES (4, 'condimentum neque sapien', NULL, NULL, TO_DATE('2025-07-16', 'YYYY-MM-DD'), TO_DATE('2025-08-16', 'YYYY-MM-DD'));
INSERT INTO Encuestas (idEncuesta, criterioEvaluado, presupuestoDisponible, valorUnitario, fechaInicio, fechaFin)
    VALUES (5, 'porttitor id consequat', NULL, NULL, TO_DATE('2025-12-31', 'YYYY-MM-DD'), TO_DATE('2026-01-31', 'YYYY-MM-DD'));
INSERT INTO Encuestas (idEncuesta, criterioEvaluado, presupuestoDisponible, valorUnitario, fechaInicio, fechaFin)
    VALUES (6, 'nonummy integer non velit', NULL, NULL, TO_DATE('2025-10-19', 'YYYY-MM-DD'), TO_DATE('2025-11-19', 'YYYY-MM-DD'));
INSERT INTO Encuestas (idEncuesta, criterioEvaluado, presupuestoDisponible, valorUnitario, fechaInicio, fechaFin)
    VALUES (7, 'cubilia curae duis', NULL, NULL, TO_DATE('2025-06-05', 'YYYY-MM-DD'), TO_DATE('2025-07-05', 'YYYY-MM-DD'));
INSERT INTO Encuestas (idEncuesta, criterioEvaluado, presupuestoDisponible, valorUnitario, fechaInicio, fechaFin)
    VALUES (8, 'magnis dis parturient', NULL, NULL, TO_DATE('2025-06-22', 'YYYY-MM-DD'), TO_DATE('2025-07-22', 'YYYY-MM-DD'));
INSERT INTO Encuestas (idEncuesta, criterioEvaluado, presupuestoDisponible, valorUnitario, fechaInicio, fechaFin)
    VALUES (9, 'sapien arcu sed augue', NULL, NULL, TO_DATE('2025-07-11', 'YYYY-MM-DD'), TO_DATE('2025-08-11', 'YYYY-MM-DD'));
INSERT INTO Encuestas (idEncuesta, criterioEvaluado, presupuestoDisponible, valorUnitario, fechaInicio, fechaFin)
    VALUES (10, 'nulla ultrices aliquet', NULL, NULL, TO_DATE('2025-03-23', 'YYYY-MM-DD'), TO_DATE('2025-04-23', 'YYYY-MM-DD'));
 
INSERT INTO Registros (numero, fecha, tiempo, posicion, revision, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante)
VALUES (4,  TO_DATE('2025-12-13', 'YYYY-MM-DD'), 160.0, 8, NULL, 5, NULL, 'V4',  'S1', 4);
INSERT INTO Registros (numero, fecha, tiempo, posicion, revision, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante)
VALUES (5,  TO_DATE('2025-07-21', 'YYYY-MM-DD'), 132.4, 4, NULL, 3, NULL, 'V5',  'S2', 5);
INSERT INTO Registros (numero, fecha, tiempo, posicion, revision, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante)
VALUES (6,  TO_DATE('2025-06-01', 'YYYY-MM-DD'), 110.7, 1, 1, 2, NULL, 'V6',  'S3', 6);
INSERT INTO Registros (numero, fecha, tiempo, posicion, revision, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante)
VALUES (7,  TO_DATE('2025-12-04', 'YYYY-MM-DD'), 170.3, 10, NULL, 5, 'Revisar', 'V7',  'S1', 7);
INSERT INTO Registros (numero, fecha, tiempo, posicion, revision, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante)
VALUES (8,  TO_DATE('2026-01-05', 'YYYY-MM-DD'), 145.8, 6, NULL, 4, NULL, 'V8',  'S2', 8);
INSERT INTO Registros (numero, fecha, tiempo, posicion, revision, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante)
VALUES (9,  TO_DATE('2026-01-03', 'YYYY-MM-DD'), 138.0, 5, 1, 3, 'Valido', 'V9',  'S3', 9);
INSERT INTO Registros (numero, fecha, tiempo, posicion, revision, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante)
VALUES (10, TO_DATE('2025-10-24', 'YYYY-MM-DD'), 155.5, 7, NULL, 4, NULL, 'V10', 'S1', 10);
 
--- CICLO 1: TuplasNoOK
 
-- Error: posición negativa (viola CHECK ck_registro_posicion)
INSERT INTO Registros (numero, fecha, tiempo, posicion, revision, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante)
    VALUES (220, SYSDATE, 30, -1, 1, 3, 'Error: posicion negativa', 'V1', 'S1', 1);
 
-- Error: Ciclistas inexistente (viola FK fk_registro_ciclista)
INSERT INTO Registros (numero, fecha, tiempo, posicion, revision, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante)
    VALUES (221, SYSDATE, 30, 2, 1, 3, 'Error: Ciclistas no existe', 'V1', 'S1', 99);
 
-- Error: dificultad fuera de rango (viola CHECK ck_registro_dificultad)
INSERT INTO Registros (numero, fecha, tiempo, posicion, revision, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante)
    VALUES (222, SYSDATE, 30, 2, 1, 6, 'Error: dificultad invalida', 'V1', 'S1', 1);

--- CICLO 1: Acciones
 
INSERT INTO Registros (numero, fecha, tiempo, posicion, revision, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante)
    VALUES (300, SYSDATE, 25, 1, 1, 2, 'Registros para pruebas de accion', 'V1', 'S1', 1);
 
 
--- CICLO 1: AccionesOK
 
UPDATE Registros 
SET revision = 2
WHERE numero = 300;
UPDATE Registros 
SET comentarios = 'Comentarios corregido por revisor'
WHERE numero = 300;

------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------- DISPARADORES -------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------ 
 
-- CICLO 1: Disparadores: Registrar Registros
 
-- Trigger 1: Asigna numero automático si es NULL y fuerza fecha = SYSDATE
CREATE OR REPLACE TRIGGER trg_registro_autonumero
BEFORE INSERT ON Registros
FOR EACH ROW
BEGIN
    IF :NEW.numero IS NULL THEN
        SELECT NVL(MAX(numero), 0) + 1
        INTO :NEW.numero
        FROM Registros;
    END IF;
    :NEW.fecha := SYSDATE;
END;
/
 
-- Trigger 2: Valida que el Ciclistas esté inscrito en la versión del Registros
CREATE OR REPLACE TRIGGER trg_registro_validar_participacion
BEFORE INSERT ON Registros
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Participaciones
    WHERE idParticipante = :NEW.idParticipante
      AND nombreVersion  = :NEW.nombreVersion;
 
    IF v_count = 0 THEN
        :NEW.idParticipante := NULL;
    END IF;
END;
/
 
-- Trigger 3
--   Solo se permiten cambios en revision, comentarios y fotos vía tabla Foto
CREATE OR REPLACE TRIGGER trg_registro_control_update
BEFORE UPDATE ON Registros
FOR EACH ROW
BEGIN
    IF :OLD.tiempo <> :NEW.tiempo 
    THEN :NEW.tiempo := :OLD.tiempo;         
    END IF;
    IF :OLD.posicion <> :NEW.posicion       
    THEN :NEW.posicion := :OLD.posicion;       
    END IF;
    IF :OLD.nombreVersion  <> :NEW.nombreVersion  
    THEN :NEW.nombreVersion  := :OLD.nombreVersion;  
    END IF;
    IF :OLD.nombreSegmento <> :NEW.nombreSegmento 
    THEN :NEW.nombreSegmento := :OLD.nombreSegmento; 
    END IF;
    IF :OLD.idParticipante <> :NEW.idParticipante 
    THEN :NEW.idParticipante := :OLD.idParticipante; 
    END IF;
END;
/
 
-- Trigger 4 : Impide eliminar registros con más de 1 día de antigüedad
CREATE OR REPLACE TRIGGER trg_registro_control_delete
BEFORE DELETE ON Registros
FOR EACH ROW
BEGIN
    IF (SYSDATE - :OLD.fecha) > 1 THEN
        RAISE_APPLICATION_ERROR(-20001,'No se puede eliminar el Registros ' || :OLD.numero || ': tiene mas de 1 dia de antiguedad.');
    END IF;
END;
/ 
-- CICLO 1: DisparadoresOK
 
-- INSERT con numero explícito: trigger sobreescribe fecha con SYSDATE
INSERT INTO Registros (numero, fecha, tiempo, posicion, revision, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante)
    VALUES (400, SYSDATE, 20, 1, 1, 2, 'Con numero explicito', 'V1', 'S1', 1);
 
-- INSERT sin numero, trigger asigna el siguiente disponible
INSERT INTO Registros (fecha, tiempo, posicion, revision, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante)
    VALUES (SYSDATE, 22, 1, 1, 3, 'Sin numero - asignado por trigger', 'V1', 'S1', 1);
 
-- UPDATE de revision 
UPDATE Registros SET revision    = 3                                      
WHERE numero = 400;
 
-- UPDATE de comentarios 
UPDATE Registros SET comentarios = 'Actualizacion de Comentarios permitida' 
WHERE numero = 400;
 
-- CICLO 1: DisparadoresNoOK
 
-- UPDATE de posicion (campo protegido): trigger revierte al valor original
UPDATE Registros 
SET posicion = 5    
WHERE numero = 400;
 
-- UPDATE de tiempo (campo protegido): trigger revierte al valor original
UPDATE Registros SET tiempo        = 100  WHERE numero = 400;
 
-- UPDATE de nombreVersion (campo protegido): trigger revierte al valor original
UPDATE Registros SET nombreVersion = 'V2' WHERE numero = 400;
 
-- DELETE de Registros antiguo (> 1 día): trigger lanza RAISE_APPLICATION_ERROR
DELETE FROM Registros WHERE numero = 1;
 
-- CICLO 1: XDisparadores
 
DROP TRIGGER trg_registro_autonumero;
DROP TRIGGER trg_registro_validar_participacion;
DROP TRIGGER trg_registro_control_update;
DROP TRIGGER trg_registro_control_delete;

------------------------------------
-- Disparadores Registrar Evaluación
-----------------------------------

-- Trigger 1 (Create): Asigna idEncuesta automático si es NULL
CREATE OR REPLACE TRIGGER trg_encuesta_autonumero
BEFORE INSERT ON Encuestas
FOR EACH ROW
BEGIN
    IF :NEW.idEncuesta IS NULL THEN
        SELECT NVL(MAX(idEncuesta), 0) + 1
        INTO :NEW.idEncuesta
        FROM Encuestas;
    END IF;
END;
/
 
-- Trigger 2: Asigna estado = 'Activo' y fecha = SYSDATE por defecto si son NULL
CREATE OR REPLACE TRIGGER trg_evaluacion_estado_default
BEFORE INSERT ON Evaluaciones
FOR EACH ROW
BEGIN
    IF :NEW.estado IS NULL THEN
        :NEW.estado := 'Activo';
    END IF;
    IF :NEW.fecha IS NULL THEN
        :NEW.fecha := SYSDATE;
    END IF;
END;
/
 
-- Trigger 3:
--   Solo se permiten cambios en puntuacion, comentarios y estado
CREATE OR REPLACE TRIGGER trg_evaluacion_control_update
BEFORE UPDATE ON Evaluaciones
FOR EACH ROW
BEGIN
    IF :OLD.idEncuesta <> :NEW.idEncuesta      
    THEN :NEW.idEncuesta := :OLD.idEncuesta;      
    END IF;
    IF :OLD.referenciaAutor <> :NEW.referenciaAutor 
    THEN :NEW.referenciaAutor := :OLD.referenciaAutor; 
    END IF;
    IF :OLD.bienEspecifico <> :NEW.bienEspecifico  
    THEN :NEW.bienEspecifico  := :OLD.bienEspecifico;  
    END IF;
END;
/
 
-- Trigger 4: Impide eliminar evaluaciones en estado 'Activo'
CREATE OR REPLACE TRIGGER trg_evaluacion_control_delete
BEFORE DELETE ON Evaluaciones
FOR EACH ROW
BEGIN
    IF :OLD.estado = 'Activo' THEN
        RAISE_APPLICATION_ERROR(-20002,'No se puede eliminar la Evaluaciones ' || :OLD.id || ': esta en estado Activo. Inactivela primero.');
    END IF;
END;
/
 
-- Trigger 5: Solo permite evaluaciones sobre encuestas con ventana activa
CREATE OR REPLACE TRIGGER trg_evaluacion_encuesta_activa
BEFORE INSERT ON Evaluaciones
FOR EACH ROW
DECLARE
    v_inicio DATE;
    v_fin    DATE;
BEGIN
    SELECT fechaInicio, fechaFin
    INTO v_inicio, v_fin
    FROM Encuestas
    WHERE idEncuesta = :NEW.idEncuesta;
 
    IF SYSDATE < v_inicio OR SYSDATE > v_fin THEN
        RAISE_APPLICATION_ERROR(-20012, 'No se puede registrar la Evaluaciones: la Encuestas '|| :NEW.idEncuesta || ' no esta en su periodo activo.');
    END IF;
END;
/
-- TuplasOK
 
INSERT INTO Evaluaciones (id, fecha, referenciaAutor, bienEspecifico, puntuacion, comentarios, estado, idEncuesta) VALUES (500, SYSDATE, 1, 'Bicicleta', 4, 'Buen estado del equipo', 'Activo', 1);
INSERT INTO Evaluaciones (id, fecha, referenciaAutor, bienEspecifico, puntuacion, comentarios, estado, idEncuesta) VALUES (NULL, NULL, 2, 'Casco', 5, 'Excelente proteccion', NULL, 2);
 
-- TuplasNoOK
 
-- Error: (viola CHECK ck_evaluacion_puntuacion)
INSERT INTO Evaluaciones (id, fecha, referenciaAutor, bienEspecifico, puntuacion, comentarios, estado, idEncuesta) VALUES (600, SYSDATE, 1, 'Guantes', 0, 'Error: puntuacion cero no permitida', 'Activo', 1);
 
-- Error: Encuestas inexistente
INSERT INTO Evaluaciones (id, fecha, referenciaAutor, bienEspecifico, puntuacion, comentarios, estado, idEncuesta) VALUES (601, SYSDATE, 1, 'Zapatos', 3, 'Error: Encuestas inexistente', 'Activo', 9999);
 
-- Error: autor inexistente 
INSERT INTO Evaluaciones (id, fecha, referenciaAutor, bienEspecifico, puntuacion, comentarios, estado, idEncuesta) VALUES (602, SYSDATE, 9999, 'Rodilleras', 3, 'Error: autor inexistente', 'Activo', 1);
 
-- AccionesOK
 
UPDATE Evaluaciones 
SET puntuacion  = 3                                
WHERE id = 500;

UPDATE Evaluaciones 
SET comentarios = 'Revision posterior del evaluador' 
WHERE id = 500;

UPDATE Evaluaciones 
SET estado  = 'Inactivo'                       
WHERE id = 500;

DELETE FROM Evaluaciones 
WHERE id = 500;
 
-- DisparadoresOK
 
INSERT INTO Evaluaciones (id, fecha, referenciaAutor, bienEspecifico, puntuacion, comentarios, estado, idEncuesta) VALUES (NULL, NULL, 3, 'Guantes', 4, 'Buen agarre', NULL, 3);
 
UPDATE Evaluaciones 
SET puntuacion  = 2   
WHERE referenciaAutor = 3 AND bienEspecifico = 'Guantes';

UPDATE Evaluaciones 
SET comentarios = 'Actualizacion de Comentarios permitida' 
WHERE referenciaAutor = 3 AND bienEspecifico = 'Guantes';
 
INSERT INTO Encuestas (idEncuesta, criterioEvaluado, presupuestoDisponible, valorUnitario, fechaInicio, fechaFin) VALUES (NULL, 'Encuestas vigente', NULL, NULL, SYSDATE - 1, SYSDATE + 30);
  
-- DisparadoresNoOK
-- UPDATE de idEncuesta, trigger revierte al valor original
UPDATE Evaluaciones 
SET idEncuesta = 5          
WHERE referenciaAutor = 3 AND bienEspecifico = 'Guantes';
 
-- UPDATE de referenciaAutor, trigger revierte al valor original
UPDATE Evaluaciones 
SET referenciaAutor = 9          
WHERE referenciaAutor = 3 AND bienEspecifico = 'Guantes';
 
-- UPDATE de bienEspecifico, trigger revierte al valor original
UPDATE Evaluaciones 
SET bienEspecifico  = 'OtroBien' 
WHERE referenciaAutor = 3;
 
-- INSERT sobre Encuestas fuera de ventana
INSERT INTO Encuestas (idEncuesta, criterioEvaluado, presupuestoDisponible, valorUnitario, fechaInicio, fechaFin) VALUES (NULL, 'Encuestas vencida', NULL, NULL, TO_DATE('2025-01-01', 'YYYY-MM-DD'), TO_DATE('2025-02-01', 'YYYY-MM-DD'));
INSERT INTO Evaluaciones (id, fecha, referenciaAutor, bienEspecifico, puntuacion, comentarios, estado, idEncuesta) VALUES (NULL, NULL, 1, 'Guantes', 3, 'Error: Encuestas vencida', NULL, (SELECT MAX(idEncuesta) FROM Encuestas WHERE criterioEvaluado = 'Encuestas vencida'));

-- XDisparadores
DROP TRIGGER trg_encuesta_autonumero;
DROP TRIGGER trg_evaluacion_estado_default;
DROP TRIGGER trg_evaluacion_control_update;
DROP TRIGGER trg_evaluacion_control_delete;
DROP TRIGGER trg_evaluacion_encuesta_activa;


------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------- COMPONENTES -------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------- Registrar Registros ---------------------------------

------- CRUDE Registros -----------
CREATE OR REPLACE PACKAGE PC_REGISTROE AS

    PROCEDURE registrar(
        p_tiempo IN NUMBER,
        p_posicion IN NUMBER,
        p_dificultad IN NUMBER,
        p_comentarios IN VARCHAR2,
        p_nombreVersion  IN VARCHAR2,
        p_nombreSegmento IN VARCHAR2,
        p_idParticipante IN NUMBER
    );

    PROCEDURE modificar(
        p_numero IN NUMBER,
        p_revision IN NUMBER,
        p_comentarios IN VARCHAR2
    );

    PROCEDURE agregarFoto(
        p_numeroRegistro IN NUMBER,
        p_descripcion  IN VARCHAR2
    );

    PROCEDURE eliminar(
        p_numero IN NUMBER
    );

    PROCEDURE consultarSegmentosMasRapidos;

END PC_REGISTROE;
/

------------ CRUDI ----------------
CREATE OR REPLACE PACKAGE BODY PC_REGISTROE AS

    PROCEDURE registrar(
        p_tiempo IN NUMBER,
        p_posicion IN NUMBER,
        p_dificultad IN NUMBER,
        p_comentarios IN VARCHAR2,
        p_nombreVersion  IN VARCHAR2,
        p_nombreSegmento IN VARCHAR2,
        p_idParticipante IN NUMBER
    ) IS
    BEGIN
        INSERT INTO Registros (
            tiempo, posicion, dificultad, comentarios,
            nombreVersion, nombreSegmento, idParticipante
        )
        VALUES (
            p_tiempo, p_posicion, p_dificultad, p_comentarios,
            p_nombreVersion, p_nombreSegmento, p_idParticipante
        );
    END registrar;

    PROCEDURE modificar(
        p_numero IN NUMBER,
        p_revision IN NUMBER,
        p_comentarios IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Registros
        SET revision    = p_revision,
            comentarios = p_comentarios
        WHERE numero = p_numero;
    END modificar;

    PROCEDURE agregarFoto(
        p_numeroRegistro IN NUMBER,
        p_descripcion IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Foto (idFoto, numeroRegistro, descripcion)
        VALUES ((SELECT NVL(MAX(idFoto),0)+1 FROM Foto), p_numeroRegistro, p_descripcion);
    END agregarFoto;

    PROCEDURE eliminar(
        p_numero IN NUMBER
    ) IS
    BEGIN
        DELETE FROM Registros
        WHERE numero = p_numero;
    END eliminar;

    PROCEDURE consultarSegmentosMasRapidos IS
        CURSOR c_segmentos IS
            SELECT nombreSegmento, AVG(tiempo) AS tiempoPromedio
            FROM Registros
            GROUP BY nombreSegmento
            ORDER BY tiempoPromedio ASC;
        v_count NUMBER := 0;
    BEGIN
        FOR r IN c_segmentos LOOP
            EXIT WHEN v_count >= 5;
            DBMS_OUTPUT.PUT_LINE('Segmento: ' || r.nombreSegmento || ' - Tiempo promedio: ' || r.tiempoPromedio);
            v_count := v_count + 1;
        END LOOP;
    END consultarSegmentosMasRapidos;

END PC_REGISTROE;
/

-- CRUDOK
-- 1. Registrar un nuevo Registros exitosamente
BEGIN
    PC_REGISTROE.registrar(25, 1, 2, 'Buen tiempo', 'V1', 'S1', 1);
END;
/
-- 2. Registrar otro Registros exitosamente
BEGIN
    PC_REGISTROE.registrar(30, 2, 3, 'Buen esfuerzo', 'V1', 'S2', 2);
END;
/
-- 3. Modificar revision y Comentarios de un Registros
BEGIN
    PC_REGISTROE.modificar(400, 2, 'Comentarios actualizado');
END;
/
-- 4. Agregar foto a un Registros
BEGIN
    PC_REGISTROE.agregarFoto(400, 'Foto de llegada');
END;
/
-- 5. Consultar los 5 segmentos con tiempos mas cortos
BEGIN
    PC_REGISTROE.consultarSegmentosMasRapidos;
END;
/

-- CRUDNoOK
-- 1. Registrar un Ciclistas que no existe
BEGIN
    PC_REGISTROE.registrar(25, 1, 2, 'Error: Ciclistas inexistente', 'V1', 'S1', 9999);
END;
/
-- 2.  Registrar con dificultad fuera de rango
BEGIN
    PC_REGISTROE.registrar(25, 1, 6, 'Error: dificultad invalida', 'V1', 'S1', 1);
END;
/
-- 3. Agregar foto a un Registros inexistente
BEGIN
    PC_REGISTROE.agregarFoto(9999, 'Foto de Registros inexistente');
END;
/

--------------------------------------------------------------------------------
----------------------------- Registrar Evaluaciones ---------------------------
--------------------------------------------------------------------------------

------------- CRUDE EVALUACIONES ------------------
CREATE OR REPLACE PACKAGE PA_EVALUACIONES AS

    PROCEDURE adicionar(
        p_puntuacion IN NUMBER,
        p_estado IN VARCHAR2,
        p_comentarios IN VARCHAR2,
        p_idEncuesta IN NUMBER,
        p_referenciaAutor IN NUMBER
    );

    PROCEDURE modificar(
        p_id IN NUMBER,
        p_puntuacion IN NUMBER,
        p_comentarios IN VARCHAR2,
        p_estado IN VARCHAR2
    );

    PROCEDURE eliminar(
        p_id IN NUMBER
    );

    FUNCTION consultar(
        p_id IN NUMBER
    ) RETURN SYS_REFCURSOR;

    FUNCTION consultarEvaluaciones(
        p_idEncuesta IN NUMBER
    ) RETURN SYS_REFCURSOR;

END PA_EVALUACIONES;
/

----------------- CRUDI EVALUACIONES ----------------
CREATE OR REPLACE PACKAGE BODY PA_EVALUACIONES AS

    PROCEDURE adicionar(
        p_puntuacion IN NUMBER,
        p_estado IN VARCHAR2,
        p_comentarios IN VARCHAR2,
        p_idEncuesta IN NUMBER,
        p_referenciaAutor IN NUMBER
    ) IS
        v_id NUMBER;
        v_count NUMBER;
    BEGIN
        IF p_puntuacion < 1 OR p_puntuacion > 5 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Puntuación fuera de rango (1-5)');
        END IF;

        SELECT COUNT(*) INTO v_count
        FROM PARTICIPANTES
        WHERE id = p_referenciaAutor;

        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Autor no válido');
        END IF;

        SELECT COUNT(*) INTO v_count
        FROM ENCUESTAS
        WHERE idEncuesta = p_idEncuesta
          AND SYSDATE BETWEEN fechaInicio AND fechaFin;

        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Encuesta no activa');
        END IF;

        SELECT NVL(MAX(id),0)+1 INTO v_id FROM EVALUACIONES;

        INSERT INTO EVALUACIONES(
            id, fecha, puntuacion, estado,
            comentarios, idEncuesta, referenciaAutor
        )
        VALUES (
            v_id, SYSDATE, p_puntuacion, 'Activo',
            p_comentarios, p_idEncuesta, p_referenciaAutor
        );

    END adicionar;

    PROCEDURE modificar(
        p_id IN NUMBER,
        p_puntuacion IN NUMBER,
        p_comentarios IN VARCHAR2,
        p_estado IN VARCHAR2
    ) IS
    BEGIN
        UPDATE EVALUACIONES
        SET puntuacion = p_puntuacion,
            comentarios = p_comentarios,
            estado = p_estado
        WHERE id = p_id;
    END modificar;

    PROCEDURE eliminar(
        p_id IN NUMBER
    ) IS
        v_estado VARCHAR2(20);
    BEGIN
        SELECT estado INTO v_estado
        FROM EVALUACIONES
        WHERE id = p_id;

        IF v_estado = 'Activo' THEN
            RAISE_APPLICATION_ERROR(-20006, 'Debe inactivar antes de eliminar');
        END IF;

        DELETE FROM EVALUACIONES
        WHERE id = p_id;
    END eliminar;

    FUNCTION consultar(
        p_id IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT * FROM EVALUACIONES WHERE id = p_id;
        RETURN v_cursor;
    END;

    FUNCTION consultarEvaluaciones(
        p_idEncuesta IN NUMBER
    ) RETURN SYS_REFCURSOR IS
        v_cursor SYS_REFCURSOR;
    BEGIN
        OPEN v_cursor FOR
            SELECT * FROM EVALUACIONES WHERE idEncuesta = p_idEncuesta;
        RETURN v_cursor;
    END;

END PA_EVALUACIONES;
/

------------- CRUDOK--------------------
BEGIN
    PA_EVALUACIONES.adicionar(5, 'Activo', 'Muy buen servicio', 1, 1);
END;
/

BEGIN
    PA_EVALUACIONES.modificar(1, 4, 'Cambio Comentarios', 'Activo');
END;
/

DECLARE
    c SYS_REFCURSOR;
BEGIN
    c := PA_EVALUACIONES.consultar(1);
END;
/

--------------- CRUDNoOK -----------------
-- puntuación inválida
BEGIN
    PA_EVALUACIONES.adicionar(10, 'Activo', 'Error', 1, 1);
END;
/

-- Encuestas fuera de rango
BEGIN
    PA_EVALUACIONES.adicionar(3, 'Activo', 'Error', 999, 1);
END;
/

-- eliminar activa
BEGIN
    PA_EVALUACIONES.eliminar(1);
END;
/

--------------- XCRUD ------------------
DROP PACKAGE PC_REGISTROE;
DROP PACKAGE PA_EVALUACIONES;


-------------------------------------------------------------------------------------------
------------------------------- SEGURIDAD (ACTORES) ---------------------------------------
-------------------------------------------------------------------------------------------


----------------------------- REGISTRAR Registros--------------------------------------------

------------------------------- ACTORESE----------------------------------------------------

CREATE OR REPLACE PACKAGE PA_PERSONAE AS

    PROCEDURE consultarSegmentosMontana;
    
    PROCEDURE consultarSegmentosMasRapidos;
    
    PROCEDURE consultarPuntosCarrera(
        p_codigoCarrera IN VARCHAR2
    );
    
    PROCEDURE consultarEvaluacionesEncuesta(
        p_idEncuesta IN NUMBER
    );

END PA_PERSONAE;
/

CREATE OR REPLACE PACKAGE PA_PARTICIPANTEE AS
    PROCEDURE registrar(
        p_tiempo         IN NUMBER,
        p_posicion       IN NUMBER,
        p_dificultad     IN NUMBER,
        p_comentarios    IN VARCHAR2,
        p_nombreVersion  IN VARCHAR2,
        p_nombreSegmento IN VARCHAR2,
        p_idParticipante IN NUMBER
    );
    PROCEDURE modificar(
        p_numero      IN NUMBER,
        p_revision    IN NUMBER,
        p_comentarios IN VARCHAR2
    );
    PROCEDURE agregarFoto(
        p_numeroRegistro IN NUMBER,
        p_descripcion    IN VARCHAR2
    );
    PROCEDURE eliminar(
        p_numero IN NUMBER
    );
END PA_PARTICIPANTEE;
/


------------------------------- ACTORESI----------------------------------------------------

CREATE OR REPLACE PACKAGE BODY PA_PERSONAE AS
    PROCEDURE consultarSegmentosMontana IS
    BEGIN
        FOR r IN (
            SELECT s.nombre, s.tipo, p.nombre AS Puntos
            FROM Segmentos s
            JOIN Puntos p ON s.nombrePunto = p.nombre
            WHERE s.tipo = 'Montaña'
        ) LOOP
            NULL;
        END LOOP;
    END consultarSegmentosMontana;

    PROCEDURE consultarSegmentosMasRapidos IS
        v_count NUMBER := 0;
    BEGIN
        FOR r IN (
            SELECT nombreSegmento, AVG(tiempo) AS tiempoPromedio
            FROM Registros
            GROUP BY nombreSegmento
            ORDER BY tiempoPromedio ASC
        ) LOOP
            EXIT WHEN v_count >= 5;
            v_count := v_count + 1;
        END LOOP;
    END consultarSegmentosMasRapidos;

    PROCEDURE consultarPuntosCarrera(
        p_codigoCarrera IN VARCHAR2
    ) IS
    BEGIN
        FOR r IN (
            SELECT p.nombre, p.tipo, p.distancia
            FROM Puntos p
            JOIN Carreras c ON c.nombrePunto = p.nombre
            WHERE c.codigo = p_codigoCarrera
        ) LOOP
            NULL;
        END LOOP;
    END consultarPuntosCarrera;

    PROCEDURE consultarEvaluacionesEncuesta(
        p_idEncuesta IN NUMBER
    ) IS
    BEGIN
        FOR r IN (
            SELECT e.id, e.bienEspecifico, e.puntuacion, e.comentarios
            FROM Evaluaciones e
            WHERE e.idEncuesta = p_idEncuesta
        ) LOOP
            NULL;
        END LOOP;
    END consultarEvaluacionesEncuesta;

END PA_PERSONAE;
/


CREATE OR REPLACE PACKAGE BODY PA_PARTICIPANTEE AS
    PROCEDURE registrar(
        p_tiempo         IN NUMBER,
        p_posicion       IN NUMBER,
        p_dificultad     IN NUMBER,
        p_comentarios    IN VARCHAR2,
        p_nombreVersion  IN VARCHAR2,
        p_nombreSegmento IN VARCHAR2,
        p_idParticipante IN NUMBER
    ) IS
        v_numero NUMBER;
    BEGIN
        SELECT NVL(MAX(numero), 0) + 1
        INTO v_numero
        FROM Registros;

        INSERT INTO Registros (numero, fecha, tiempo, posicion, dificultad, comentarios, nombreVersion, nombreSegmento, idParticipante)
        VALUES (v_numero, SYSDATE, p_tiempo, p_posicion, p_dificultad, p_comentarios, p_nombreVersion, p_nombreSegmento, p_idParticipante);
    END registrar;

    PROCEDURE modificar(
        p_numero      IN NUMBER,
        p_revision    IN NUMBER,
        p_comentarios IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Registros
        SET revision    = p_revision,
            comentarios = p_comentarios
        WHERE numero = p_numero;
    END modificar;

    PROCEDURE agregarFoto(
        p_numeroRegistro IN NUMBER,
        p_descripcion    IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Foto (idFoto, numeroRegistro, descripcion)
        VALUES ((SELECT NVL(MAX(idFoto),0)+1 FROM Foto), p_numeroRegistro, p_descripcion);
    END agregarFoto;

    PROCEDURE eliminar(
        p_numero IN NUMBER
    ) IS
    BEGIN
        DELETE FROM Registros
        WHERE numero = p_numero;
    END eliminar;

END PA_PARTICIPANTEE;
/
---------------------- Seguridad (Autorizaciones) ------------------------------

-- Crear roles
CREATE ROLE PA_PARTICIPANTE;
CREATE ROLE PA_PERSONA;

-- Otorgar permisos de ejecucion a los roles
GRANT EXECUTE ON PA_PARTICIPANTEE TO PA_PARTICIPANTE;
GRANT EXECUTE ON PA_PERSONAE TO PA_PARTICIPANTE;
GRANT EXECUTE ON PA_PERSONAE TO PA_PERSONA;

-- XSeguridad
DROP ROLE PA_PARTICIPANTE;
DROP ROLE PA_PERSONA;

-- Asignacion de roles a usuarios
GRANT PA_PARTICIPANTE TO bd1000108451;
GRANT PA_PERSONA TO bd1000100692;


BEGIN
    BD1000100692.PA_PERSONAE.consultarSegmentosMasRapidos;
END;
/
