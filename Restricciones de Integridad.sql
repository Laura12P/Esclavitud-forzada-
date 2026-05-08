----------------------------------------------------------------------------------------------------------
------------------------------------------ RESTRICCIONES DECLARATIVAS ------------------------------------
----------------------------------------------------------------------------------------------------------

-- Usuario_Streaming
ALTER TABLE Usuario_Streaming
    ADD CONSTRAINT ck_US_streaming CHECK (plataformaStreaming IN ('spotify', 'apple_music', 'youtube_music', 'deezer', 'tidal'));

-- UsuarioMembresia
ALTER TABLE UsuarioMembresia
    ADD CONSTRAINT ck_UM_estado CHECK (estadoMembresia  IN ('activa', 'inactiva', 'suspendida'));

ALTER TABLE UsuarioMembresia
    ADD CONSTRAINT ck_UM_tipo CHECK (tipoMembresia IN ('basica', 'premium', 'familia'));

-- Publicacion_TipoContenido
ALTER TABLE Publicacion_TipoContenido
    ADD CONSTRAINT ck_PTC_tipo CHECK (tipoContenido IN ('cancion', 'album', 'artista', 'playlist'));

-- Recomendacion
ALTER TABLE Recomendacion
    ADD CONSTRAINT ck_Recomendacion_tipo CHECK (tipoRecomendacion IN ('directa', 'comunidad', 'publica'));

ALTER TABLE Recomendacion
    ADD CONSTRAINT ck_recomendacion_visualizacion CHECK (visualizacion in ('0', '1'));

--  ConfiguracionUsuario
ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT ck_Config_seguir CHECK (quienPuedeSeguir IN ('todos', 'seguidores', 'nadie'));

ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT ck_Config_historial CHECK (quienVeHistorial IN ('todos', 'seguidores', 'nadie'));

ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT ck_Config_publicaciones CHECK (quienVePublicaciones IN ('todos', 'seguidores', 'nadie'));

ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT ck_Config_perfilPublico CHECK (perfilPublico IN (0, 1));

ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT ck_Config_notificaciones CHECK (notificacionesActivas IN (0, 1));

--  Reporte
ALTER TABLE Reporte
    ADD CONSTRAINT ck_Reporte_motivo        
    CHECK (motivoReporte IN ('spam', 'contenido_inapropiado', 'acoso', 'derechos_autor', 'otro'));

ALTER TABLE Reporte
    ADD CONSTRAINT ck_Reporte_estado CHECK (estadoReporte IN ('pendiente', 'revisado', 'resuelto', 'descartado'));

-- Sancion
ALTER TABLE Sancion
    ADD CONSTRAINT ck_Sancion_tipo CHECK (tipoSancion IN ('advertencia', 'suspension_temporal', 'ban_permanente'));

-- FiltroBusqueda
ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT ck_FB_exito CHECK (exito IN (0, 1));

----------------------------------------------------------------------------------------------
-------------------------------------- TuplasOK --------------------------------------------
----------------------------------------------------------------------------------------------

----- Gran Concepto: Usuarios

INSERT INTO Usuario_Streaming VALUES (1, 'deezer');  
INSERT INTO Usuario_Streaming VALUES (2, 'tidal');       
INSERT INTO Usuario_Streaming VALUES (3, 'spotify');        
 
INSERT INTO UsuarioMembresia VALUES (3, TO_DATE('2024-06-01','YYYY-MM-DD'), NULL, 'activa', 'basica');
UPDATE UsuarioMembresia SET estadoMembresia = 'suspendida' WHERE idUsuario = 2;
UPDATE UsuarioMembresia SET estadoMembresia = 'inactiva'  WHERE idUsuario = 2;
UPDATE UsuarioMembresia SET tipoMembresia   = 'premium'   WHERE idUsuario = 4;
UPDATE UsuarioMembresia SET tipoMembresia   = 'familia'   WHERE idUsuario = 3;
 
-- GRAN CONCEPTO: HUELLA MUSICAL

INSERT INTO Publicacion_TipoContenido VALUES (1, 'album');      
INSERT INTO Publicacion_TipoContenido VALUES (2, 'artista');     
INSERT INTO Publicacion_TipoContenido VALUES (3, 'playlist');  
INSERT INTO Publicacion_TipoContenido VALUES (4, 'cancion');   
 
