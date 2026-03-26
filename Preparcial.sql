--## Primer punto: Construccion tablas sin restricciones externas

CREATE TABLE Notificaciones (
    id_notificaciones VARCHAR2(10) NOT NULL,
    email_usuario     VARCHAR2(50) NOT NULL,
    descripcion       VARCHAR2(200) NOT NULL,
    medio_pago_usado  VARCHAR2(20) NOT NULL,
    comentario        VARCHAR2(200) NOT NULL,
    id_pago           VARCHAR2(32) NOT NULL
);

CREATE TABLE Pagos (
    id_pago            VARCHAR2(32) NOT NULL,
    referencia         VARCHAR2(255) NOT NULL,
    valor              NUMBER(5) NOT NULL,
    fecha              DATE NOT NULL,
    estado             VARCHAR2(10) NOT NULL,
    codigo_suscripcion NUMBER(3) NOT NULL
);

CREATE TABLE MetodosPago (
    id_pago     VARCHAR2(32) NOT NULL,
    metodo_pago VARCHAR2(20) NOT NULL
);

CREATE TABLE Suscripciones (
    codigo      NUMBER(3) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin    DATE,
    estado       VARCHAR2(10) NOT NULL,
    id_plan      NUMBER(5) NOT NULL,
    id_usuario   NUMBER(10) NOT NULL
);

CREATE TABLE Planes (
    id_plan   NUMBER(5) NOT NULL,
    tipo_plan VARCHAR2(15) NOT NULL,
    duracion  NUMBER(2) NOT NULL,
    costo     NUMBER(5) NOT NULL
);

CREATE TABLE Usuarios (
    id_usuario      NUMBER(10) NOT NULL,
    nombre          VARCHAR2(20) NOT NULL,
    correo          VARCHAR2(50) NOT NULL,
    pais            VARCHAR2(10) NOT NULL,
    fecha_registro  DATE
);

CREATE TABLE Validadores (
    id_validador NUMBER(10) NOT NULL
);

CREATE TABLE Programadores (
    id_programador NUMBER(10) NOT NULL
);

CREATE TABLE Comenta (
    id_programador NUMBER(10) NOT NULL,
    id_solucion    NUMBER(10) NOT NULL,
    comentario     VARCHAR2(255) NOT NULL
);

CREATE TABLE Soluciones (
    id_solucion      NUMBER(10) NOT NULL,
    explicacion      VARCHAR2(255) NOT NULL,
    codigoPropuesto  VARCHAR2(255) NOT NULL
);

CREATE TABLE Problemas (
    id_problema       NUMBER(10) NOT NULL,
    enunciado         VARCHAR2(255) NOT NULL,
    nivel_dificultad  VARCHAR2(20) NOT NULL,
    categoria         VARCHAR2(10) NOT NULL
);

CREATE TABLE ProblemasResuelto (
    id_usuario       NUMBER(10) NOT NULL,
    id_problema      NUMBER(10) NOT NULL,
    problemaResuelto VARCHAR2(255) NOT NULL
);


--## Segundo punto: Restricciones declarativas CRUD Mantener Suscripcion

-- Tabla Planes: llave primaria
ALTER TABLE Planes
    ADD CONSTRAINT pk_planes PRIMARY KEY (id_plan);

-- Tabla Planes: restriccion 1 — tipos de plan validos
ALTER TABLE Planes
    ADD CONSTRAINT chk_tipo_plan
    CHECK (tipo_plan IN ('Mensual', 'Anual', 'Empresarial'));

-- Tabla Usuarios: llave primaria (necesaria para FK de Suscripciones)
ALTER TABLE Usuarios
    ADD CONSTRAINT pk_usuarios PRIMARY KEY (id_usuario);

-- Tabla Usuarios: correo unico
ALTER TABLE Usuarios
    ADD CONSTRAINT uk_usuarios_correo UNIQUE (correo);

-- Tabla Suscripciones: llave primaria
ALTER TABLE Suscripciones
    ADD CONSTRAINT pk_suscripciones PRIMARY KEY (codigo);

-- Tabla Suscripciones: FK hacia Planes
ALTER TABLE Suscripciones
    ADD CONSTRAINT fk_suscripciones_plan
    FOREIGN KEY (id_plan) REFERENCES Planes(id_plan);

