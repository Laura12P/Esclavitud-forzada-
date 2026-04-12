-- XTABLAS — ELIMINACIÓN DE TABLAS
DROP TABLE FiltroBusqueda;
DROP TABLE HistorialBusqueda;
DROP TABLE Sancion;
DROP TABLE Reporte;
DROP TABLE ListaNegra;
DROP TABLE ConfiguracionUsuario;
DROP TABLE Recomendacion;
DROP TABLE Historial_Emocion;
DROP TABLE Historial_Periodo;
DROP TABLE Historial_Musical;
DROP TABLE Publicacion_TipoContenido;
DROP TABLE Publicacion;
DROP TABLE UsuarioBasico;
DROP TABLE UsuarioMembresia;
DROP TABLE Usuario_Streaming;
DROP TABLE Usuario;
DROP TABLE Cancion;
DROP TABLE Artista;
DROP TABLE Genero;

-- TABLAS: CREACIÓN DE TABLAS

-- GRAN CONCEPTO: CANCIÓN

CREATE TABLE Genero (
    idGenero        NUMBER(10),
    nombreGenero    VARCHAR(255)    NOT NULL,
    descripcion     VARCHAR(255)    NOT NULL
);

CREATE TABLE Artista (
    idArtista       NUMBER(10),
    nombre          VARCHAR(255)    NOT NULL,
    paisOrigen      VARCHAR(255)    NOT NULL,
    añoDebut        DATE            NOT NULL
);

CREATE TABLE Cancion (
    idCancion       NUMBER(10),
    tituloCancion   VARCHAR(20)     NOT NULL,
    duracion        NUMBER(10)      NOT NULL,
    año             DATE            NOT NULL,
    idArtista       NUMBER(10)      NOT NULL,
    idGenero        NUMBER(10)      NOT NULL
);
-- Relación muchos a muchos
CREATE TABLE Cancion_Genero (
    idCancion       NUMBER(10)      NOT NULL,
    idGenero        NUMBER(10)      NOT NULL
);

-- GRAN CONCEPTO: USUARIO

CREATE TABLE Usuario (
    idUsuario               NUMBER(10),
    nombreUsuario           VARCHAR(255)    NOT NULL,
    correo                  VARCHAR(255)    NOT NULL,
    contraseña              VARCHAR(16)     NOT NULL,
    fechaRegistro           DATE            NOT NULL,
    descripcionPerfil       VARCHAR(100)    
);
-- Atributo con multiplicidad muchos
CREATE TABLE Usuario_Streaming (
    idUsuario               NUMBER(10)      NOT NULL,
    plataformaStreaming      VARCHAR(20)     NOT NULL
);

CREATE TABLE UsuarioBasico (
    idUsuario       NUMBER(10)
);

CREATE TABLE UsuarioMembresia (    
    idUsuario               NUMBER(10),
    fechaInicioMembresia    DATE            NOT NULL,
    fechaFinMembresia       DATE            NULL,
    estadoMembresia         VARCHAR(20)     NOT NULL,
    tipoMembresia           VARCHAR(20)     NOT NULL
);

-- GRAN CONCEPTO: HUELLA MUSICAL

CREATE TABLE Publicacion (
    idPublicacion       NUMBER(10),
    contenido           VARCHAR(255)    NOT NULL,
    fechaPublicacion    DATE            NOT NULL,
    likes               NUMBER(10)      NOT NULL,
    comentarios         NUMBER(10)      NOT NULL,
    idUsuario           NUMBER(10)      NOT NULL,
    idCancionAdjunta    NUMBER(10)      
);

-- Atributo con multiplicidad muchos
CREATE TABLE Publicacion_TipoContenido (
    idPublicacion   NUMBER(10)      NOT NULL,
    tipoContenido   VARCHAR(20)     NOT NULL
);

CREATE TABLE Historial_Musical (
    idRegistro          NUMBER(10),
    fechaRegistro       DATE            NOT NULL,
    notaPersonal        VARCHAR(255),
    emocion             VARCHAR(10)     NOT NULL,
    idCancion           NUMBER(10)      NOT NULL,
    idUsuario           NUMBER(10)      NOT NULL
);