-- GRAN CONCEPTO: RECOMENDACIÓN

INSERT INTO Recomendacion VALUES (10, SYSDATE, 'Recomendacion directa', 'directa',   1, 2, 3, 0);
INSERT INTO Recomendacion VALUES (11, SYSDATE, 'Recomendacion comunidad', 'comunidad', 2, 3, 4, 0);
INSERT INTO Recomendacion VALUES (12, SYSDATE, 'Recomendacion publica', 'publica',   3, 4, 5, 0);
INSERT INTO Recomendacion VALUES (13, SYSDATE, 'Ya fue visualizada', 'directa',   4, 5, 1, 1);
 
--- GRAN CONCEPTO: CONFIGURACIÓN & PRIVACIDAD

UPDATE ConfiguracionUsuario SET quienPuedeSeguir = 'nadie', perfilPublico = 0 WHERE idUsuario = 1;
UPDATE ConfiguracionUsuario SET quienVeHistorial = 'todos', notificacionesActivas = 1 WHERE idUsuario = 2;
UPDATE ConfiguracionUsuario SET quienVePublicaciones = 'nadie', perfilPublico = 1 WHERE idUsuario = 3;
 
-- GRAN CONCEPTO: MODERACIÓN & REPORTE

INSERT INTO Reporte VALUES (10, 2, 3, 'spam', 'Mensajes repetidos',  SYSDATE, 'pendiente');
INSERT INTO Reporte VALUES (11, 3, 5, 'contenido_inapropiado','Foto de perfil', SYSDATE, 'revisado');
INSERT INTO Reporte VALUES (12, 1, 4, 'acoso', 'Comentarios agresivos',SYSDATE, 'resuelto');
INSERT INTO Reporte VALUES (13, 4, 2, 'derechos_autor', 'Subio cancion ajena', SYSDATE, 'descartado');
INSERT INTO Reporte VALUES (14, 5, 1, 'otro', 'Conducta rara', SYSDATE, 'pendiente');

INSERT INTO Sancion VALUES (10, 'advertencia', SYSDATE, TO_DATE('2024-12-01','YYYY-MM-DD'), 'Aviso por spam', 10, 3);
INSERT INTO Sancion VALUES (11, 'suspension_temporal', SYSDATE, TO_DATE('2025-01-01','YYYY-MM-DD'), 'Contenido inapropiado', 11, 5);
INSERT INTO Sancion VALUES (12, 'ban_permanente', SYSDATE, NULL, 'Acoso reiterado severo',      12, 4);
 
-- GRAN CONCEPTO: BÚSQUEDA & DESCUBRIMIENTO

INSERT INTO HistorialBusqueda VALUES (10, 'busqueda exitosa',   SYSDATE, 1);
INSERT INTO HistorialBusqueda VALUES (11, 'busqueda fallida',   SYSDATE, 2);
 
INSERT INTO FiltroBusqueda VALUES (10, SYSDATE, 1, NULL, 1, NULL, NULL, 10); 
INSERT INTO FiltroBusqueda VALUES (11, SYSDATE, 0, NULL, NULL, 2, NULL, 11);  

----------------------------------------------------------------------------------------------
-------------------------------------- TuplasNoOK --------------------------------------------
----------------------------------------------------------------------------------------------

----- Gran Concepto: Usuarios

-- Plataforma no contemplada
INSERT INTO Usuario_Streaming VALUES (1, 'soundcloud');
 
-- Plataforma válida pero en mayúscula (Oracle CHECK es sensible a mayúsculas)
INSERT INTO Usuario_Streaming VALUES (2, 'Spotify');
 
-- Plataforma inexistente
INSERT INTO Usuario_Streaming VALUES (3, 'amazon_music');
 
-- Valor vacío
INSERT INTO Usuario_Streaming VALUES (4, '');
 
-- Estado no contemplado
INSERT INTO UsuarioMembresia VALUES (3, SYSDATE, NULL, 'cancelada', 'basica');
 
-- En mayúscula
INSERT INTO UsuarioMembresia VALUES (3, SYSDATE, NULL, 'Activa', 'basica');
 
-- Valor inventado
INSERT INTO UsuarioMembresia VALUES (3, SYSDATE, NULL, 'bloqueada', 'basica');
 
