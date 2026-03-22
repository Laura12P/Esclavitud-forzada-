-- ============================================================
-- MOODHEARD — DISEÑO LÓGICO
-- ============================================================


-- ============================================================
-- SECCIÓN 1: TABLAS
-- (Solo estructura: columnas, nulabilidad y clave primaria)
-- ============================================================

-- 🟢 GRAN CONCEPTO: CANCIÓN

CREATE TABLE Genero (
    idGenero        INT(10)         PRIMARY KEY,
    nombreGenero    VARCHAR(255)    NOT NULL,
    descripcion     VARCHAR(255)    NOT NULL
);

CREATE TABLE Artista (
    idArtista       INT(10)         PRIMARY KEY,
    nombre          VARCHAR(255)    NOT NULL,
    paisOrigen      VARCHAR(255)    NOT NULL,
    anoDebut        DATE            NOT NULL
);

CREATE TABLE Cancion (
    idCancion       INT(10)         PRIMARY KEY,
    tituloCancion   VARCHAR(20)     NOT NULL,
    duracion        INT(10)         NOT NULL,
    ano             DATE            NOT NULL,
    idArtista       INT(10)         NOT NULL
);

CREATE TABLE Cancion_Genero (
    idCancion       INT(10)         NOT NULL,
    idGenero        INT(10)         NOT NULL,
    CONSTRAINT pk_Cancion_Genero    PRIMARY KEY (idCancion, idGenero)
);


-- 💙 GRAN CONCEPTO: PAGOS & MEMBRESÍAS — CICLO 2

CREATE TABLE Membresia (
    idMembresia         INT(10)         PRIMARY KEY,
    tipoMembresia       VARCHAR(20)     NOT NULL,
    fechaInicio         DATE            NOT NULL,
    fechaFin            DATE            NOT NULL,
    precio              DECIMAL(10,2)   NOT NULL,
    estadoMembresia     VARCHAR(20)     NOT NULL
);

CREATE TABLE Pago (
    idPago          INT(10)         PRIMARY KEY,
    fechaPago       DATE            NOT NULL,
    monto           INT(10)         NOT NULL,
    metodoPago      VARCHAR(20)     NOT NULL,
    estadoPago      VARCHAR(20)     NOT NULL,
    idMembresia     INT(10)         NOT NULL
);


-- 🫧 GRAN CONCEPTO: COMUNIDAD

CREATE TABLE Comunidad (
    idComunidad         INT(10)         PRIMARY KEY,
    nombreComunidad     VARCHAR(255)    NOT NULL,
    descripcion         VARCHAR(255)    NOT NULL,
    fechaCreacion       DATE            NOT NULL,
    tipoComunidad       VARCHAR(20)     NOT NULL,
    estadoComunidad     VARCHAR(20)     NOT NULL,
    idMembresia         INT(10)         NULL
);


-- 🟣 GRAN CONCEPTO: USUARIO

CREATE TABLE Usuario (
    idUsuario               INT(10)         PRIMARY KEY,
    nombreUsuario           VARCHAR(255)    NOT NULL,
    correo                  VARCHAR(255)    NOT NULL,
    contrasena              VARCHAR(16)     NOT NULL,
    fechaRegistro           DATE            NOT NULL,
    descripcionPerfil       VARCHAR(100)    NULL,
    plataformaStreaming      VARCHAR(20)     NOT NULL
);

CREATE TABLE UsuarioBasico (
    idUsuario       INT(10)         PRIMARY KEY
);

CREATE TABLE UsuarioMembresia (
    idUsuarioMembresia      INT(10)         PRIMARY KEY,
    idUsuario               INT(10)         NOT NULL,
    fechaInicioMembresia    DATE            NOT NULL,
    fechaFinMembresia       DATE            NULL,
    estadoMembresia         VARCHAR(20)     NOT NULL,
    tipoMembresia           VARCHAR(20)     NOT NULL
);


-- 🩷 GRAN CONCEPTO: HUELLA MUSICAL

CREATE TABLE Publicacion (
    idPublicacion       INT(10)         PRIMARY KEY,
    contenido           VARCHAR(255)    NOT NULL,
    fechaPublicacion    DATE            NOT NULL,
    likes               INT(10)         NOT NULL    DEFAULT 0,
    comentarios         INT(10)         NOT NULL    DEFAULT 0,
    tipoContenido       VARCHAR(20)     NOT NULL,
    idUsuario           INT(10)         NOT NULL,
    idCancionAdjunta    INT(10)         NULL
);

CREATE TABLE Historial_Musical (
    idRegistro          INT(10)         PRIMARY KEY,
    fechaRegistro       DATE            NOT NULL,
    periodoInicio       DATE            NOT NULL,
    periodoFin          DATE            NULL,
    notaPersonal        VARCHAR(255)    NULL,
    emocion             VARCHAR(10)     NOT NULL,
    idCancion           INT(10)         NOT NULL,
    idUsuario           INT(10)         NOT NULL
);


