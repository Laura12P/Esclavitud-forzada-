-- ## 1. CONSTRUCCIÓN SIN RESTRICCIONES EXTERNAS

CREATE TABLE Notificaciones (
    id_notificaciones VARCHAR2(10) NOT NULL,
    email_usuario VARCHAR2(50) NOT NULL,
    descripcion VARCHAR2(200) NOT NULL,
    medio_pago_usado VARCHAR2(20)NOT NULL,
    comentario VARCHAR2(200) NOT NULL,
    id_pago VARCHAR2(32) NOT NULL
);

CREATE TABLE Pagos (
    id_pago VARCHAR2(32) NOT NULL,
    referencia VARCHAR2(255) NOT NULL,
    valor NUMBER(5) NOT NULL,
    fecha DATE NOT NULL,
    estado VARCHAR2(10) NOT NULL,
    codigo_suscripcion NUMBER(3) NOT NULL
);

CREATE TABLE MetodosPago (
    id_pago VARCHAR2(32) NOT NULL, 
    metodo_pago VARCHAR(20) NOT NULL
);

CREATE TABLE Suscripciones (
    codigo NUMBER(3) NOT NULL,
    fecha_inicio DATE NOT NULL, 
    fecha_fin DATE,
    estado VARCHAR2(10) NOT NULL,
    id_plan NUMBER(5) NOT NULL
);

CREATE TABLE Planes (
    id_plan NUMBER(5) NOT NULL, 
    tipo_plan VARCHAR2(10)NOT NULL, 
    duracion NUMBER(2) NOT NULL,
    costo NUMBER(5) NOT NULL
);

CREATE TABLE Usuarios (
    id_usuario NUMBER(10) NOT NULL,
    nombre VARCHAR2(20) NOT NULL,
    correo VARCHAR2(50) NOT NULL,
    pais VARCHAR2(10) NOT NULL, 
    fecha_registro DATE
);

CREATE TABLE Validadores (
    id_validador NUMBER(10) NOT NULL
);

CREATE TABLE Programadores (
    id_programador NUMBER(10) NOT NULL
);

CREATE TABLE Comenta (
    id_programador NUMBER(10) NOT NULL, 
    id_solucion NUMBER(10) NOT NULL, 
    comentario VARCHAR2(255) NOT NULL
);

CREATE TABLE Soluciones (
    id_solucion NUMBER(10) NOT NULL,
    explicacion VARCHAR2(255) NOT NULL, 
    codigoPropuesto VARCHAR2(255) NOT NULL
);

CREATE TABLE Problemas (
    id_problema NUMBER(10) NOT NULL, 
    enunciado VARCHAR2(255) NOT NULL, 
    nivel_dificultad VARCHAR2(20) NOT NULL, 
    categoria VARCHAR2(10) NOT NULL
);
-- T1: Automatizar código, fecha_inicio y estado al insertar suscripción
CREATE TRIGGER trg_before_insert_suscripcion
BEFORE INSERT ON Suscripciones
FOR EACH ROW
DECLARE v_codigo NUMBER;
BEGIN
    SELECT NVL(MAX(codigo), 0) + 1 INTO v_codigo FROM Suscripciones;
    :NEW.codigo       := v_codigo;
    :NEW.fecha_inicio := CURRENT_DATE;
    :NEW.estado       := 'pendiente';
END;
-- T2: Calcular fecha_fin según duración del plan
CREATE TRIGGER trg_fecha_fin_suscripcon
BEFORE INSERT ON Suscripciones
FOR EACH ROW
DECLARE v_duracion NUMBER;
BEGIN 
    SELECT duracion INTO v_duracion
    FROM Planes WHERE id_plan =: NEW.id_plan;
    :NEW.fecha_fin := :NEW.fecha_inicio + v_duracion;
END;

-- T3: Si pago rechazado → crear notificación automáticamente
CREATE TRIGGER trg_notificacion_pago_rechazado
AFTER INSERT ON Pagos
FOR EACH ROW 
WHEN (NEW.estado = 'rechazado')
BEGIN 
    INSERT INTO Notificaciones (id_notificaciones, email_usuario, descripcion, medio_pago_usado, comentario, id_pago)
    SELECT
    NVL(MAX(id_noficaciones), 0)+1,
    u.correo,
    'Pago rechazado'
    mp.metodo_pago
FROM Usuarios u
JOIN Suscripciones s ON s.id_usuario = u.id_usuario
JOIN MetodosPago mp ON mp.id_pago =: NEW.id_pago, Notificaciones
WHERE s.codigo =: NEW.codigo_suscripcion;
END;

-- T4: Pago aprobado, suscripción pasa a 'activa'
CREATE TRIGGER trg_aprobar_pago
AFTER UPDATE OF estado ON Pagos
FOR EACH ROW
WHEN (NEW.estado = 'aprobado')
BEGIN
    UPDATE Suscripciones
    SET estado = 'activa'
    WHERE codigo =: NEW.codigo_suscripcion;
END;