-- Tipo no contemplado
INSERT INTO UsuarioMembresia VALUES (3, SYSDATE, NULL, 'activa', 'estudiante');
 
-- En mayúscula
INSERT INTO UsuarioMembresia VALUES (3, SYSDATE, NULL, 'activa', 'Premium');
 
-- Valor inventado
INSERT INTO UsuarioMembresia VALUES (3, SYSDATE, NULL, 'activa', 'estandar');
 
-- GRAN CONCEPTO: HUELLA MUSICAL

-- Tipo no contemplado
INSERT INTO Publicacion_TipoContenido VALUES (2, 'podcast');
 
-- Tipo no contemplado
INSERT INTO Publicacion_TipoContenido VALUES (3, 'video');
 
-- En mayúscula
INSERT INTO Publicacion_TipoContenido VALUES (4, 'Cancion');
 
-- Valor inventado
INSERT INTO Publicacion_TipoContenido VALUES (5, 'story');
 
-- GRAN CONCEPTO: RECOMENDACIÓN

-- Tipo no contemplado
INSERT INTO Recomendacion VALUES (20, SYSDATE, 'Test privada', 'privada', 1, 1, 2, 0);
 
-- En mayúscula
INSERT INTO Recomendacion VALUES (21, SYSDATE, 'Test Directa', 'Directa', 1, 1, 2, 0);
 
-- Valor inventado
INSERT INTO Recomendacion VALUES (22, SYSDATE, 'Test abierta', 'abierta', 2, 2, 3, 0);
 
-- Valor fuera de rango
INSERT INTO Recomendacion VALUES (23, SYSDATE, 'Vis invalida', 'directa', 1, 1, 2, 2);
 
-- Valor negativo
INSERT INTO Recomendacion VALUES (24, SYSDATE, 'Vis negativa', 'directa', 1, 1, 2, -1);
 
-- GRAN CONCEPTO: CONFIGURACIÓN & PRIVACIDAD

-- quienPuedeSeguir inválido
INSERT INTO ConfiguracionUsuario VALUES (20, 1, 'amigos', 'todos', 'todos', 1, 1);
 
-- quienVeHistorial inválido
INSERT INTO ConfiguracionUsuario VALUES (21, 1, 'todos', 'publico', 'todos', 1, 2);
 
-- quienVePublicaciones inválido
INSERT INTO ConfiguracionUsuario VALUES (22, 1, 'todos', 'todos', 'conocidos', 1, 3);
 
-- Los tres en mayúscula
INSERT INTO ConfiguracionUsuario VALUES (23, 1, 'Todos', 'Seguidores', 'Nadie', 1, 4);
 
-- Valor fuera de rango
INSERT INTO ConfiguracionUsuario VALUES (24, 2, 'todos', 'todos', 'todos', 1, 1);
 
-- Valor negativo
INSERT INTO ConfiguracionUsuario VALUES (25, -1, 'todos', 'todos', 'todos', 1, 2);

-- Valor fuera de rango
INSERT INTO ConfiguracionUsuario VALUES (26, 1, 'todos', 'todos', 'todos', 5, 3);
 
-- Valor negativo
INSERT INTO ConfiguracionUsuario VALUES (27, 1, 'todos', 'todos', 'todos', -1, 4);
 
-- GRAN CONCEPTO: MODERACIÓN & REPORTE
 
-- Motivo no contemplado
INSERT INTO Reporte VALUES (20, 1, 2, 'mentira', 'Descripcion', SYSDATE, 'pendiente');
 
-- En mayúscula
INSERT INTO Reporte VALUES (21, 1, 2, 'SPAM', 'Descripcion', SYSDATE, 'pendiente');
 
-- Motivo inventado
INSERT INTO Reporte VALUES (22, 1, 2, 'fraude', 'Descripcion', SYSDATE, 'pendiente');
 
-- Estado no contemplado
INSERT INTO Reporte VALUES (23, 1, 2, 'spam', 'Descripcion', SYSDATE, 'archivado');
 
-- En mayúscula
INSERT INTO Reporte VALUES (24, 1, 2, 'spam', 'Descripcion', SYSDATE, 'Pendiente');
 
-- Estado inventado
INSERT INTO Reporte VALUES (25, 1, 2, 'spam', 'Descripcion', SYSDATE, 'abierto');
 