-- Atributo con multiplicidad muchos
CREATE TABLE Historial_Periodo (
    idRegistro      NUMBER(10)      NOT NULL,
    periodo         DATE            NOT NULL
);

-- Atributo con multiplicidad muchos
CREATE TABLE Historial_Emocion (
    idRegistro      NUMBER(10)      NOT NULL,
    emocion         VARCHAR(10)     NOT NULL
);

-- GRAN CONCEPTO: RECOMENDACIÓN

CREATE TABLE Recomendacion (
    idRecomendacion         NUMBER(10),
    fechaRecomendacion      DATE            NOT NULL,
    mensajeRecomendacion    VARCHAR(255)    NOT NULL,
    tipoRecomendacion       VARCHAR(20)     NOT NULL,
    idUsuario               NUMBER(10)      NOT NULL,
    idCancion               NUMBER(10),
    idUsuarioDestino        NUMBER(10)      NOT NULL,
    visualizacion           NUMBER(1)       NOT NULL
);

-- GRAN CONCEPTO: CONFIGURACIÓN & PRIVACIDAD

CREATE TABLE ConfiguracionUsuario (
    idConfiguracion         NUMBER(10),
    perfilPublico           NUMBER(1)       NOT NULL,
    quienPuedeSeguir        VARCHAR2(15)    NOT NULL,
    quienVeHistorial        VARCHAR2(15)    NOT NULL,
    quienVePublicaciones    VARCHAR2(15)    NOT NULL,
    notificacionesActivas   NUMBER(1)       NOT NULL,
    idUsuario               NUMBER(10)      NOT NULL
);

CREATE TABLE ListaNegra (
    idBloqueo           NUMBER(10),
    idUsuarioOrigen     NUMBER(10)      NOT NULL,
    idUsuarioDestino    NUMBER(10)      NOT NULL,
    fechaBloqueo        DATE            NOT NULL,
    motivoBloqueo       VARCHAR(255)    
);

-- GRAN CONCEPTO: MODERACIÓN & REPORTE

CREATE TABLE Reporte (
    idReporte               NUMBER(10),
    idUsuarioReportante     NUMBER(10)      NOT NULL,
    idUsuarioReportado      NUMBER(10)      NOT NULL,
    motivoReporte           VARCHAR(30)     NOT NULL,
    descripcionReporte      VARCHAR(255),
    fechaReporte            DATE            NOT NULL,
    estadoReporte           VARCHAR(20)     NOT NULL
);

CREATE TABLE Sancion (
    idSancion           NUMBER(10),
    tipoSancion         VARCHAR(25)     NOT NULL,
    fechaInicio         DATE            NOT NULL,
    fechaFin            DATE,
    motivoSancion       VARCHAR(255)    NOT NULL,
    idReporte           NUMBER(10)      NOT NULL,
    idUsuario           NUMBER(10)      NOT NULL
);

--  GRAN CONCEPTO: BÚSQUEDA & DESCUBRIMIENTO

CREATE TABLE HistorialBusqueda (
    idBusqueda          NUMBER(10),
    terminoBusqueda     VARCHAR(255)    NOT NULL,
    fechaBusqueda       DATE            NOT NULL,
    idUsuario           NUMBER(10)      NOT NULL
);

CREATE TABLE FiltroBusqueda (
    idFiltro            NUMBER(10),
    fechaUso            DATE            NOT NULL,
    exito               NUMBER(1)       NOT NULL,
    periodo             DATE,
    idGenero            NUMBER(10),
    idArtista           NUMBER(10),
    idRegistro          NUMBER(10),
    idBusqueda          NUMBER(10)      NOT NULL
);

---------------------------PK & UK LLAVES-------------------------------------

--------------- GRAN CONCEPTO: CANCION ----------------------------------

ALTER TABLE Genero
    ADD CONSTRAINT pk_genero PRIMARY KEY (idGenero);

ALTER TABLE Artista
    ADD CONSTRAINT pk_artista PRIMARY KEY (idArtista);

ALTER TABLE Cancion
    ADD CONSTRAINT pk_cancion PRIMARY KEY(idCancion);

--------------- GRAN CONCEPTO: USUARIO ----------------------------------

