----- CICLO 1: TABLAS

-- Carrera y recorrido Tablas
CREATE TABLE Punto (
    orden NUMBER(2)  NOT NULL,
    nombre VARCHAR2(10) PRIMARY KEY,
    tipo VARCHAR2(20) NOT NULL,
    distancia NUMBER(8,2) NOT NULL,
    tiempoLimite DATE NOT NULL
);

CREATE TABLE Carrera (
    codigo VARCHAR2(20) PRIMARY KEY,
    nombre VARCHAR2(30) NOT NULL,
    pais VARCHAR2(50) NOT NULL,
    categoria VARCHAR2(20) NOT NULL,
    periodicidad VARCHAR2(20) NOT NULL
);

CREATE TABLE Segmento (
    tipo VARCHAR2(20) NOT NULL, 
    nombre VARCHAR2(10) PRIMARY KEY,
    nombrePunto VARCHAR2(20) NOT NULL
);

CREATE TABLE PropiedadDe (
    porcentaje NUMBER (1,100) NOT NULL, 
    idParticipante NUMBER NOT NULL, 
    codigoCarrera VARCHAR2(20) NOT NULL,
    PRIMARY KEY (idParticipante, codigoCarrera)
);
-- Ejecución Carreras Tablas

CREATE TABLE Organizacion (
    versionOrganizacion VARCHAR2(30) NOT NULL,
    idParticipante NUMBER NOT NULL,
    nombreVersion VARCHAR2(30) NOT NULL,
    PRIMARY KEY (idParticipante, nombreVersion)
);

CREATE TABLE Participacion (
    idParticipante NUMBER NOT NULL,
    nombreVersion VARCHAR2(30) NOT NULL,
    versionParticipacion VARCHAR2(30) NOT NULL,
    PRIMARY KEY (idParticipante, nombreVersion)
);

CREATE TABLE AgrupacionSegmento(
    versionSegmento VARCHAR2(30) NOT NULL,
    nombreVersion VARCHAR(20) NOT NULL,
    nombreSegmento VARCHAR(30) NOT NULL,
    PRIMARY KEY (nombreVersion, nombreSegmento)
);

CREATE TABLE Version(
    nombre VARCHAR2(5) PRIMARY KEY,
    fecha DATE NOT NULL,
    codigoCarrera VARCHAR2(20)
);
--*** Participantes del sistema Tablas 
CREATE TABLE Participante (
    id NUMBER PRIMARY KEY,
    idt VARCHAR2(20) NOT NULL,
    idn VARCHAR2(30) NOT NULL,
    pais VARCHAR2(50) NOT NULL,
    correo VARCHAR2(100) NOT NULL
);

CREATE TABLE Persona (
    idParticipante NUMBER PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL
);

CREATE TABLE Ciclista (
    idParticipante NUMBER PRIMARY KEY,
    nacimiento DATE NOT NULL,
    categoria VARCHAR2(20) NOT NULL
);

CREATE TABLE ParticipacionEncuesta(
    idParcipante  NUMBER NOT NULL,
    idEncuesta NUMBER NOT NULL,
    fechaRepuesta DATE NOT NULL,
    estado VARCHAR2(20) NOT NULL,
    PRIMARY KEY (idParcipante, idEncuesta)
);

CREATE TABLE Empresa (
    idParticipante NUMBER PRIMARY KEY,
    razonSocial VARCHAR2(30) NOT NULL
);

-- Encuestas y retroalimentacion Tablas
CREATE TABLE Encuesta (
    idEncuesta NUMBER PRIMARY KEY,
    criterioEvaluado VARCHAR2(50) NOT NULL,
    presupuestoDisponible NUMBER NOT NULL,
    valorUnitario NUMBER NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL
);

CREATE TABLE Evaluacion(
    id NUMBER PRIMARY KEY,
    Fecha DATE NOT NULL,
    ReferenciaAutor NUMBER NOT NULL,
    bienEspecifico VARCHAR2(50) NOT NULL,
    puntuacion NUMBER(1,5) NOT NULL,
    comentarios VARCHAR2(500) NOT NULL,
    estado VARCHAR2(20) NOT NULL,
    idEncuesta NUMBER NOT NULL
);

CREATE TABLE Comentario (
    id NUMBER PRIMARY KEY,
    contenido VARCHAR2(500) NOT NULL,
    idEvaluacion NUMBER NOT NULL
);

-- Resultados Tablas

CREATE TABLE Registro (
    numero NUMBER PRIMARY KEY,
    fecha DATE NOT NULL,
    tiempo NUMBER NOT NULL,
    posicion NUMBER NOT NULL,
    revision NUMBER NOT NULL,
    dificultad NUMBER NOT NULL,
    comentarios VARCHAR2(500) ,
    nombreVersion VARCHAR2(20) NOT NULL,
    nombreSegmento VARCHAR2(30) NOT NULL,
    idParticipante NUMBER NOT NULL
);

CREATE TABLE Foto (
    idFoto NUMBER PRIMARY KEY,
    numeroRegistro NUMBER NOT NULL,
    descripcion VARCHAR2(200)
);


----- CICLO 1: POBLAROK(01):
-- Carrera y recorrido Tablas
INSERT INTO Punto VALUES (1,'Salida','Partida',0,"2025-03-04");
INSERT INTO Segmento VALUES ('Segmento3','Carrera','Meta');
INSERT INTO PropiedadDe VALUES (40,2,'C02');
INSERT INTO PropiedadDe VALUES (60,3,'C03');

-- Ejecución Carreras Tablas
INSERT INTO Verssion VALUES ('V1', DATE '2025-05-01', 'C01');
INSERT INTO Organizacion VALUES ('Organizacion1', 4, 'Version1');
INSERT INTO AgrupacionSegmento VALUES ('AgrupacionSegmento1', 'V1', 'Segmento1');

-- Participantes Sistema Tablas
INSERT INTO Participante VALUES (1,'CC', '1010', 'Africa', 'paquito@mail.com');
INSERT INTO Persona VALUES (1, 'Samuel');
INSERT INTO Ciclista VALUES(2, DATE '1995-02-10', 'Elite');

-- Encuestas y retroalimentacion Tablas
INSERT INTO Encuesta VALUES (1, 'Fue evaluado correctamente', 1000000, '2000', TO_DATE('2025-03-04','YYYY-MM-DD'), TO_DATE('2025-04-05','YYYY-MM-DD'))
INSERT INTO Evaluacion VALUES (1, TO_DATE('2025-05-05','YYYY-MM-DD'), 'Daniel Perez', 'Medias', 32, 'Sin palabras', 'Correcto', 1)
INSERT INTO Comentario VALUES (1, NULL, 1)

-- Registros y Fotos
INSERT INTO Registros (1, TO_DATE('2025-04-05','YYYY-MM-DD'), 30, 2, NULL, 'Dificil', NULL, 'PrimeraC', 'SegmentoPrimero', 1)
INSERT INTO Fotos (1, 1, NULL)
INSERT INTO Registros (1, TO_DATE('2025-04-05','YYYY-MM-DD'), 30, 2, NULL, 'Dificil', NULL, 'PrimeraC', 'SegmentoPrimero', 1)