-- Tipo no contemplado
INSERT INTO Sancion VALUES (20, 'silencio', SYSDATE, NULL, 'Test', 1, 5);
 
-- En mayúscula
INSERT INTO Sancion VALUES (21, 'Advertencia', SYSDATE, NULL, 'Test', 1, 5);
 
-- Tipo inventado
INSERT INTO Sancion VALUES (22, 'expulsion', SYSDATE, NULL, 'Test', 1, 5);
 
-- GRAN CONCEPTO: BÚSQUEDA & DESCUBRIMIENTO

-- Valor fuera de rango
INSERT INTO FiltroBusqueda VALUES (20, SYSDATE, 3, NULL, NULL, NULL, NULL, 1);
 
-- Valor negativo
INSERT INTO FiltroBusqueda VALUES (21, SYSDATE, -1, NULL, NULL, NULL, NULL, 2);
 
-- Valor mayor que 1
INSERT INTO FiltroBusqueda VALUES (22, SYSDATE, 2, NULL, NULL, NULL, NULL, 3);
 

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

-- no modificar id ni artista
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

    IF (:NEW.contenido IS NULL OR TRIM(:NEW.contenido) = '') AND :NEW.idCancionAdjunta IS NULL THEN
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

----------------------------------------------------------------------------------------------
-------------------------------------- DisparadoresOK --------------------------------------------
----------------------------------------------------------------------------------------------

-- GRAN CONCEPTO: CANCIÓN
 
INSERT INTO Genero VALUES (1, 'Rock', 'Musica con guitarras electricas y baterias');
INSERT INTO Genero VALUES (2, 'Pop', 'Musica popular de consumo masivo');
INSERT INTO Genero VALUES (3, 'Jazz', 'Genero afroamericano de improvisacion');
INSERT INTO Genero VALUES (4, 'Reggaeton', 'Ritmo urbano de origen caribeño');
 
INSERT INTO Artista VALUES (1, 'The Beatles', 'Reino Unido', TO_DATE('1960-01-01','YYYY-MM-DD'));
INSERT INTO Artista VALUES (2, 'Taylor Swift', 'Estados Unidos', TO_DATE('2006-06-01','YYYY-MM-DD'));
INSERT INTO Artista VALUES (3, 'Bad Bunny', 'Puerto Rico', TO_DATE('2016-01-01','YYYY-MM-DD'));
INSERT INTO Artista VALUES (4, 'Miles Davis', 'Estados Unidos', TO_DATE('1944-01-01','YYYY-MM-DD'));
 

INSERT INTO Cancion (idCancion, tituloCancion, duracion, año, idArtista, idGenero)
    VALUES (1, 'Let It Be', 243, TO_DATE('1970-05-08','YYYY-MM-DD'), 1, 1);
INSERT INTO Cancion (idCancion, tituloCancion, duracion, año, idArtista, idGenero)
    VALUES (2, 'Anti-Hero', 200, TO_DATE('2022-10-21','YYYY-MM-DD'), 2, 2);
INSERT INTO Cancion (idCancion, tituloCancion, duracion, año, idArtista, idGenero)
    VALUES (3, 'Titi Me Pregunto', 196, TO_DATE('2022-06-10','YYYY-MM-DD'), 3, 4);
INSERT INTO Cancion (idCancion, tituloCancion, duracion, año, idArtista, idGenero)
    VALUES (4, 'Kind of Blue', 562, TO_DATE('1959-08-17','YYYY-MM-DD'), 4, 3);
 
-- GRAN CONCEPTO: USUARIO

INSERT INTO Usuario (idUsuario, nombreUsuario, correo, contraseña, fechaRegistro, descripcionPerfil)
    VALUES (1, 'juangomez',  'juan@gmail.com', 'Password1', SYSDATE, 'Fan del rock');
INSERT INTO Usuario (idUsuario, nombreUsuario, correo, contraseña, fechaRegistro, descripcionPerfil)
    VALUES (2, 'mariaperez', 'maria@gmail.com', 'Segura456', SYSDATE, NULL);
INSERT INTO Usuario (idUsuario, nombreUsuario, correo, contraseña, fechaRegistro, descripcionPerfil)
    VALUES (3, 'carlos88',   'carlos@gmail.com', 'Jazz4Ever', SYSDATE, 'Amante del jazz');