ALTER TABLE Usuario    
    ADD CONSTRAINT uk_nombreUsuario_Usuario UNIQUE (nombreUsuario)
    ADD CONSTRAINT uk_correo_Usuario UNIQUE (correo)
    ADD CONSTRAINT pk_usuario PRIMARY KEY (idUsuario);

ALTER TABLE Usuario_Streaming
    ADD CONSTRAINT pk_Usuario_Streaming PRIMARY KEY (idUsuario, plataformaStreaming);

ALTER TABLE UsuarioBasico
    ADD CONSTRAINT pk_usuario_basico PRIMARY KEY (idUsuario);

ALTER TABLE UsuarioMembresia
    ADD CONSTRAINT pk_Usuario_Membresia PRIMARY KEY (idUsuario);

--------------- GRAN CONCEPTO: HUELLA MUSICAL ----------------------------------

ALTER TABLE Publicacion
    ADD CONSTRAINT pk_publicacion PRIMARY KEY (idPublicacion);

ALTER TABLE Publicacion_TipoContenido
    ADD CONSTRAINT pk_Publicacion_TipoContenido PRIMARY KEY (idPublicacion, tipoContenido);

ALTER TABLE Historial_Musical  
    ADD CONSTRAINT pk_historial_musical PRIMARY KEY (idRegistro);

ALTER TABLE Historial_Periodo
    ADD CONSTRAINT pk_Historial_Periodo PRIMARY KEY (idRegistro, periodo);

ALTER TABLE Historial_Emocion
    ADD CONSTRAINT pk_historial_emocion PRIMARY KEY (idRegistro, emocion);

--------------- GRAN CONCEPTO: RECOMENDACION ----------------------------------

ALTER TABLE Recomendacion
    ADD CONSTRAINT pk_recomendacion PRIMARY KEY (idRecomendacion);

--------------- GRAN CONCEPTO: CONFIGURACION & PRIVACIDAD ----------------------------------

ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT pk_configuracion_usuario PRIMARY KEY (idConfiguracion, idUsuario);

ALTER TABLE ListaNegra  
    ADD CONSTRAINT pk_lista_negra PRIMARY KEY (idBloqueo);

--------------- GRAN CONCEPTO: MODERACION & REPORTE ----------------------------------

ALTER TABLE Reporte
    ADD CONSTRAINT pk_reporte PRIMARY KEY (idReporte);

ALTER TABLE Sancion
    ADD CONSTRAINT pk_sancion PRIMARY KEY (idSancion);

--------------- GRAN CONCEPTO: BUSQUEDA & DESCUBRIMIENTO ----------------------------------

ALTER TABLE HistorialBusqueda
    ADD CONSTRAINT pk_hisorialBusqueda PRIMARY KEY (idBusqueda);

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT pk_FiltroBusqueda PRIMARY KEY (idFiltro, idBusqueda);

---------------------------FK LLAVES-------------------------------------


--------------- GRAN CONCEPTO: CANCION ----------------------------------

ALTER TABLE Cancion
    ADD CONSTRAINT fk_Cancion_Artista FOREIGN KEY (idArtista) REFERENCES Artista(idArtista)
    ADD CONSTRAINT fk_Cancion_Genero FOREIGN KEY (idGenero) REFERENCES Genero(idGenero);

--------------- GRAN CONCEPTO: USUARIO ----------------------------------

ALTER TABLE Usuario_Streaming
    ADD CONSTRAINT fk_US_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

ALTER TABLE UsuarioBasico
    ADD CONSTRAINT fk_UsuarioBasico FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

ALTER TABLE UsuarioMembresia
    ADD CONSTRAINT fk_UsuarioMembresia FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);


--------------- GRAN CONCEPTO: HUELLA MUSICAL ----------------------------------
ALTER TABLE Publicacion
    ADD CONSTRAINT fk_Publicacion_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

ALTER TABLE Publicacion
    ADD CONSTRAINT fk_Publicacion_Cancion FOREIGN KEY (idCancionAdjunta) REFERENCES Cancion(idCancion);

ALTER TABLE Publicacion_TipoContenido
    ADD CONSTRAINT fk_PTC_Publicacion FOREIGN KEY (idPublicacion) REFERENCES Publicacion(idPublicacion);

