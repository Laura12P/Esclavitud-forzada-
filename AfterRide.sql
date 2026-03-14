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


-- Carrera y recorrido

INSERT INTO Punto VALUES (1,'Salida','Partida',0,TO_DATE('2025-03-04','YYYY-MM-DD'));
INSERT INTO Punto VALUES (2,'Control','Control',50,TO_DATE('2025-03-04','YYYY-MM-DD'));
INSERT INTO Punto VALUES (3,'Meta','Llegada',100,TO_DATE('2025-03-05','YYYY-MM-DD'));

INSERT INTO Carrera VALUES ('C01','Tour Andes','Colombia','Montaña','Anual');
INSERT INTO Carrera VALUES ('C02','Ruta Caribe','Colombia','Ruta','Anual');
INSERT INTO Carrera VALUES ('C03','Vuelta Bogota','Colombia','Urbana','Anual');

INSERT INTO Segmento VALUES ('Plano','S1','Salida');
INSERT INTO Segmento VALUES ('Montaña','S2','Control');
INSERT INTO Segmento VALUES ('Sprint','S3','Meta');


-- Participantes

INSERT INTO Participante VALUES (1,'CC','11111','Colombia','p1@mail.com');
INSERT INTO Participante VALUES (2,'CC','22222','Colombia','p2@mail.com');
INSERT INTO Participante VALUES (3,'CC','33333','Colombia','p3@mail.com');

INSERT INTO Persona VALUES (1,'Juan Perez');
INSERT INTO Persona VALUES (2,'Maria Lopez');
INSERT INTO Persona VALUES (3,'Carlos Diaz');

INSERT INTO Ciclista VALUES (1,TO_DATE('2000-01-01','YYYY-MM-DD'),'Elite');
INSERT INTO Ciclista VALUES (2,TO_DATE('1999-02-02','YYYY-MM-DD'),'Elite');
INSERT INTO Ciclista VALUES (3,TO_DATE('2002-03-03','YYYY-MM-DD'),'Sub23');


-- Encuestas

INSERT INTO Encuesta VALUES (1,'Organizacion',1000000,2000,TO_DATE('2025-03-01','YYYY-MM-DD'),TO_DATE('2025-04-01','YYYY-MM-DD'));
INSERT INTO Encuesta VALUES (2,'Seguridad',2000000,3000,TO_DATE('2025-04-01','YYYY-MM-DD'),TO_DATE('2025-05-01','YYYY-MM-DD'));
INSERT INTO Encuesta VALUES (3,'Logistica',1500000,2500,TO_DATE('2025-05-01','YYYY-MM-DD'),TO_DATE('2025-06-01','YYYY-MM-DD'));

INSERT INTO Evaluacion VALUES (1,TO_DATE('2025-04-10','YYYY-MM-DD'),1,'Casco',5,'Muy bueno','Activo',1);
INSERT INTO Evaluacion VALUES (2,TO_DATE('2025-04-11','YYYY-MM-DD'),2,'Bicicleta',4,'Buen estado','Activo',1);
INSERT INTO Evaluacion VALUES (3,TO_DATE('2025-04-12','YYYY-MM-DD'),3,'Guantes',3,'Aceptable','Activo',2);

INSERT INTO Comentario VALUES (1,'Buen evento',1);
INSERT INTO Comentario VALUES (2,'Me gusto la organizacion',2);
INSERT INTO Comentario VALUES (3,'Podria mejorar',3);


-- Resultados

INSERT INTO Registro VALUES (1,TO_DATE('2025-04-05','YYYY-MM-DD'),30,1,1,2,'Buen tiempo','V1','S1',1);
INSERT INTO Registro VALUES (2,TO_DATE('2025-04-05','YYYY-MM-DD'),32,2,1,3,'Buen esfuerzo','V1','S2',2);
INSERT INTO Registro VALUES (3,TO_DATE('2025-04-05','YYYY-MM-DD'),35,3,1,4,'Regular','V1','S3',3);

INSERT INTO Foto VALUES (1,1,'Llegada ganador');
INSERT INTO Foto VALUES (2,2,'Subida montaña');
INSERT INTO Foto VALUES (3,3,'Meta final');