INSERT INTO Usuario (idUsuario, nombreUsuario, correo, contraseña, fechaRegistro, descripcionPerfil)
    VALUES (4, 'adminUser',  'admin@app.com', 'Admin1234', SYSDATE, 'Administrador');
INSERT INTO Usuario (idUsuario, nombreUsuario, correo, contraseña, fechaRegistro, descripcionPerfil)
    VALUES (5, 'testUser5',  'test5@app.com', 'Test5678x', SYSDATE, NULL);
 
INSERT INTO UsuarioBasico VALUES (3);
INSERT INTO UsuarioBasico VALUES (5);
INSERT INTO UsuarioMembresia VALUES (1, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL, 'activa', 'premium');
INSERT INTO UsuarioMembresia VALUES (2, TO_DATE('2023-06-01','YYYY-MM-DD'), TO_DATE('2024-06-01','YYYY-MM-DD'), 'inactiva', 'basica');
INSERT INTO UsuarioMembresia VALUES (4, TO_DATE('2024-03-01','YYYY-MM-DD'), NULL, 'activa', 'familia');
INSERT INTO Usuario_Streaming VALUES (1, 'spotify');
INSERT INTO Usuario_Streaming VALUES (2, 'apple_music');
INSERT INTO Usuario_Streaming VALUES (3, 'youtube_music');
 
-- GRAN CONCEPTO: HUELLA MUSICAL

INSERT INTO Historial_Musical VALUES (1, TO_DATE('2024-03-01','YYYY-MM-DD'), 'Me recuerda mi infancia', 'feliz',1, 1);
INSERT INTO Historial_Musical VALUES (2, TO_DATE('2024-04-10','YYYY-MM-DD'), NULL, 'triste',  2, 2);
INSERT INTO Historial_Musical VALUES (3, TO_DATE('2024-05-22','YYYY-MM-DD'), 'Excelente ritmo', 'animado', 3, 3);
INSERT INTO HistorialBusqueda VALUES (1, 'The Beatles',   SYSDATE, 1);
INSERT INTO HistorialBusqueda VALUES (2, 'reggaeton 2022',SYSDATE, 2);
INSERT INTO HistorialBusqueda VALUES (3, 'jazz clasico',  SYSDATE, 3);
INSERT INTO Publicacion (idPublicacion, contenido, fechaPublicacion, likes, comentarios, idUsuario, idCancionAdjunta)
    VALUES (1, 'Clasico atemporal de los 70s', SYSDATE, 0, 0, 1, 1);
INSERT INTO Publicacion (idPublicacion, contenido, fechaPublicacion, likes, comentarios, idUsuario, idCancionAdjunta)
    VALUES (2, 'Taylor vuelve a dominar', SYSDATE, 0, 0, 2, 2);
INSERT INTO Publicacion (idPublicacion, contenido, fechaPublicacion, likes, comentarios, idUsuario, idCancionAdjunta)
    VALUES (3, 'El reggaeton sigue fuerte', SYSDATE, 0, 0, 3, 3); 
INSERT INTO Publicacion_TipoContenido VALUES (1, 'cancion');
INSERT INTO Publicacion_TipoContenido VALUES (2, 'album');
INSERT INTO Publicacion_TipoContenido VALUES (3, 'artista');
 
-- GRAN CONCEPTO: RECOMENDACIÓN

INSERT INTO Recomendacion (idRecomendacion, fechaRecomendacion, mensajeRecomendacion, tipoRecomendacion, idUsuario, idCancion, idUsuarioDestino, visualizacion)
    VALUES (1, SYSDATE, 'Te va a encantar esta cancion', 'directa',   1, 1, 2, 0);
INSERT INTO Recomendacion (idRecomendacion, fechaRecomendacion, mensajeRecomendacion, tipoRecomendacion, idUsuario, idCancion, idUsuarioDestino, visualizacion)
    VALUES (2, SYSDATE, 'Escucha esto de Taylor', 'publica',   2, 2, 3, 0);
INSERT INTO Recomendacion (idRecomendacion, fechaRecomendacion, mensajeRecomendacion, tipoRecomendacion, idUsuario, idCancion, idUsuarioDestino, visualizacion)
    VALUES (3, SYSDATE, 'Del playlist comunitario', 'comunidad', 3, 3, 1, 0);
 