-- 🟤 GRAN CONCEPTO: RECOMENDACIÓN

CREATE TABLE Recomendacion (
    idRecomendacion         INT(10)         PRIMARY KEY,
    fechaRecomendacion      DATE            NOT NULL,
    mensajeRecomendacion    VARCHAR(255)    NOT NULL,
    tipoRecomendacion       VARCHAR(20)     NOT NULL,
    idUsuario               INT(10)         NOT NULL,
    idCancion               INT(10)         NULL,
    idComunidad             INT(10)         NULL
);


-- 🔔 GRAN CONCEPTO: NOTIFICACIÓN

CREATE TABLE Notificacion (
    idNotificacion              INT(10)         PRIMARY KEY,
    correoUsuario               VARCHAR(255)    NOT NULL,
    fechaPagoRechazado          DATE            NOT NULL,
    descripcionNotificacion     VARCHAR(255)    NOT NULL,
    idPago                      INT(10)         NOT NULL
);


-- ⚙️ GRAN CONCEPTO: CONFIGURACIÓN & PRIVACIDAD

CREATE TABLE ConfiguracionUsuario (
    idConfiguracion         INT(10)         PRIMARY KEY,
    perfilPublico           BOOLEAN         NOT NULL    DEFAULT TRUE,
    quienPuedeSeguir        VARCHAR(15)     NOT NULL    DEFAULT 'todos',
    quienVeHistorial        VARCHAR(15)     NOT NULL    DEFAULT 'todos',
    quienVePublicaciones    VARCHAR(15)     NOT NULL    DEFAULT 'todos',
    notificacionesActivas   BOOLEAN         NOT NULL    DEFAULT TRUE,
    idUsuario               INT(10)         NOT NULL
);

CREATE TABLE ListaNegra (
    idBloqueo           INT(10)         PRIMARY KEY,
    idUsuarioOrigen     INT(10)         NOT NULL,
    idUsuarioDestino    INT(10)         NOT NULL,
    fechaBloqueo        DATE            NOT NULL,
    motivoBloqueo       VARCHAR(255)    NULL
);


-- 🚨 GRAN CONCEPTO: MODERACIÓN & REPORTE

CREATE TABLE Reporte (
    idReporte               INT(10)         PRIMARY KEY,
    idUsuarioReportante     INT(10)         NOT NULL,
    idUsuarioReportado      INT(10)         NOT NULL,
    motivoReporte           VARCHAR(30)     NOT NULL,
    descripcionReporte      VARCHAR(255)    NULL,
    fechaReporte            DATE            NOT NULL,
    estadoReporte           VARCHAR(20)     NOT NULL    DEFAULT 'pendiente'
);

CREATE TABLE Sancion (
    idSancion           INT(10)         PRIMARY KEY,
    tipoSancion         VARCHAR(25)     NOT NULL,
    fechaInicio         DATE            NOT NULL,
    fechaFin            DATE            NULL,
    motivoSancion       VARCHAR(255)    NOT NULL,
    idReporte           INT(10)         NOT NULL,
    idUsuario           INT(10)         NOT NULL
);


-- 🔍 GRAN CONCEPTO: BÚSQUEDA & DESCUBRIMIENTO

CREATE TABLE HistorialBusqueda (
    idBusqueda          INT(10)         PRIMARY KEY,
    terminoBusqueda     VARCHAR(255)    NOT NULL,
    fechaBusqueda       DATE            NOT NULL,
    idUsuario           INT(10)         NOT NULL
);

CREATE TABLE FiltroBusqueda (
    idFiltro            INT(10)         PRIMARY KEY,
    fechaUso            DATE            NOT NULL,
    exito               BOOLEAN         NOT NULL    DEFAULT FALSE,
    ipOrigen            VARCHAR(45)     NOT NULL,
    periodo             DATE            NULL,
    idUsuario           INT(10)         NOT NULL,
    idGenero            INT(10)         NULL,
    idArtista           INT(10)         NULL,
    idRegistro          INT(10)         NULL,
    idBusqueda          INT(10)         NULL
);


-- ============================================================
-- SECCIÓN 2: CLAVES FORÁNEAS
-- ============================================================

-- 🟢 Canción
ALTER TABLE Cancion
    ADD CONSTRAINT fk_Cancion_Artista       FOREIGN KEY (idArtista)             REFERENCES Artista(idArtista);

ALTER TABLE Cancion_Genero
    ADD CONSTRAINT fk_CG_Cancion            FOREIGN KEY (idCancion)             REFERENCES Cancion(idCancion);