ALTER TABLE Historial_Musical
    ADD CONSTRAINT fk_HM_Cancion FOREIGN KEY (idCancion) REFERENCES Cancion(idCancion);

ALTER TABLE Historial_Musical
    ADD CONSTRAINT fk_HM_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

-- Historial_Periodo
ALTER TABLE Historial_Periodo
    ADD CONSTRAINT fk_HP_Historial FOREIGN KEY (idRegistro) REFERENCES Historial_Musical(idRegistro);

-- Historial_Emocion
ALTER TABLE Historial_Emocion
    ADD CONSTRAINT fk_HE_Historial FOREIGN KEY (idRegistro) REFERENCES Historial_Musical(idRegistro);

--------------- GRAN CONCEPTO: RECOMENDACION ----------------------------------
ALTER TABLE Recomendacion
    ADD CONSTRAINT fk_Reco_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

ALTER TABLE Recomendacion
    ADD CONSTRAINT fk_Reco_Cancion FOREIGN KEY (idCancion) REFERENCES Cancion(idCancion);

-- Configuración & Privacidad
ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT fk_Config_Usuario  FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

ALTER TABLE ListaNegra
    ADD CONSTRAINT fk_LN_Origen FOREIGN KEY (idUsuarioOrigen) REFERENCES Usuario(idUsuario);

ALTER TABLE ListaNegra
    ADD CONSTRAINT fk_LN_Destino FOREIGN KEY (idUsuarioDestino) REFERENCES Usuario(idUsuario);

--------------- GRAN CONCEPTO: CONFIGURACION & PRIVACIDAD ----------------------------------
ALTER TABLE Reporte
    ADD CONSTRAINT fk_Reporte_Reportante FOREIGN KEY (idUsuarioReportante) REFERENCES Usuario(idUsuario);

ALTER TABLE Reporte
    ADD CONSTRAINT fk_Reporte_Reportado FOREIGN KEY (idUsuarioReportado) REFERENCES Usuario(idUsuario);

ALTER TABLE Sancion
    ADD CONSTRAINT fk_Sancion_Reporte FOREIGN KEY (idReporte) REFERENCES Reporte(idReporte);

ALTER TABLE Sancion
    ADD CONSTRAINT fk_Sancion_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

--------------- GRAN CONCEPTO: BUSQUEDA & DESCUBRIMIENTO ----------------------------------
ALTER TABLE HistorialBusqueda
    ADD CONSTRAINT fk_HB_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Genero FOREIGN KEY (idGenero) REFERENCES Genero(idGenero);

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Artista FOREIGN KEY (idArtista) REFERENCES Artista(idArtista);

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Historial FOREIGN KEY (idRegistro) REFERENCES Historial_Musical(idRegistro);

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Busqueda FOREIGN KEY (idBusqueda) REFERENCES HistorialBusqueda(idBusqueda);

-------------------------------------------------------------------------------------------------------
--------------------------------- Consultas -----------------------------------------------------------
-------------------------------------------------------------------------------------------------------

-- 1. Usuarios que escucharon canciones del artista (últimos 30 días)
SELECT c.tituloCancion, COUNT(h.idRegistro) AS reproducciones, COUNT(DISTINCT h.idUsuario) AS total_oyentes
FROM Cancion c
JOIN Historial_Musical h ON c.idCancion = h.idCancion
WHERE c.idArtista = :idArtista
AND h.fechaRegistro >= SYSDATE - 30
GROUP BY c.tituloCancion
ORDER BY total_oyentes DESC;

-- 2. Artistas más escuchados del último mes
SELECT a.nombre, g.nombreGenero, COUNT(h.idRegistro) AS total_reproducciones
FROM Artista a
JOIN Cancion c ON a.idArtista = c.idArtista
JOIN Historial_Musical h ON c.idCancion = h.idCancion
JOIN Genero g ON c.idGenero = g.idGenero
WHERE h.fechaRegistro >= ADD_MONTHS(SYSDATE, -1) -- Acá la funcion regresaria la fecha con la cantidad de meses agregados, pero le quitamos uno para que la consulta de.
GROUP BY a.nombre, g.nombreGenero
ORDER BY total_reproducciones DESC;