-- GRAN CONCEPTO: CONFIGURACIÓN & PRIVACIDAD

INSERT INTO ConfiguracionUsuario (idConfiguracion, perfilPublico, quienPuedeSeguir, quienVeHistorial, quienVePublicaciones, notificacionesActivas, idUsuario)
    VALUES (1, 1, 'todos', 'seguidores', 'todos', 1, 1);
INSERT INTO ConfiguracionUsuario (idConfiguracion, perfilPublico, quienPuedeSeguir, quienVeHistorial, quienVePublicaciones, notificacionesActivas, idUsuario)
    VALUES (2, 0, 'seguidores', 'nadie', 'seguidores', 0, 2);
INSERT INTO ConfiguracionUsuario (idConfiguracion, perfilPublico, quienPuedeSeguir, quienVeHistorial, quienVePublicaciones, notificacionesActivas, idUsuario)
    VALUES (3, 1, 'todos', 'todos', 'todos', 1, 3);
 
-- GRAN CONCEPTO: MODERACIÓN & REPORTE

INSERT INTO Reporte (idReporte, idUsuarioReportante, idUsuarioReportado, motivoReporte, descripcionReporte, fechaReporte, estadoReporte)
    VALUES (1, 1, 5, 'spam',  'Publicaciones repetidas', SYSDATE, 'pendiente');
INSERT INTO Reporte (idReporte, idUsuarioReportante, idUsuarioReportado, motivoReporte, descripcionReporte, fechaReporte, estadoReporte)
    VALUES (2, 3, 4, 'acoso', 'Mensajes agresivos', SYSDATE, 'revisado');
INSERT INTO Reporte (idReporte, idUsuarioReportante, idUsuarioReportado, motivoReporte, descripcionReporte, fechaReporte, estadoReporte)
    VALUES (3, 2, 5, 'otro', 'Conducta sospechosa', SYSDATE, 'pendiente');
INSERT INTO Sancion (idSancion, tipoSancion, fechaInicio, fechaFin, motivoSancion, idReporte, idUsuario)
    VALUES (4, 'advertencia', TO_DATE('2024-01-01','YYYY-MM-DD'), TO_DATE('2024-02-01','YYYY-MM-DD'), 'Primera advertencia por spam', 1, 5);
INSERT INTO Sancion (idSancion, tipoSancion, fechaInicio, fechaFin, motivoSancion, idReporte, idUsuario)
    VALUES (5, 'suspension_temporal', TO_DATE('2024-03-01','YYYY-MM-DD'), TO_DATE('2024-04-01','YYYY-MM-DD'), 'Suspension por acoso reiterado', 2, 4);
 
-- GRAN CONCEPTO: BÚSQUEDA & DESCUBRIMIENTO

INSERT INTO FiltroBusqueda (idFiltro, fechaUso, exito, periodo, idGenero, idArtista, idRegistro, idBusqueda)
    VALUES (1, SYSDATE, 1, NULL, 1, NULL, NULL, 1);
INSERT INTO FiltroBusqueda (idFiltro, fechaUso, exito, periodo, idGenero, idArtista, idRegistro, idBusqueda)
    VALUES (2, SYSDATE, 0, NULL, NULL, 2, NULL, 2);
INSERT INTO FiltroBusqueda (idFiltro, fechaUso, exito, periodo, idGenero, idArtista, idRegistro, idBusqueda)
    VALUES (3, SYSDATE - 1, 1, TO_DATE('2022-01-01','YYYY-MM-DD'), 3, NULL, 1, 3);
 

------------------------------------------------------------------
-------------------- DISPARADORESNoOK ----------------------------
------------------------------------------------------------------

-- GRAN CONCEPTO: CANCIÓN

-- Año en el futuro lejano
INSERT INTO Cancion (idCancion, tituloCancion, duracion, año, idArtista, idGenero)
    VALUES (0, 'Cancion 2099', 180, TO_DATE('2099-01-01','YYYY-MM-DD'), 1, 1);
 
-- Año en el futuro cercano
INSERT INTO Cancion (idCancion, tituloCancion, duracion, año, idArtista, idGenero)
    VALUES (0, 'Cancion 2030', 200, ADD_MONTHS(SYSDATE, 12), 2, 2);
 