-- Tabla Suscripciones: FK hacia Usuarios
ALTER TABLE Suscripciones
    ADD CONSTRAINT fk_suscripciones_usuario
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
    ON DELETE CASCADE;

-- Tabla Pagos: llave primaria
ALTER TABLE Pagos
    ADD CONSTRAINT pk_pagos PRIMARY KEY (id_pago);

-- Tabla Pagos: referencia unica
ALTER TABLE Pagos
    ADD CONSTRAINT uk_pagos_referencia UNIQUE (referencia);

-- Tabla Pagos: FK hacia Suscripciones
ALTER TABLE Pagos
    ADD CONSTRAINT fk_pagos_suscripcion
    FOREIGN KEY (codigo_suscripcion) REFERENCES Suscripciones(codigo);

-- Tabla MetodosPago: llave primaria y FK hacia Pagos
ALTER TABLE MetodosPago
    ADD CONSTRAINT pk_metodospago PRIMARY KEY (id_pago);

ALTER TABLE MetodosPago
    ADD CONSTRAINT fk_metodospago_pago
    FOREIGN KEY (id_pago) REFERENCES Pagos(id_pago);

-- Tabla Notificaciones: llave primaria
ALTER TABLE Notificaciones
    ADD CONSTRAINT pk_notificaciones PRIMARY KEY (id_notificaciones);

-- Tabla Notificaciones: id_pago debe admitir NULL para soportar ON DELETE SET NULL
ALTER TABLE Notificaciones MODIFY id_pago VARCHAR2(32) NULL;

-- Tabla Notificaciones: FK hacia Pagos con SET NULL al eliminar pago
ALTER TABLE Notificaciones
    ADD CONSTRAINT fk_notificaciones_pago
    FOREIGN KEY (id_pago) REFERENCES Pagos(id_pago)
    ON DELETE SET NULL;

-- Restriccion 2: estado suscripcion debe ser inactiva si fecha actual supera fecha_fin
-- Si bien sabemos que esto es una restriccion procedimental, en sql estandar se usa 
-- CREATE ASSERTION usando CHECKS pero ORACLE no lo soporta, decidimos usar una procedimental

CREATE OR REPLACE TRIGGER trg_chk_estado_inactiva
BEFORE INSERT OR UPDATE OF estado, fecha_fin ON Suscripciones
FOR EACH ROW
BEGIN
    IF CURRENT_DATE > :NEW.fecha_fin AND :NEW.estado <> 'inactiva' THEN
        RAISE_APPLICATION_ERROR(-20001,
            'El estado debe ser inactiva cuando la fecha actual supera la fecha fin.');
    END IF;
END;
/

-- Restriccion 3: pagos aprobados no deben tener notificacion asociada
-- Lo mismo que la restricción anterior, se usaría CREATE ASSERTION pero ORACLE no lo soporta.
CREATE OR REPLACE TRIGGER trg_chk_pago_aprobado_sin_noti
BEFORE INSERT OR UPDATE OF id_pago ON Notificaciones
FOR EACH ROW
DECLARE
    v_estado VARCHAR2(10);
BEGIN
    IF :NEW.id_pago IS NOT NULL THEN
        SELECT estado INTO v_estado FROM Pagos WHERE id_pago = :NEW.id_pago;
        IF v_estado = 'aprobado' THEN
            RAISE_APPLICATION_ERROR(-20002,
                'Un pago aprobado no puede tener una notificacion asociada.');
        END IF;
    END IF;
END;
/

-- Restriccion 4: toda suscripcion activa debe tener al menos un pago aprobado
-- Lo mismo que la restricción anterior, se usaría CREATE ASSERTION pero ORACLE no lo soporta.
CREATE OR REPLACE TRIGGER trg_chk_suscripcion_activa_con_pago
BEFORE INSERT OR UPDATE OF estado ON Suscripciones
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    IF :NEW.estado = 'activa' THEN
        SELECT COUNT(*) INTO v_count
        FROM Pagos
        WHERE codigo_suscripcion = :NEW.codigo
          AND estado = 'aprobado';
        IF v_count = 0 THEN
            RAISE_APPLICATION_ERROR(-20003,
                'Una suscripcion activa debe tener al menos un pago aprobado.');
        END IF;
    END IF;
END;
/


--## Tercer punto: Integridad procedimental CRUD Mantener Suscripcion