-- 3. Usuarios que más escuchan al artista
SELECT u.nombreUsuario, COUNT(h.idRegistro) AS veces_escuchado
FROM Usuario u
JOIN Historial_Musical h ON u.idUsuario = h.idUsuario
JOIN Cancion c ON h.idCancion = c.idCancion
WHERE c.idArtista = :idArtista
GROUP BY u.nombreUsuario
ORDER BY veces_escuchado DESC;

-- 4. Historial de búsquedas último mes
SELECT hb.terminoBusqueda, hb.fechaBusqueda, fb.exito
FROM HistorialBusqueda hb
JOIN FiltroBusqueda fb ON hb.idBusqueda = fb.idBusqueda
WHERE hb.fechaBusqueda >= SYSDATE - 30
ORDER BY hb.fechaBusqueda DESC;

-- 5. Búsquedas fallidas
SELECT hb.terminoBusqueda, COUNT(*) AS intentos_fallidos, MAX(hb.fechaBusqueda) AS ultimo_intento
FROM HistorialBusqueda hb
JOIN FiltroBusqueda fb ON hb.idBusqueda = fb.idBusqueda
WHERE fb.exito = 0
GROUP BY hb.terminoBusqueda
ORDER BY intentos_fallidos DESC;

-- 6. Reportes último mes
SELECT u.nombreUsuario, r.motivoReporte, r.descripcionReporte, r.estadoReporte, r.fechaReporte
FROM Reporte r
JOIN Usuario u ON r.idUsuarioReportado = u.idUsuario
WHERE r.fechaReporte >= SYSDATE - 30
ORDER BY r.fechaReporte DESC;

-- 7. Sanciones activas
SELECT tipoSancion, motivoSancion, fechaInicio, fechaFin
FROM Sancion
WHERE fechaFin > SYSDATE OR fechaFin IS NULL
ORDER BY fechaInicio DESC;

-- 8. Usuarios con más reportes
SELECT u.nombreUsuario, COUNT(r.idReporte) AS total_reportes
FROM Usuario u
JOIN Reporte r ON u.idUsuario = r.idUsuarioReportado
GROUP BY u.nombreUsuario
ORDER BY total_reportes DESC;

-- 9. Publicaciones con más likes
SELECT p.contenido, ptc.tipoContenido, p.likes, p.comentarios
FROM Publicacion p
LEFT JOIN Publicacion_TipoContenido ptc 
    ON p.idPublicacion = ptc.idPublicacion
WHERE p.idUsuario = :idUsuario AND p.fechaPublicacion >= SYSDATE - 30
ORDER BY p.likes DESC;

-- 10. Historial musical
SELECT notaPersonal, emocion, fechaRegistro
FROM Historial_Musical
WHERE idUsuario = :idUsuario AND fechaRegistro >= SYSDATE - 30
ORDER BY fechaRegistro DESC;

-- 11. Cantidad de publicaciones
SELECT COUNT(*) AS total_publicaciones, MAX(fechaPublicacion) AS ultima_publicacion
FROM Publicacion
WHERE idUsuario = :idUsuario
AND fechaPublicacion BETWEEN :fechaInicio AND :fechaFin;

-- 12. Usuarios bloqueados
SELECT u.nombreUsuario, ln.fechaBloqueo, ln.motivoBloqueo
FROM ListaNegra ln
JOIN Usuario u ON ln.idUsuarioDestino = u.idUsuario
WHERE ln.idUsuarioOrigen = :idUsuario
ORDER BY ln.fechaBloqueo DESC;

-- 13. Configuración usuario
SELECT quienVeHistorial, perfilPublico, notificacionesActivas
FROM ConfiguracionUsuario
WHERE idUsuario = :idUsuario;

-- 14. Veces bloqueado
SELECT COUNT(*) AS veces_bloqueado, MAX(fechaBloqueo) AS ultimo_bloqueo
FROM ListaNegra
WHERE idUsuarioDestino = :idUsuario;

-- 15. Recomendaciones recibidas
SELECT mensajeRecomendacion, tipoRecomendacion, fechaRecomendacion
FROM Recomendacion
WHERE idUsuarioDestino = :idUsuario AND fechaRecomendacion >= SYSDATE - 30
ORDER BY fechaRecomendacion DESC;