ALTER TABLE Cancion_Genero
    ADD CONSTRAINT fk_CG_Genero             FOREIGN KEY (idGenero)              REFERENCES Genero(idGenero);

-- 💙 Pagos & Membresías
ALTER TABLE Pago
    ADD CONSTRAINT fk_Pago_Membresia        FOREIGN KEY (idMembresia)           REFERENCES Membresia(idMembresia);

-- 🫧 Comunidad
ALTER TABLE Comunidad
    ADD CONSTRAINT fk_Comunidad_Membresia   FOREIGN KEY (idMembresia)           REFERENCES Membresia(idMembresia);

-- 🟣 Usuario
ALTER TABLE UsuarioBasico
    ADD CONSTRAINT fk_UsuarioBasico         FOREIGN KEY (idUsuario)             REFERENCES Usuario(idUsuario);

ALTER TABLE UsuarioMembresia
    ADD CONSTRAINT fk_UsuarioMembresia      FOREIGN KEY (idUsuario)             REFERENCES Usuario(idUsuario);

-- 🩷 Huella Musical
ALTER TABLE Publicacion
    ADD CONSTRAINT fk_Publicacion_Usuario   FOREIGN KEY (idUsuario)             REFERENCES Usuario(idUsuario);
ALTER TABLE Publicacion
    ADD CONSTRAINT fk_Publicacion_Cancion   FOREIGN KEY (idCancionAdjunta)      REFERENCES Cancion(idCancion);

ALTER TABLE Historial_Musical
    ADD CONSTRAINT fk_HM_Cancion            FOREIGN KEY (idCancion)             REFERENCES Cancion(idCancion);
ALTER TABLE Historial_Musical
    ADD CONSTRAINT fk_HM_Usuario            FOREIGN KEY (idUsuario)             REFERENCES Usuario(idUsuario);

-- 🟤 Recomendación
ALTER TABLE Recomendacion
    ADD CONSTRAINT fk_Reco_Usuario          FOREIGN KEY (idUsuario)             REFERENCES Usuario(idUsuario);
ALTER TABLE Recomendacion
    ADD CONSTRAINT fk_Reco_Cancion          FOREIGN KEY (idCancion)             REFERENCES Cancion(idCancion);
ALTER TABLE Recomendacion
    ADD CONSTRAINT fk_Reco_Comunidad        FOREIGN KEY (idComunidad)           REFERENCES Comunidad(idComunidad);

-- 🔔 Notificación
ALTER TABLE Notificacion
    ADD CONSTRAINT fk_Notificacion_Pago     FOREIGN KEY (idPago)                REFERENCES Pago(idPago);

-- ⚙️ Configuración & Privacidad
ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT fk_Config_Usuario        FOREIGN KEY (idUsuario)             REFERENCES Usuario(idUsuario);

ALTER TABLE ListaNegra
    ADD CONSTRAINT fk_LN_Origen             FOREIGN KEY (idUsuarioOrigen)       REFERENCES Usuario(idUsuario);
ALTER TABLE ListaNegra
    ADD CONSTRAINT fk_LN_Destino            FOREIGN KEY (idUsuarioDestino)      REFERENCES Usuario(idUsuario);

-- 🚨 Moderación & Reporte
ALTER TABLE Reporte
    ADD CONSTRAINT fk_Reporte_Reportante    FOREIGN KEY (idUsuarioReportante)   REFERENCES Usuario(idUsuario);
ALTER TABLE Reporte
    ADD CONSTRAINT fk_Reporte_Reportado     FOREIGN KEY (idUsuarioReportado)    REFERENCES Usuario(idUsuario);

ALTER TABLE Sancion
    ADD CONSTRAINT fk_Sancion_Reporte       FOREIGN KEY (idReporte)             REFERENCES Reporte(idReporte);
ALTER TABLE Sancion
    ADD CONSTRAINT fk_Sancion_Usuario       FOREIGN KEY (idUsuario)             REFERENCES Usuario(idUsuario);

-- 🔍 Búsqueda & Descubrimiento
ALTER TABLE HistorialBusqueda
    ADD CONSTRAINT fk_HB_Usuario            FOREIGN KEY (idUsuario)             REFERENCES Usuario(idUsuario);

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Usuario            FOREIGN KEY (idUsuario)             REFERENCES Usuario(idUsuario);
ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Genero             FOREIGN KEY (idGenero)              REFERENCES Genero(idGenero);
ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Artista            FOREIGN KEY (idArtista)             REFERENCES Artista(idArtista);
ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Historial          FOREIGN KEY (idRegistro)            REFERENCES Historial_Musical(idRegistro);
ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Busqueda           FOREIGN KEY (idBusqueda)            REFERENCES HistorialBusqueda(idBusqueda);


