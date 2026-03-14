----- CICLO 1: TABLAS
CREATE TABLE Punto (
orden NUMBER(2) NOT NULL,
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
periodicidad VARCHAR2(20) NOT NULL,
nombrePunto VARCHAR2(10)
);

CREATE TABLE Segmento (
tipo VARCHAR2(20) NOT NULL,
nombre VARCHAR2(10) PRIMARY KEY,
nombrePunto VARCHAR2(10)
);

CREATE TABLE PropiedadDe (
porcentaje NUMBER(3),
idParticipante NUMBER,
codigoCarrera VARCHAR2(20),
PRIMARY KEY (idParticipante,codigoCarrera)
);

CREATE TABLE Version (
nombre VARCHAR2(20) PRIMARY KEY,
fecha DATE NOT NULL,
codigoCarrera VARCHAR2(20)
);

CREATE TABLE Organizacion (
versionOrganizacion VARCHAR2(30),
idParticipante NUMBER,
nombreVersion VARCHAR2(20),
PRIMARY KEY (idParticipante,nombreVersion)
);

CREATE TABLE Participacion (
idParticipante NUMBER,
nombreVersion VARCHAR2(20),
versionParticipacion VARCHAR2(30),
PRIMARY KEY (idParticipante,nombreVersion)
);

CREATE TABLE AgrupacionSegmento(
versionSegmento VARCHAR2(30),
nombreVersion VARCHAR2(20),
nombreSegmento VARCHAR2(10),
PRIMARY KEY(nombreVersion,nombreSegmento)
);

CREATE TABLE Participante (
id NUMBER PRIMARY KEY,
idt VARCHAR2(20) NOT NULL,
idn VARCHAR2(30) NOT NULL,
pais VARCHAR2(50) NOT NULL,
correo VARCHAR2(100) NOT NULL
);

CREATE TABLE Persona (
idParticipante NUMBER PRIMARY KEY,
nombre VARCHAR2(50)
);

CREATE TABLE Ciclista (
idParticipante NUMBER PRIMARY KEY,
nacimiento DATE,
categoria VARCHAR2(20)
);

CREATE TABLE Empresa (
idParticipante NUMBER PRIMARY KEY,
razonSocial VARCHAR2(30)
);

CREATE TABLE Encuesta (
idEncuesta NUMBER PRIMARY KEY,
criterioEvaluado VARCHAR2(50),
presupuestoDisponible NUMBER,
valorUnitario NUMBER,
fechaInicio DATE,
fechaFin DATE
);

CREATE TABLE ParticipacionEncuesta(
idParticipante NUMBER,
idEncuesta NUMBER,
fechaRespuesta DATE,
estado VARCHAR2(20),
PRIMARY KEY(idParticipante,idEncuesta)
);

CREATE TABLE Evaluacion(
id NUMBER PRIMARY KEY,
fecha DATE,
referenciaAutor NUMBER,
bienEspecifico VARCHAR2(50),
puntuacion NUMBER(1),
comentarios VARCHAR2(500),
estado VARCHAR2(20),
idEncuesta NUMBER
);

CREATE TABLE Comentario (
id NUMBER PRIMARY KEY,
contenido VARCHAR2(500),
idEvaluacion NUMBER
);

CREATE TABLE Registro (
numero NUMBER PRIMARY KEY,
fecha DATE,
tiempo NUMBER,
posicion NUMBER,
revision NUMBER,
dificultad NUMBER,
comentarios VARCHAR2(500),
nombreVersion VARCHAR2(20),
nombreSegmento VARCHAR2(10),
idParticipante NUMBER
);

CREATE TABLE Foto (
idFoto NUMBER PRIMARY KEY,
numeroRegistro NUMBER,
descripcion VARCHAR2(200)
);

--- POBLAROK(1)
INSERT INTO Punto VALUES (1,'Salida','Partida',0,TO_DATE('2025-03-04','YYYY-MM-DD'));
INSERT INTO Punto VALUES (2,'Control','Control',50,TO_DATE('2025-03-04','YYYY-MM-DD'));
INSERT INTO Punto VALUES (3,'Meta','Llegada',100,TO_DATE('2025-03-05','YYYY-MM-DD'));

INSERT INTO Carrera VALUES ('C01','Tour Andes','Colombia','Montaña','Anual','Salida');
INSERT INTO Carrera VALUES ('C02','Ruta Caribe','Colombia','Ruta','Anual','Control');
INSERT INTO Carrera VALUES ('C03','Vuelta Bogota','Colombia','Urbana','Anual','Meta');

INSERT INTO Segmento VALUES ('Plano','S1','Salida');
INSERT INTO Segmento VALUES ('Montaña','S2','Control');
INSERT INTO Segmento VALUES ('Sprint','S3','Meta');

INSERT INTO Participante VALUES (1,'CC','111','Colombia','a@mail.com');
INSERT INTO Participante VALUES (2,'CC','222','Colombia','b@mail.com');
INSERT INTO Participante VALUES (3,'CC','333','Colombia','c@mail.com');