-- 16. Recomendaciones por tipo
SELECT tipoRecomendacion, COUNT(*) AS total
FROM Recomendacion
WHERE idUsuarioDestino = :idUsuario
GROUP BY tipoRecomendacion;

-- 17. Quién más recomienda
SELECT u.nombreUsuario, COUNT(*) AS total_recomendaciones, MAX(r.fechaRecomendacion) AS ultima_fecha
FROM Recomendacion r
JOIN Usuario u ON r.idUsuario = u.idUsuario
WHERE r.idUsuarioDestino = :idUsuario
GROUP BY u.nombreUsuario
ORDER BY total_recomendaciones DESC;
----------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------RESTRICCIONES DECLARATIVAS------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
-- Usuario_Streaming
ALTER TABLE Usuario_Streaming
    ADD CONSTRAINT ck_US_streaming          
    CHECK (plataformaStreaming IN ('spotify', 'apple_music', 'youtube_music', 'deezer', 'tidal'));

-- UsuarioMembresia
ALTER TABLE UsuarioMembresia
    ADD CONSTRAINT ck_UM_estado             
    CHECK (estadoMembresia  IN ('activa', 'inactiva', 'suspendida'));

ALTER TABLE UsuarioMembresia
    ADD CONSTRAINT ck_UM_tipo               
    CHECK (tipoMembresia IN ('basica', 'premium', 'familia'));

-- Publicacion_TipoContenido
ALTER TABLE Publicacion_TipoContenido
    ADD CONSTRAINT ck_PTC_tipo              
    CHECK (tipoContenido IN ('cancion', 'album', 'artista', 'playlist'));

-- Recomendacion
ALTER TABLE Recomendacion
    ADD CONSTRAINT ck_Recomendacion_tipo    
    CHECK (tipoRecomendacion IN ('directa', 'comunidad', 'publica'));

ALTER TABLE Recomendacion
    ADD CONSTRAINT ck_recomendacion_visualizacion
    CHECK (visualizacion in ('0', '1'));

--  ConfiguracionUsuario
ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT ck_Config_seguir        
    CHECK (quienPuedeSeguir IN ('todos', 'seguidores', 'nadie'));

ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT ck_Config_historial      
    CHECK (quienVeHistorial IN ('todos', 'seguidores', 'nadie'));

ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT ck_Config_publicaciones  
    CHECK (quienVePublicaciones IN ('todos', 'seguidores', 'nadie'));

ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT ck_Config_perfilPublico  
    CHECK (perfilPublico IN (0, 1));

ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT ck_Config_notificaciones 
    CHECK (notificacionesActivas IN (0, 1));

--  Reporte
ALTER TABLE Reporte
    ADD CONSTRAINT ck_Reporte_motivo        
    CHECK (motivoReporte IN ('spam', 'contenido_inapropiado', 'acoso', 'derechos_autor', 'otro'));

ALTER TABLE Reporte
    ADD CONSTRAINT ck_Reporte_estado        
    CHECK (estadoReporte IN ('pendiente', 'revisado', 'resuelto', 'descartado'));

-- Sancion
ALTER TABLE Sancion
    ADD CONSTRAINT ck_Sancion_tipo          
    CHECK (tipoSancion IN ('advertencia', 'suspension_temporal', 'ban_permanente'));

-- FiltroBusqueda
ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT ck_FB_exito              
    CHECK (exito IN (0, 1));

----------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------RESTRICCIONES PROCEDIMENTALES (TRIGGERS)----------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------
-------------------- MANTENER CATÁLOGO CANCIONES -----------------
------------------------------------------------------------------

-- idCancion incremental automático, año no puede ser futuro
CREATE OR REPLACE TRIGGER trg_cancion_insert
BEFORE INSERT ON Cancion
FOR EACH ROW
BEGIN
    SELECT MAX(idCancion) + 1 INTO :NEW.idCancion FROM Cancion;

    IF EXTRACT(YEAR FROM :NEW.año) > EXTRACT(YEAR FROM SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20001,'Año no puede ser futuro');
    END IF;
END;
/