-- ============================================================
-- SECCIÓN 3: TIPOS (mediante CHECK constraints)
-- ============================================================

-- 💙 Membresia
ALTER TABLE Membresia
    ADD CONSTRAINT ck_Membresia_tipo        CHECK (tipoMembresia    IN ('basica', 'premium', 'familia'));
ALTER TABLE Membresia
    ADD CONSTRAINT ck_Membresia_estado      CHECK (estadoMembresia  IN ('activa', 'inactiva', 'suspendida'));

-- 💙 Pago
ALTER TABLE Pago
    ADD CONSTRAINT ck_Pago_metodo           CHECK (metodoPago       IN ('tarjeta', 'transferencia', 'efectivo'));
ALTER TABLE Pago
    ADD CONSTRAINT ck_Pago_estado           CHECK (estadoPago       IN ('pendiente', 'aprobado', 'rechazado'));

-- 🫧 Comunidad
ALTER TABLE Comunidad
    ADD CONSTRAINT ck_Comunidad_tipo        CHECK (tipoComunidad    IN ('publica', 'privada', 'restringida'));
ALTER TABLE Comunidad
    ADD CONSTRAINT ck_Comunidad_estado      CHECK (estadoComunidad  IN ('activa', 'inactiva', 'archivada'));

-- 🟣 Usuario
ALTER TABLE Usuario
    ADD CONSTRAINT ck_Usuario_streaming     CHECK (plataformaStreaming IN ('spotify', 'apple_music', 'youtube_music', 'deezer', 'tidal'));

-- 🟣 UsuarioMembresia
ALTER TABLE UsuarioMembresia
    ADD CONSTRAINT ck_UM_estado             CHECK (estadoMembresia  IN ('activa', 'inactiva', 'suspendida'));
ALTER TABLE UsuarioMembresia
    ADD CONSTRAINT ck_UM_tipo               CHECK (tipoMembresia    IN ('basica', 'premium', 'familia'));

-- 🩷 Publicacion
ALTER TABLE Publicacion
    ADD CONSTRAINT ck_Publicacion_tipo      CHECK (tipoContenido    IN ('cancion', 'album', 'artista', 'playlist'));

-- 🟤 Recomendacion
ALTER TABLE Recomendacion
    ADD CONSTRAINT ck_Recomendacion_tipo    CHECK (tipoRecomendacion IN ('directa', 'comunidad', 'publica'));

-- ⚙️ ConfiguracionUsuario
ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT ck_Config_seguir         CHECK (quienPuedeSeguir     IN ('todos', 'seguidores', 'nadie'));
ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT ck_Config_historial      CHECK (quienVeHistorial      IN ('todos', 'seguidores', 'nadie'));
ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT ck_Config_publicaciones  CHECK (quienVePublicaciones  IN ('todos', 'seguidores', 'nadie'));

-- 🚨 Reporte
ALTER TABLE Reporte
    ADD CONSTRAINT ck_Reporte_motivo        CHECK (motivoReporte    IN ('spam', 'contenido_inapropiado', 'acoso', 'derechos_autor', 'otro'));
ALTER TABLE Reporte
    ADD CONSTRAINT ck_Reporte_estado        CHECK (estadoReporte    IN ('pendiente', 'revisado', 'resuelto', 'descartado'));

-- 🚨 Sancion
ALTER TABLE Sancion
    ADD CONSTRAINT ck_Sancion_tipo          CHECK (tipoSancion      IN ('advertencia', 'suspension_temporal', 'ban_permanente'));


-- ============================================================
-- XTABLAS — ELIMINACIÓN EN ORDEN INVERSO DE DEPENDENCIAS
-- ============================================================

DROP TABLE IF EXISTS FiltroBusqueda;
DROP TABLE IF EXISTS HistorialBusqueda;
DROP TABLE IF EXISTS Sancion;
DROP TABLE IF EXISTS Reporte;
DROP TABLE IF EXISTS ListaNegra;
DROP TABLE IF EXISTS ConfiguracionUsuario;
DROP TABLE IF EXISTS Notificacion;
DROP TABLE IF EXISTS Recomendacion;
DROP TABLE IF EXISTS Historial_Musical;
DROP TABLE IF EXISTS Publicacion;
DROP TABLE IF EXISTS UsuarioBasico;
DROP TABLE IF EXISTS UsuarioMembresia;
DROP TABLE IF EXISTS Usuario;
DROP TABLE IF EXISTS Cancion_Genero;
DROP TABLE IF EXISTS Cancion;
DROP TABLE IF EXISTS Artista;
DROP TABLE IF EXISTS Genero;
DROP TABLE IF EXISTS Comunidad;
DROP TABLE IF EXISTS Pago;
DROP TABLE IF EXISTS Membresia;
