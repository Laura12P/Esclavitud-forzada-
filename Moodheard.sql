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
    contrasena              VARCHAR(16)     NOT NULL,
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
    idCancion               NUMBER(10)
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

----------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- Mantener Catálogo de Canciones ------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
-- Trigger 1: Validar que la canción tenga al menos un artista vinculado
CREATE TRIGGER trg_Cancion_TieneArtista
BEFORE INSERT
ON Cancion
FOR EACH ROW
DECLARE
    v_count NUMBER(10);
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Artista
    WHERE idArtista = :NEW.idArtista;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20004,
            'La canción debe tener al menos un artista vinculado.');
    END IF;
END;


-- Trigger 2: Validar que el año de la canción no sea futuro
CREATE TRIGGER trg_Cancion_AnoNoFuturo
BEFORE INSERT OR UPDATE OF ano
ON Cancion
FOR EACH ROW
DECLARE
BEGIN
    IF :NEW.ano > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20005, 
            'El año de la canción no puede ser una fecha futura.');
    END IF;
END;

-- Trigger 3: Verificar que idCancion exista en Cancion antes de asociar
CREATE TRIGGER trg_CG_CancionExiste
BEFORE INSERT
ON Cancion_Genero
FOR EACH ROW
DECLARE
    v_count NUMBER(10);
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Cancion WHERE idCancion = :NEW.idCancion;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 
            'La canción indicada no existe.');
    END IF;
END;

-- Trigger 4: Verificar que idGenero exista en Genero antes de asociar
CREATE TRIGGER trg_CG_GeneroExiste
BEFORE INSERT
ON Cancion_Genero
FOR EACH ROW
DECLARE
    v_count NUMBER(10);
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Genero WHERE idGenero = :NEW.idGenero;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20007, 
            'El género indicado no existe.');
    END IF;
END;

-- Trigger 5: Generar idCancion de forma incremental automática
CREATE TRIGGER trg_Cancion_IdIncremental
BEFORE INSERT
ON Cancion
FOR EACH ROW
DECLARE
BEGIN
    SELECT NVL(MAX(idCancion), 0) + 1 INTO :NEW.idCancion
    FROM Cancion;
END;

-- Trigger 6: Evitar modificación del idArtista original de una canción
CREATE TRIGGER trg_Cancion_NoModificarArtista
BEFORE UPDATE OF idArtista
ON Cancion
FOR EACH ROW
DECLARE
BEGIN
    IF :NEW.idArtista <> :OLD.idArtista THEN
        RAISE_APPLICATION_ERROR(-20030,
            'No se puede modificar el artista original de una canción ya registrada.');
    END IF;
END;

-- Trigger 7: Evitar modificación del idCancion
CREATE TRIGGER trg_Cancion_NoModificarId
BEFORE UPDATE OF idCancion
ON Cancion
FOR EACH ROW
DECLARE
BEGIN
    IF :NEW.idCancion <> :OLD.idCancion THEN
        RAISE_APPLICATION_ERROR(-20031,
            'No se puede modificar el ID de una canción ya registrada.');
    END IF;
END;


----------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- Registrar Recomendación  ------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------

-- Trigger 1: Asignar fecha de recomendación automáticamente e inicializar visualizada en 0
CREATE TRIGGER trg_Reco_InsertarDefaults
BEFORE INSERT
ON Recomendacion
FOR EACH ROW
DECLARE
BEGIN
    :NEW.fechaRecomendacion := SYSDATE;
    :NEW.visualizada := 0;
END;

-- Trigger 2: Evitar que un usuario se recomiende a sí mismo
CREATE TRIGGER trg_Reco_NoAutoEnvio
BEFORE INSERT
ON Recomendacion
FOR EACH ROW
DECLARE
BEGIN
    IF :NEW.idUsuario = :NEW.idUsuarioDestino THEN
        RAISE_APPLICATION_ERROR(-20032,
            'Un usuario no puede enviarse una recomendación a sí mismo.');
    END IF;
END;

-- Trigger 3: Evitar modificación del destinatario y la canción
CREATE TRIGGER trg_Reco_NoModificarDestinatarioCancion
BEFORE UPDATE OF idUsuarioDestino, idCancion
ON Recomendacion
FOR EACH ROW
DECLARE
BEGIN
    IF :NEW.idUsuarioDestino <> :OLD.idUsuarioDestino THEN
        RAISE_APPLICATION_ERROR(-20033,
            'No se puede modificar el destinatario de una recomendación ya registrada.');
    END IF;
    IF :NEW.idCancion <> :OLD.idCancion THEN
        RAISE_APPLICATION_ERROR(-20034,
            'No se puede modificar la canción de una recomendación ya registrada.');
    END IF;
END;

-- Trigger 4: Evitar eliminación si ya fue visualizada
CREATE TRIGGER trg_Reco_NoEliminarVisualizada
BEFORE DELETE
ON Recomendacion
FOR EACH ROW
DECLARE
BEGIN
    IF :OLD.visualizada = 1 THEN
        RAISE_APPLICATION_ERROR(-20035,
            'No se puede eliminar una recomendación que ya fue visualizada por el destinatario.');
    END IF;
END;