-- regla3: no modificar id ni artista
CREATE OR REPLACE TRIGGER trg_cancion_update
BEFORE UPDATE ON Cancion
FOR EACH ROW
BEGIN
    IF :NEW.idCancion <> :OLD.idCancion THEN
        RAISE_APPLICATION_ERROR(-20002,'No modificar idCancion');
    END IF;

    IF :NEW.idArtista <> :OLD.idArtista THEN
        RAISE_APPLICATION_ERROR(-20003,'No modificar artista');
    END IF;
END;
/

------------------------------------------------------------------
-------------------- REGISTRAR RECOMENDACIÓN ---------------------
------------------------------------------------------------------

-- id automático, fecha automática, no auto recomendación
CREATE OR REPLACE TRIGGER trg_reco_insert
BEFORE INSERT ON Recomendacion
FOR EACH ROW
BEGIN
    SELECT NVL(MAX(idRecomendacion),0)+1 INTO :NEW.idRecomendacion FROM Recomendacion;

    :NEW.fechaRecomendacion := SYSDATE;
    :NEW.visualizacion := 0;

    IF :NEW.idUsuario = :NEW.idUsuarioDestino THEN
        RAISE_APPLICATION_ERROR(-20004,'No auto recomendación');
    END IF;
END;
/

-- no modificar destinatario ni canción
CREATE OR REPLACE TRIGGER trg_reco_update
BEFORE UPDATE ON Recomendacion
FOR EACH ROW
BEGIN
    IF :NEW.idUsuarioDestino <> :OLD.idUsuarioDestino OR:NEW.idCancion <> :OLD.idCancion THEN
        RAISE_APPLICATION_ERROR(-20005,'No modificar destinatario o canción');
    END IF;
END;
/

-- no eliminar si visualizada
CREATE OR REPLACE TRIGGER trg_reco_delete
BEFORE DELETE ON Recomendacion
FOR EACH ROW
BEGIN
    IF :OLD.visualizacion = 1 THEN
        RAISE_APPLICATION_ERROR(-20006,'No eliminar recomendación vista');
    END IF;
END;
/

------------------------------------------------------------------
-------------------- MANTENER PUBLICACIÓN ------------------------
------------------------------------------------------------------

-- id automático, fecha automática, likes en 0, contenido obligatorio
CREATE OR REPLACE TRIGGER trg_pub_insert
BEFORE INSERT ON Publicacion
FOR EACH ROW
BEGIN
    SELECT NVL(MAX(idPublicacion),0)+1 INTO :NEW.idPublicacion FROM Publicacion;

    :NEW.fechaPublicacion := SYSDATE;
    :NEW.likes := 0;

    IF (:NEW.contenido IS NULL OR TRIM(:NEW.contenido) = '')
        AND :NEW.idCancionAdjunta IS NULL THEN
        RAISE_APPLICATION_ERROR(-20007,'Debe tener contenido o canción');
    END IF;
END;
/

-- no modificar canción adjunta
CREATE OR REPLACE TRIGGER trg_pub_update
BEFORE UPDATE ON Publicacion
FOR EACH ROW
BEGIN
    IF :NEW.idCancionAdjunta <> :OLD.idCancionAdjunta THEN
        RAISE_APPLICATION_ERROR(-20008,'No modificar canción adjunta');
    END IF;
END;
/

------------------------------------------------------------------------------
-------------------- MANTENER PERFIL DE USUARIO ------------------------------
------------------------------------------------------------------------------

-- d automático, fecha automática, contraseña segura, usuario sin espacios
CREATE OR REPLACE TRIGGER trg_usuario_insert
BEFORE INSERT ON Usuario
FOR EACH ROW
BEGIN
    SELECT NVL(MAX(idUsuario),0)+1 INTO :NEW.idUsuario FROM Usuario;

    :NEW.fechaRegistro := SYSDATE;

    IF LENGTH(:NEW.contraseña) < 8 THEN
        RAISE_APPLICATION_ERROR(-20009,'Contraseña insegura');
    END IF;

    IF INSTR(:NEW.nombreUsuario,' ') > 0 THEN
        RAISE_APPLICATION_ERROR(-20010,'Usuario no puede tener espacios');
    END IF;
END;
/

-----------------------------------------------------------------------------------
-------------------- MANTENER BÚSQUEDAS USUARIO -----------------------------------
-----------------------------------------------------------------------------------