-- Modificar el idCancion
UPDATE Cancion SET idCancion = 99 WHERE idCancion = 1;
 
-- Modificar el idArtista de la canción
UPDATE Cancion SET idArtista = 4 WHERE idCancion = 1;
 
-- GRAN CONCEPTO: RECOMENDACIÓN

-- Usuario 1 se recomienda a sí mismo
INSERT INTO Recomendacion (idRecomendacion, fechaRecomendacion, mensajeRecomendacion, tipoRecomendacion, idUsuario, idCancion, idUsuarioDestino, visualizacion)
    VALUES (0, SYSDATE, 'Me auto-recomiendo', 'directa', 1, 1, 1, 0);
 
-- Usuario 2 se recomienda a sí mismo
INSERT INTO Recomendacion (idRecomendacion, fechaRecomendacion, mensajeRecomendacion, tipoRecomendacion, idUsuario, idCancion, idUsuarioDestino, visualizacion)
    VALUES (0, SYSDATE, 'Yo mismo', 'comunidad', 2, 2, 2, 0);
 
-- Usuario 3 se recomienda a sí mismo
INSERT INTO Recomendacion (idRecomendacion, fechaRecomendacion, mensajeRecomendacion, tipoRecomendacion, idUsuario, idCancion, idUsuarioDestino, visualizacion)
    VALUES (0, SYSDATE, 'Mi propia reco', 'publica', 3, 3, 3, 0);
 
-- Cambiar el destinatario de la recomendación
UPDATE Recomendacion SET idUsuarioDestino = 4 WHERE idRecomendacion = 1;
 
-- Cambiar la canción de la recomendación
UPDATE Recomendacion SET idCancion = 3 WHERE idRecomendacion = 2;
 
-- Cambiar ambos a la vez
UPDATE Recomendacion SET idCancion = 4, idUsuarioDestino = 5 WHERE idRecomendacion = 3;
 
UPDATE Recomendacion SET visualizacion = 1 WHERE idRecomendacion = 1;
 
-- Intentar eliminar una recomendación ya visualizada
DELETE FROM Recomendacion WHERE idRecomendacion = 1;
 
-- GRAN CONCEPTO: HUELLA MUSICAL

-- Contenido solo con espacios y sin canción adjunta
INSERT INTO Publicacion (idPublicacion, contenido, fechaPublicacion, likes, comentarios, idUsuario, idCancionAdjunta)
    VALUES (0, ' ', SYSDATE, 0, 0, 1, NULL);
 
-- Contenido con más espacios y sin canción adjunta
INSERT INTO Publicacion (idPublicacion, contenido, fechaPublicacion, likes, comentarios, idUsuario, idCancionAdjunta)
    VALUES (0, '   ', SYSDATE, 0, 0, 2, NULL);
 
-- Cambiar la canción adjunta de la publicación
UPDATE Publicacion SET idCancionAdjunta = 2 WHERE idPublicacion = 1;
 
-- Cambiar a NULL la canción adjunta
UPDATE Publicacion SET idCancionAdjunta = NULL WHERE idPublicacion = 2;
 
-- GRAN CONCEPTO: USUARIO

-- Contraseña de 7 caracteres
INSERT INTO Usuario (idUsuario, nombreUsuario, correo, contraseña, fechaRegistro, descripcionPerfil)
    VALUES (0, 'nuevouser1', 'nuevo1@mail.com', 'abc1234', SYSDATE, NULL);
 
-- Contraseña de 4 caracteres
INSERT INTO Usuario (idUsuario, nombreUsuario, correo, contraseña, fechaRegistro, descripcionPerfil)
    VALUES (0, 'nuevouser2', 'nuevo2@mail.com', 'ab12', SYSDATE, NULL);
 
-- Contraseña de 1 carácter
INSERT INTO Usuario (idUsuario, nombreUsuario, correo, contraseña, fechaRegistro, descripcionPerfil)
    VALUES (0, 'nuevouser3', 'nuevo3@mail.com', 'a', SYSDATE, NULL);

-- Espacio en medio del nombre
INSERT INTO Usuario (idUsuario, nombreUsuario, correo, contraseña, fechaRegistro, descripcionPerfil)
    VALUES (0, 'juan gomez', 'jgomez@mail.com', 'Password1', SYSDATE, NULL);
 