-- Trigger 5: Verificar que la canción recomendada exista
CREATE TRIGGER trg_Reco_CancionExiste
BEFORE INSERT
ON Recomendacion
FOR EACH ROW
DECLARE
    v_count NUMBER(10);
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Cancion
    WHERE idCancion = :NEW.idCancion;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20036,
            'La canción indicada no existe y no puede ser recomendada.');
    END IF;
END;

----------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------- Mantener Publicación ------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
-- Trigger 1: Inicializar likes y comentarios en 0 al crear publicación
CREATE TRIGGER trg_Pub_InicializarContadores
BEFORE INSERT
ON Publicacion
FOR EACH ROW
DECLARE
BEGIN
    :NEW.likes      := 0;
    :NEW.comentarios := 0;
END;

-- Trigger 2: Generar idPublicacion incremental y asignar fecha automática
CREATE TRIGGER trg_Pub_InsertarDefaults
BEFORE INSERT
ON Publicacion
FOR EACH ROW
DECLARE
BEGIN
    SELECT NVL(MAX(idPublicacion), 0) + 1 INTO :NEW.idPublicacion
    FROM Publicacion;
    :NEW.fechaPublicacion := SYSDATE;
END;

-- Trigger 3: Validar que la publicación tenga texto o canción adjunta
CREATE TRIGGER trg_Pub_ContenidoObligatorio
BEFORE INSERT
ON Publicacion
FOR EACH ROW
DECLARE
BEGIN
    IF (TRIM(:NEW.contenido) IS NULL OR TRIM(:NEW.contenido) = '')
        AND :NEW.idCancionAdjunta IS NULL THEN
        RAISE_APPLICATION_ERROR(-20037,
            'La publicación debe contener texto o una canción adjunta obligatoriamente.');
    END IF;
END;

-- Trigger 4: Evitar modificación de la canción adjunta una vez publicada
CREATE TRIGGER trg_Pub_NoModificarCancion
BEFORE UPDATE OF idCancionAdjunta
ON Publicacion
FOR EACH ROW
DECLARE
BEGIN
    IF :NEW.idCancionAdjunta <> :OLD.idCancionAdjunta THEN
        RAISE_APPLICATION_ERROR(-20038,
            'No se puede modificar la canción adjunta de una publicación ya registrada.');
    END IF;
END;

-- Trigger 5: Al eliminar publicación, eliminar comentarios asociados
CREATE TRIGGER trg_Pub_EliminarCascada
BEFORE DELETE
ON Publicacion
FOR EACH ROW
DECLARE
BEGIN
    DELETE FROM Publicacion_TipoContenido
    WHERE idPublicacion = :OLD.idPublicacion;
END;

----------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------ Mantener Perfil De Usuario ------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
-- Trigger 1: Validar que la contraseña tenga al menos 8 caracteres
CREATE TRIGGER trg_Usuario_ContrasenaSegura
BEFORE INSERT OR UPDATE OF contrasena
ON Usuario
FOR EACH ROW
DECLARE
BEGIN
    IF LENGTH(:NEW.contrasena) < 8 THEN
        RAISE_APPLICATION_ERROR(-20008, 
            'La contraseña debe tener al menos 8 caracteres.');
    END IF;
END;

--Trigger 2: Evitar que el nombreUsuario contenga espacios
CREATE TRIGGER trg_Usuario_NombreSinEspacios
BEFORE INSERT OR UPDATE OF nombreUsuario
ON Usuario
FOR EACH ROW
DECLARE
BEGIN
    IF INSTR(:NEW.nombreUsuario, ' ') > 0 THEN
        RAISE_APPLICATION_ERROR(-20008,
            'El nombre de usuario no puede contener espacios.');
    END IF;
END;

-- Trigger 3: Asignar fecha de registro automáticamente
CREATE TRIGGER trg_Usuario_FechaRegistroAuto
BEFORE INSERT
ON Usuario
FOR EACH ROW
DECLARE
BEGIN
    :NEW.fechaRegistro := SYSDATE;
END;

-- Trigger 4: Verificar que el correo no esté en uso al modificarlo
CREATE TRIGGER trg_Usuario_CorreoUnicoUpdate
BEFORE UPDATE OF correo
ON Usuario
FOR EACH ROW
DECLARE
    v_count NUMBER(10);
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Usuario
    WHERE correo = :NEW.correo
      AND idUsuario <> :OLD.idUsuario;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20039,
            'El correo ingresado ya está en uso por otro usuario.');
    END IF;
END;

-- Trigger 5: Evitar eliminación si el usuario tiene membresía activa
CREATE TRIGGER trg_Usuario_NoEliminarConMembresia
BEFORE DELETE
ON Usuario
FOR EACH ROW
DECLARE
    v_count NUMBER(10);
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM UsuarioMembresia
    WHERE idUsuario = :OLD.idUsuario
      AND estadoMembresia = 'activa';
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20040,
            'No se puede eliminar un usuario con una membresía activa.');
    END IF;
END;

-- Trigger 21: Verificar que el registro padre exista en Historial_Musical
CREATE TRIGGER trg_HE_RegistroExiste
BEFORE INSERT
ON Historial_Emocion
FOR EACH ROW
DECLARE
    v_count NUMBER(10);
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM Historial_Musical WHERE idRegistro = :NEW.idRegistro;
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20024, 
            'El registro de historial musical indicado no existe.');
    END IF;
END;