INSERT INTO Persona VALUES (1,'Juan');
INSERT INTO Persona VALUES (2,'Maria');
INSERT INTO Persona VALUES (3,'Carlos');

INSERT INTO Ciclista VALUES (1,TO_DATE('2000-01-01','YYYY-MM-DD'),'Elite');
INSERT INTO Ciclista VALUES (2,TO_DATE('1999-02-02','YYYY-MM-DD'),'Elite');
INSERT INTO Ciclista VALUES (3,TO_DATE('2002-03-03','YYYY-MM-DD'),'Sub23');

INSERT INTO Encuesta VALUES (1,'Organizacion',1000000,2000,TO_DATE('2025-03-01','YYYY-MM-DD'),TO_DATE('2025-04-01','YYYY-MM-DD'));
INSERT INTO Encuesta VALUES (2,'Seguridad',2000000,3000,TO_DATE('2025-04-01','YYYY-MM-DD'),TO_DATE('2025-05-01','YYYY-MM-DD'));
INSERT INTO Encuesta VALUES (3,'Logistica',1500000,2500,TO_DATE('2025-05-01','YYYY-MM-DD'),TO_DATE('2025-06-01','YYYY-MM-DD'));

INSERT INTO Evaluacion VALUES (1,TO_DATE('2025-04-10','YYYY-MM-DD'),1,'Casco',5,'Muy bueno','Activo',1);
INSERT INTO Evaluacion VALUES (2,TO_DATE('2025-04-11','YYYY-MM-DD'),2,'Bicicleta',4,'Buen estado','Activo',1);
INSERT INTO Evaluacion VALUES (3,TO_DATE('2025-04-12','YYYY-MM-DD'),3,'Guantes',3,'Aceptable','Activo',2);

INSERT INTO Registro VALUES (1,TO_DATE('2025-04-05','YYYY-MM-DD'),30,1,1,2,'Buen tiempo','V1','S1',1);
INSERT INTO Registro VALUES (2,TO_DATE('2025-04-05','YYYY-MM-DD'),32,2,1,3,'Buen esfuerzo','V1','S2',2);
INSERT INTO Registro VALUES (3,TO_DATE('2025-04-05','YYYY-MM-DD'),35,3,1,4,'Regular','V1','S3',3);

INSERT INTO Foto VALUES (1,1,'Ganador');
INSERT INTO Foto VALUES (2,2,'Montaña');
INSERT INTO Foto VALUES (3,3,'Meta');

--- CICLO 1: PoblarNoOK (2 y 3)

-- PK duplicada
INSERT INTO Punto VALUES (1,'Salida','Partida',0,TO_DATE('2025-03-04','YYYY-MM-DD'));

-- NULL en campo obligatorio
INSERT INTO Punto VALUES (4,'P4',NULL,20,TO_DATE('2025-03-04','YYYY-MM-DD'));

-- segmento con punto inexistente
INSERT INTO Segmento VALUES ('Plano','S10','PuntoFalso');

--- CICLO 1: XPoblar

DELETE FROM Foto;
DELETE FROM Registro;
DELETE FROM Comentario;
DELETE FROM Evaluacion;
DELETE FROM Encuesta;
DELETE FROM Ciclista;
DELETE FROM Persona;
DELETE FROM Participante;
DELETE FROM Segmento;
DELETE FROM Punto;
DELETE FROM Carrera;

--- CICLO 1: Atributos
ALTER TABLE Evaluacion
ADD CONSTRAINT chk_puntuacion
CHECK (puntuacion BETWEEN 1 AND 5);

ALTER TABLE PropiedadDe
ADD CONSTRAINT chk_porcentaje
CHECK (porcentaje BETWEEN 0 AND 100);

--- CICLO 1: Únicas
ALTER TABLE Participante
ADD CONSTRAINT uq_correo UNIQUE(correo);

--- CICLO 1: Foráneas
ALTER TABLE Segmento
ADD CONSTRAINT fk_segmento_punto
FOREIGN KEY(nombrePunto)
REFERENCES Punto(nombre);

ALTER TABLE Evaluacion
ADD CONSTRAINT fk_eval_encuesta
FOREIGN KEY(idEncuesta)
REFERENCES Encuesta(idEncuesta);

ALTER TABLE Registro
ADD CONSTRAINT fk_registro_participante
FOREIGN KEY(idParticipante)
REFERENCES Participante(id);

ALTER TABLE Foto
ADD CONSTRAINT fk_foto_registro
FOREIGN KEY(numeroRegistro)
REFERENCES Registro(numero);

--- Construcción: consultando
--- CICLO 1: Cinco segmentos con tiempos más cortos

SELECT nombreSegmento, tiempo
FROM Registro
ORDER BY tiempo
FETCH FIRST 5 ROWS ONLY;

--- CICLO 1: Puntos de la carrera

SELECT nombre, tipo, distancia
FROM Punto
ORDER BY orden;

--- CICLO 1: Consulta propuesta

SELECT p.nombre, r.posicion
FROM Persona p
JOIN Registro r
ON p.idParticipante = r.idParticipante
ORDER BY r.posicion;