-- Espacio al inicio del nombre
INSERT INTO Usuario (idUsuario, nombreUsuario, correo, contraseña, fechaRegistro, descripcionPerfil)
    VALUES (0, ' mariap', 'mariap@mail.com', 'Password1', SYSDATE, NULL);
 
-- Espacio al final del nombre
INSERT INTO Usuario (idUsuario, nombreUsuario, correo, contraseña, fechaRegistro, descripcionPerfil)
    VALUES (0, 'carlos88 ', 'carlos99@mail.com', 'Password1', SYSDATE, NULL);
 
-- GRAN CONCEPTO: BÚSQUEDA & DESCUBRIMIENTO

-- fechaUso mañana
INSERT INTO FiltroBusqueda (idFiltro, fechaUso, exito, periodo, idGenero, idArtista, idRegistro, idBusqueda)
    VALUES (0, SYSDATE + 1, 1, NULL, 1, NULL, NULL, 1);
 
-- fechaUso 6 meses en el futuro
INSERT INTO FiltroBusqueda (idFiltro, fechaUso, exito, periodo, idGenero, idArtista, idRegistro, idBusqueda)
    VALUES (0, ADD_MONTHS(SYSDATE, 6), 0, NULL, NULL, NULL, NULL, 2);
 
-- fechaUso 1 año en el futuro
INSERT INTO FiltroBusqueda (idFiltro, fechaUso, exito, periodo, idGenero, idArtista, idRegistro, idBusqueda)
    VALUES (0, ADD_MONTHS(SYSDATE, 12), 1, NULL, NULL, 2, NULL, 3);
 
-- Cambiar el idFiltro
UPDATE FiltroBusqueda SET idFiltro = 99 WHERE idFiltro = 1 AND idBusqueda = 1;
 
-- Cambiar la fechaUso
UPDATE FiltroBusqueda SET fechaUso = SYSDATE - 10 WHERE idFiltro = 1 AND idBusqueda = 1;
 
 
-- Eliminar filtro con exito = 1
DELETE FROM FiltroBusqueda WHERE idFiltro = 1 AND idBusqueda = 1;
 
-- GRAN CONCEPTO: CONFIGURACIÓN & PRIVACIDAD

INSERT INTO ListaNegra VALUES (1, 1, 5, SYSDATE, 'Bloqueo inicial');

-- Cualquier modificación sobre ListaNegra es bloqueada
UPDATE ListaNegra SET motivoBloqueo = 'Modificado' WHERE idBloqueo = 1;
 
-- Cambiar el usuario destino
UPDATE ListaNegra SET idUsuarioDestino = 3 WHERE idBloqueo = 1;
 
-- Cambiar la fecha de bloqueo
UPDATE ListaNegra SET fechaBloqueo = SYSDATE - 5 WHERE idBloqueo = 1;
 
-- GRAN CONCEPTO: MODERACIÓN & REPORTE

-- Eliminar un reporte que tiene sanciones asociadas
DELETE FROM Reporte WHERE idReporte = 1;
 
-- Insertar una sanción con fechaFin en el futuro
INSERT INTO Sancion (idSancion, tipoSancion, fechaInicio, fechaFin, motivoSancion, idReporte, idUsuario)
    VALUES (0, 'suspension_temporal', SYSDATE, ADD_MONTHS(SYSDATE, 3), 'Sancion vigente prueba', 3, 5);

-- Intentar eliminar la sanción aún vigente
DELETE FROM Sancion WHERE idSancion = (SELECT MAX(idSancion) FROM Sancion WHERE fechaFin > SYSDATE);
 
-- Insertar sanción sin fecha de fin (ban permanente, nunca vence)
INSERT INTO Sancion (idSancion, tipoSancion, fechaInicio, fechaFin, motivoSancion, idReporte, idUsuario)
    VALUES (0, 'ban_permanente', SYSDATE, NULL, 'Ban permanente prueba', 3, 4);

-- Intentar eliminar la sanción sin fechaFin (fechaFin IS NULL → no vencida)
DELETE FROM Sancion WHERE idSancion = (SELECT MAX(idSancion) FROM Sancion WHERE fechaFin IS NULL);
 