-- idFiltro automático, fecha no futura
CREATE OR REPLACE TRIGGER trg_filtro_insert
BEFORE INSERT ON FiltroBusqueda
FOR EACH ROW
BEGIN
    SELECT NVL(MAX(idFiltro),0)+1 INTO :NEW.idFiltro FROM FiltroBusqueda;

    IF :NEW.fechaUso > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20011,'Fecha inválida');
    END IF;
END;
/

--  no modificar ids ni fechas
CREATE OR REPLACE TRIGGER trg_filtro_update
BEFORE UPDATE ON FiltroBusqueda
FOR EACH ROW
BEGIN
    IF :NEW.idFiltro <> :OLD.idFiltro OR
       :NEW.fechaUso <> :OLD.fechaUso THEN
        RAISE_APPLICATION_ERROR(-20012,'No modificar id o fecha');
    END IF;
END;
/

-- no eliminar si exito = 1
CREATE OR REPLACE TRIGGER trg_filtro_delete
BEFORE DELETE ON FiltroBusqueda
FOR EACH ROW
BEGIN
    IF :OLD.exito = 1 THEN
        RAISE_APPLICATION_ERROR(-20013,'No eliminar filtro exitoso');
    END IF;
END;
/

-----------------------------------------------------------------------------
---------------------CONFIGURACIÓN DE USUARIO -------------------------------
-----------------------------------------------------------------------------

-- id automático
CREATE OR REPLACE TRIGGER trg_config_insert
BEFORE INSERT ON ConfiguracionUsuario
FOR EACH ROW
BEGIN
    SELECT NVL(MAX(idConfiguracion),0) +1 INTO :NEW.idConfiguracion FROM ConfiguracionUsuario;
END;
/

-- no modificar lista negra
CREATE OR REPLACE TRIGGER trg_lista_negra_update
BEFORE UPDATE ON ListaNegra
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20014,'No modificar bloqueos');
END;
/

-------------------------------------------------------------------------------
---------------------- MANTENER REPORTES Y SANCIONES --------------------------
-------------------------------------------------------------------------------

-- id reporte automático
CREATE OR REPLACE TRIGGER trg_reporte_insert
BEFORE INSERT ON Reporte
FOR EACH ROW
BEGIN
    SELECT NVL(MAX(idReporte),0)+1 INTO :NEW.idReporte FROM Reporte;
END;
/

-- id sanción automático
CREATE OR REPLACE TRIGGER trg_sancion_insert
BEFORE INSERT ON Sancion
FOR EACH ROW
BEGIN
    SELECT NVL(MAX(idSancion),0)+1 INTO :NEW.idSancion FROM Sancion;
END;
/

-- no eliminar reporte con sanción
CREATE OR REPLACE TRIGGER trg_reporte_delete
BEFORE DELETE ON Reporte
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Sancion WHERE idReporte = :OLD.idReporte;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20015,'Reporte tiene sanción');
    END IF;
END;
/

--  eliminar sanción solo si vencida
CREATE OR REPLACE TRIGGER trg_sancion_delete
BEFORE DELETE ON Sancion
FOR EACH ROW
BEGIN
    IF :OLD.fechaFin IS NULL OR :OLD.fechaFin > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20016,'Sanción no vencida');
    END IF;
END;
/
------------------------------------------------------------------
-------------------- XDISPARADORES -------------------------------
------------------------------------------------------------------

DROP TRIGGER trg_cancion_insert;
DROP TRIGGER trg_cancion_update;
DROP TRIGGER trg_reco_insert;
DROP TRIGGER trg_reco_update;
DROP TRIGGER trg_reco_delete;
DROP TRIGGER trg_pub_insert;
DROP TRIGGER trg_pub_update;
DROP TRIGGER trg_usuario_insert;
DROP TRIGGER trg_filtro_insert;
DROP TRIGGER trg_filtro_update;
DROP TRIGGER trg_filtro_delete;
DROP TRIGGER trg_config_insert;
DROP TRIGGER trg_lista_negra_update;
DROP TRIGGER trg_reporte_insert;
DROP TRIGGER trg_sancion_insert;
DROP TRIGGER trg_reporte_delete;
DROP TRIGGER trg_sancion_delete;