-- T1: Automatizar codigo, fecha_inicio y estado al insertar suscripcion
CREATE OR REPLACE TRIGGER trg_before_insert_suscripcion
BEFORE INSERT ON Suscripciones
FOR EACH ROW
DECLARE
    v_codigo NUMBER;
BEGIN
    SELECT NVL(MAX(codigo), 0) + 1 INTO v_codigo FROM Suscripciones;
    :NEW.codigo       := v_codigo;
    :NEW.fecha_inicio := CURRENT_DATE;
    :NEW.estado       := 'pendiente';
END;
/

-- T2: Calcular fecha_fin segun duracion del plan
CREATE OR REPLACE TRIGGER trg_fecha_fin_suscripcion
BEFORE INSERT ON Suscripciones
FOR EACH ROW
DECLARE
    v_duracion NUMBER;
BEGIN
    SELECT duracion INTO v_duracion
    FROM Planes WHERE id_plan = :NEW.id_plan;
    :NEW.fecha_fin := :NEW.fecha_inicio + v_duracion;
END;
/

-- T3: Si pago rechazado, crear notificacion automaticamente
CREATE OR REPLACE TRIGGER trg_notificacion_pago_rechazado
AFTER INSERT ON Pagos
FOR EACH ROW
WHEN (NEW.estado = 'rechazado')
DECLARE
    v_id     NUMBER;
    v_correo VARCHAR2(50);
    v_metodo VARCHAR2(20);
BEGIN
    SELECT NVL(MAX(id_notificaciones), 0) + 1 INTO v_id FROM Notificaciones;
    SELECT u.correo INTO v_correo
    FROM Usuarios u
    JOIN Suscripciones s ON s.id_usuario = u.id_usuario
    WHERE s.codigo = :NEW.codigo_suscripcion;

    SELECT metodo_pago INTO v_metodo
    FROM MetodosPago WHERE id_pago = :NEW.id_pago;

    INSERT INTO Notificaciones (id_notificaciones, email_usuario, descripcion, medio_pago_usado, comentario, id_pago)
    VALUES (v_id, v_correo, 'Pago rechazado', v_metodo, 'Pago no procesado', :NEW.id_pago);
END;
/

-- T4: Pago aprobado actualiza suscripcion a activa
CREATE OR REPLACE TRIGGER trg_aprobar_pago
AFTER UPDATE OF estado ON Pagos
FOR EACH ROW
WHEN (NEW.estado = 'aprobado')
BEGIN
    UPDATE Suscripciones
    SET estado = 'activa'
    WHERE codigo = :NEW.codigo_suscripcion;
END;
/

-- T5: Solo permitir cambio de activa a inactiva si CURRENT_DATE > fecha_fin
CREATE OR REPLACE TRIGGER trg_validar_inactivar_suscripciones
BEFORE UPDATE OF estado ON Suscripciones
FOR EACH ROW
WHEN (OLD.estado = 'activa' AND NEW.estado = 'inactiva')
BEGIN
    IF CURRENT_DATE <= :OLD.fecha_fin THEN
        RAISE_APPLICATION_ERROR(-20001, 'Solo se puede inactivar una suscripcion cuando la fecha actual supera la fecha fin.');
    END IF;
END;
/

-- T6: Pago aprobado no debe tener notificacion asociada
CREATE OR REPLACE TRIGGER trg_pago_aprobado_sin_notificacion
BEFORE INSERT OR UPDATE ON Notificaciones
FOR EACH ROW
DECLARE
    v_estado VARCHAR2(10);
BEGIN
    IF :NEW.id_pago IS NOT NULL THEN
        SELECT estado INTO v_estado FROM Pagos WHERE id_pago = :NEW.id_pago;
        IF v_estado = 'aprobado' THEN
            RAISE_APPLICATION_ERROR(-20002, 'Un pago aprobado no puede tener una notificacion asociada.');
        END IF;
    END IF;
END;
/

-- T7: Suscripcion activa debe tener al menos un pago aprobado
CREATE OR REPLACE TRIGGER trg_suscripcion_activa_con_pago
BEFORE UPDATE OF estado ON Suscripciones
FOR EACH ROW
WHEN (NEW.estado = 'activa')
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Pagos
    WHERE codigo_suscripcion = :NEW.codigo
      AND estado = 'aprobado';
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Una suscripcion activa debe tener al menos un pago aprobado.');
    END IF;
END;
/
