-- ## 1. CONSTRUCCIÓN SIN RESTRICCIONES EXTERNAS

CREATE TABLE Notificaciones (
    id_notificaciones VARCHAR2(10) NOT NULL,
    email_usuario VARCHAR2(50) NOT NULL,
    descripcion VARCHAR2(200) NOT NULL,
    medio_pago_usado VARCHAR2(20)NOT NULL,
    comentario VARCHAR(200) NOT NULL,
    id_pago NUMBER(10) NOT NULL
)

CREATE TABLE Pagos (
    id_pago VARCHAR2(32) NOT NULL,
    referencia VARCHAR2(255) NOT NULL,
    valor NUMBER(5) NOT NULL,
    fecha DATE NOT NULL,
    estado VARCHAR2(10) NOT NULL,
    codigo_suscripcion NUMBER(3) NOT NULL
)

CREATE TABLE MetodosPago (
    id_pago NUMBER(10) NOT NULL, 
    metodo_pago VARCHAR(20) NOT NULL
)

CREATE TABLE Suscripciones (
    codigo NUMBER(3) NOT NULL,
    fecha_inicio DATE NOT NULL, 
    fecha_fin DATE,
    estado VARCHAR2(10) NOT NULL,
    id_plan NUMBER(5) NOT NULL
)

CREATE TABLE Planes (
    id_plan NUMBER(5) NOT NULL, 
    tipo_plan VARCHAR2(10)NOT NULL, 
    duracion NUMBER(2) NOT NULL,
    costo NUMBER(5) NOT NULL
)

CREATE TABLE Usuarios (
    id_usuario NUMBER(10) NOT NULL,
    nombre VARCHAR2(20) NOT NULL,
    correo VARCHAR2(50) NOT NULL,
    pais VARCHAR2(10) NOT NULL, 
    fecha_registro DATE
)

CREATE TABLE Validadores (
    id_validador NUMBER(10) NOT NULL
)

CREATE TABLE Programadores (
    id_programador NUMBER(10) NOT NULL
)

CREATE TABLE Comenta (
    id_programador NUMBER(10) NOT NULL, 
    id_solucion NUMBER(10) NOT NULL, 
    comentario VARCHAR2(255) NOT NULL
)

CREATE TABLE Soluiciones (
    id_solucion NUMBER(10) NOT NULL,
    explicacion VARCHAR2(255) NOT NULL, 
    codigoPropuesto VARCHAR2(255) NOT NULL
)

CREATE TABLE Problemas (
    id_problema NUMBER(10) NOT NULL, 
    enunciado VARCHAR2(255) NOT NULL, 
    nivel_dificultad VARCHAR2(20) NOT NULL, 
    categoria VARCHAR2(10) NOT NULL
)
