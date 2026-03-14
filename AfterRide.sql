----- CICLO 1: TABLAS

-- Carrera y recorrido Tablas
CREATE TABLE Punto (
    orden NUMBER(2)  NOT NULL,
    nombre VARCHAR2(10) PRIMARY KEY,
    tipo VARCHAR2(20) NOT NULL,
    distancia NUMBER(8,2) NOT NULL,
    tiempoLimite DATE
);

CREATE TABLE Carrera (
    codigo VARCHAR2(20) PRIMARY KEY,
    nombre VARCHAR2(30) NOT NULL,
    pais VARCHAR2(50) NOT NULL,
    categoria VARCHAR2(20) NOT NULL,
    periodicidad VARCHAR2(20) NOT NULL
);

CREATE TABLE Segmento (
    tipo VARCHAR2(20),
    nombre VARCHAR2(10) PRIMARY KEY,
    nombrePunto VARCHAR2(20)
);

CREATE TABLE PropiedadDe (
    porcentaje NUMBER (1,100),
    idParticipante NUMBER,
    codigoCarrera VARCHAR2(20),
    PRIMARY KEY (idParticipante, codigoCarrera)
);
-- Ejecución Carreras Tablas

CREATE TABLE Organizacion (
    versionOrganizacion VARCHAR2(30),
    idParticipante NUMBER,
    nombreVersion VARCHAR2(30),
    PRIMARY KEY (idParticipante, nombreVersion)
);

CREATE TABLE Participacion (
    idParticipante NUMBER,
    nombreVersion VARCHAR2(30),
    versionParticipacion VARCHAR2(30),
    PRIMARY KEY (idParticipante, nombreVersion)
);

CREATE TABLE AgrupacionSegmento(
    versionSegmento VARCHAR2(30),
    nombreVersion VARCHAR(20),
    nombreSegmento VARCHAR(30),
    PRIMARY KEY (nombreVersion, nombreSegmento)
);

CREATE TABLE Verssion(
    nombre VARCHAR2(5) PRIMARY KEY,
    fecha DATE NOT NULL,
    codigoCarrera VARCHAR2(20)
);
-- Participantes del sistema Tablas 
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
    categoria VARCHAR2(20)
);

CREATE TABLE ParticipacionEncuesta(
    idParcipante  NUMBER,
    idEncuesta NUMBER,
    fechaRepuesta DATE,
    estado VARCHAR2(20),
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
    ReferenciaAutor NUMBER,
    bienEspecifico VARCHAR2(50),
    puntuacion NUMBER(1,5),
    comentarios VARCHAR2(500),
    estado VARCHAR2(20),
    idEncuesta NUMBER
);

CREATE TABLE Comentario (
    id NUMBER PRIMARY KEY,
    contenido VARCHAR2(500),
    idEvaluacion NUMBER
);

-- Resultados Tablas

CREATE TABLE Registro (
    numero NUMBER PRIMARY KEY,
    fecha DATE,
    tiempo NUMBER,
    posicion NUMBER,
    revision NUMBER,
    dificultad NUMBER,
    comentarios VARCHAR2(500),
    nombreVersion VARCHAR2(20),
    nombreSegmento VARCHAR2(30),
    idParticipante NUMBER
);

CREATE TABLE Foto (
    idFoto NUMBER PRIMARY KEY,
    numeroRegistro NUMBER,
    descripcion VARCHAR2(200)
);

--EJEMPLO
INSERT INTO Punto VALUES (1,'Salida','Partida',0, '2026-01-03');
