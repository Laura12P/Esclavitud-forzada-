
-- XTABLAS — ELIMINACIÓN DE TABLAS
DROP TABLE FiltroBusqueda;
DROP TABLE HistorialBusqueda;
DROP TABLE Sancion;
DROP TABLE Reporte;
DROP TABLE ListaNegra;
DROP TABLE ConfiguracionUsuario;
DROP TABLE Recomendacion;
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
DROP TABLE Historial_Emocion;
DROP TABLE Historial_Periodo;
DROP TABLE Cancion_Genero;


-- SECCIÓN 1: TABLAS

-- GRAN CONCEPTO: CANCIÓN

CREATE TABLE Genero (
    idGenero        NUMBER(10)      PRIMARY KEY,
    nombreGenero    VARCHAR(255)    NOT NULL,
    descripcion     VARCHAR(255)    NOT NULL
);

CREATE TABLE Artista (
    idArtista       NUMBER(10)      PRIMARY KEY,
    nombre          VARCHAR(255)    NOT NULL,
    paisOrigen      VARCHAR(255)    NOT NULL,
    anoDebut        DATE            NOT NULL
);

CREATE TABLE Cancion (
    idCancion       NUMBER(10)      PRIMARY KEY,
    tituloCancion   VARCHAR(20)     NOT NULL,
    duracion        NUMBER(10)      NOT NULL,
    ano             DATE            NOT NULL,
    idArtista       NUMBER(10)      NOT NULL
);
-- Relación muchos a muchos
CREATE TABLE Cancion_Genero (
    idCancion       NUMBER(10)      NOT NULL,
    idGenero        NUMBER(10)      NOT NULL,
    CONSTRAINT pk_Cancion_Genero    PRIMARY KEY (idCancion, idGenero)
);

-- GRAN CONCEPTO: USUARIO

CREATE TABLE Usuario (
    idUsuario               NUMBER(10)      PRIMARY KEY,
    nombreUsuario           VARCHAR(255)    NOT NULL,
    correo                  VARCHAR(255)    NOT NULL,
    contrasena              VARCHAR(16)     NOT NULL,
    fechaRegistro           DATE            NOT NULL,
    descripcionPerfil       VARCHAR(100)    NULL
);
-- Atributo con multiplicidad muchos
CREATE TABLE Usuario_Streaming (
    idUsuario               NUMBER(10)      NOT NULL,
    plataformaStreaming      VARCHAR(20)     NOT NULL,
    CONSTRAINT pk_Usuario_Streaming         PRIMARY KEY (idUsuario, plataformaStreaming)
);

CREATE TABLE UsuarioBasico (
    idUsuario       NUMBER(10)      PRIMARY KEY
);

CREATE TABLE UsuarioMembresia (
    idUsuarioMembresia      NUMBER(10)      PRIMARY KEY,
    idUsuario               NUMBER(10)      NOT NULL,
    fechaInicioMembresia    DATE            NOT NULL,
    fechaFinMembresia       DATE            NULL,
    estadoMembresia         VARCHAR(20)     NOT NULL,
    tipoMembresia           VARCHAR(20)     NOT NULL
);


-- GRAN CONCEPTO: HUELLA MUSICAL

CREATE TABLE Publicacion (
    idPublicacion       NUMBER(10)      PRIMARY KEY,
    contenido           VARCHAR(255)    NOT NULL,
    fechaPublicacion    DATE            NOT NULL,
    likes               NUMBER(10)      NOT NULL,
    comentarios         NUMBER(10)      NOT NULL,
    idUsuario           NUMBER(10)      NOT NULL,
    idCancionAdjunta    NUMBER(10)      NULL
);

-- Atributo con multiplicidad muchos
CREATE TABLE Publicacion_TipoContenido (
    idPublicacion   NUMBER(10)      NOT NULL,
    tipoContenido   VARCHAR(20)     NOT NULL,
    CONSTRAINT pk_Publicacion_Tipo  PRIMARY KEY (idPublicacion, tipoContenido)
);

CREATE TABLE Historial_Musical (
    idRegistro          NUMBER(10)      PRIMARY KEY,
    fechaRegistro       DATE            NOT NULL,
    periodoInicio       DATE            NOT NULL,
    periodoFin          DATE            NULL,
    notaPersonal        VARCHAR(255)    NULL,
    emocion             VARCHAR(10)     NOT NULL,
    idCancion           NUMBER(10)      NOT NULL,
    idUsuario           NUMBER(10)      NOT NULL
);

-- Atributo con multiplicidad muchos
CREATE TABLE Historial_Periodo (
    idRegistro      NUMBER(10)      NOT NULL,
    periodo         DATE            NOT NULL,
    CONSTRAINT pk_Historial_Periodo     PRIMARY KEY (idRegistro, periodo)
);

-- Atributo con multiplicidad muchos
CREATE TABLE Historial_Emocion (
    idRegistro      NUMBER(10)      NOT NULL,
    emocion         VARCHAR(10)     NOT NULL,
    CONSTRAINT pk_Historial_Emocion     PRIMARY KEY (idRegistro, emocion)
);


-- GRAN CONCEPTO: RECOMENDACIÓN

CREATE TABLE Recomendacion (
    idRecomendacion         NUMBER(10)      PRIMARY KEY,
    fechaRecomendacion      DATE            NOT NULL,
    mensajeRecomendacion    VARCHAR(255)    NOT NULL,
    tipoRecomendacion       VARCHAR(20)     NOT NULL,
    idUsuario               NUMBER(10)      NOT NULL,
    idCancion               NUMBER(10)      NULL,
    idComunidad             NUMBER(10)      NULL
);


-- GRAN CONCEPTO: CONFIGURACIÓN & PRIVACIDAD

CREATE TABLE ConfiguracionUsuario (
    idConfiguracion         NUMBER(10)      PRIMARY KEY,
    perfilPublico           NUMBER(1)       NOT NULL,
    quienPuedeSeguir        VARCHAR2(15)    NOT NULL,
    quienVeHistorial        VARCHAR2(15)    NOT NULL,
    quienVePublicaciones    VARCHAR2(15)    NOT NULL,
    notificacionesActivas   NUMBER(1)       NOT NULL,
    idUsuario               NUMBER(10)      NOT NULL
);

CREATE TABLE ListaNegra (
    idBloqueo           NUMBER(10)      PRIMARY KEY,
    idUsuarioOrigen     NUMBER(10)      NOT NULL,
    idUsuarioDestino    NUMBER(10)      NOT NULL,
    fechaBloqueo        DATE            NOT NULL,
    motivoBloqueo       VARCHAR(255)    NULL
);


-- GRAN CONCEPTO: MODERACIÓN & REPORTE

CREATE TABLE Reporte (
    idReporte               NUMBER(10)      PRIMARY KEY,
    idUsuarioReportante     NUMBER(10)      NOT NULL,
    idUsuarioReportado      NUMBER(10)      NOT NULL,
    motivoReporte           VARCHAR(30)     NOT NULL,
    descripcionReporte      VARCHAR(255)    NULL,
    fechaReporte            DATE            NOT NULL,
    estadoReporte           VARCHAR(20)     NOT NULL
);

CREATE TABLE Sancion (
    idSancion           NUMBER(10)      PRIMARY KEY,
    tipoSancion         VARCHAR(25)     NOT NULL,
    fechaInicio         DATE            NOT NULL,
    fechaFin            DATE            NULL,
    motivoSancion       VARCHAR(255)    NOT NULL,
    idReporte           NUMBER(10)      NOT NULL,
    idUsuario           NUMBER(10)      NOT NULL
);


--  GRAN CONCEPTO: BÚSQUEDA & DESCUBRIMIENTO

CREATE TABLE HistorialBusqueda (
    idBusqueda          NUMBER(10)      PRIMARY KEY,
    terminoBusqueda     VARCHAR(255)    NOT NULL,
    fechaBusqueda       DATE            NOT NULL,
    idUsuario           NUMBER(10)      NOT NULL
);

CREATE TABLE FiltroBusqueda (
    idFiltro            NUMBER(10)      PRIMARY KEY,
    fechaUso            DATE            NOT NULL,
    exito               NUMBER(1)       NOT NULL,
    ipOrigen            VARCHAR2(45)    NOT NULL,
    periodo             DATE            NULL,
    idUsuario           NUMBER(10)      NOT NULL,
    idGenero            NUMBER(10)      NULL,
    idArtista           NUMBER(10)      NULL,
    idRegistro          NUMBER(10)      NULL,
    idBusqueda          NUMBER(10)      NULL
);


-- SECCIÓN 2: CLAVES FORÁNEAS

-- Canción
ALTER TABLE Cancion
    ADD CONSTRAINT fk_Cancion_Artista       
    FOREIGN KEY (idArtista) REFERENCES Artista(idArtista);

-- Cancion_Genero
ALTER TABLE Cancion_Genero
    ADD CONSTRAINT fk_CG_Cancion
    FOREIGN KEY (idCancion) REFERENCES Cancion(idCancion);

ALTER TABLE Cancion_Genero
    ADD CONSTRAINT fk_CG_Genero
    FOREIGN KEY (idGenero) REFERENCES Genero(idGenero);

-- Usuario
ALTER TABLE Usuario_Streaming
    ADD CONSTRAINT fk_US_Usuario            
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

ALTER TABLE UsuarioBasico
    ADD CONSTRAINT fk_UsuarioBasico         
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

ALTER TABLE UsuarioMembresia
    ADD CONSTRAINT fk_UsuarioMembresia      
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);


-- Huella Musical
ALTER TABLE Publicacion
    ADD CONSTRAINT fk_Publicacion_Usuario   
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

ALTER TABLE Publicacion
    ADD CONSTRAINT fk_Publicacion_Cancion   
    FOREIGN KEY (idCancionAdjunta) REFERENCES Cancion(idCancion);

ALTER TABLE Publicacion_TipoContenido
    ADD CONSTRAINT fk_PTC_Publicacion       
    FOREIGN KEY (idPublicacion) REFERENCES Publicacion(idPublicacion);

ALTER TABLE Historial_Musical
    ADD CONSTRAINT fk_HM_Cancion            
    FOREIGN KEY (idCancion) REFERENCES Cancion(idCancion);

ALTER TABLE Historial_Musical
    ADD CONSTRAINT fk_HM_Usuario            
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

-- Historial_Periodo
ALTER TABLE Historial_Periodo
    ADD CONSTRAINT fk_HP_Historial
    FOREIGN KEY (idRegistro) REFERENCES Historial_Musical(idRegistro);

-- Historial_Emocion
ALTER TABLE Historial_Emocion
    ADD CONSTRAINT fk_HE_Historial
    FOREIGN KEY (idRegistro) REFERENCES Historial_Musical(idRegistro);

-- Recomendación
ALTER TABLE Recomendacion
    ADD CONSTRAINT fk_Reco_Usuario          
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

ALTER TABLE Recomendacion
    ADD CONSTRAINT fk_Reco_Cancion          
    FOREIGN KEY (idCancion) REFERENCES Cancion(idCancion);

-- Configuración & Privacidad
ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT fk_Config_Usuario        
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

ALTER TABLE ListaNegra
    ADD CONSTRAINT fk_LN_Origen             
    FOREIGN KEY (idUsuarioOrigen) REFERENCES Usuario(idUsuario);

ALTER TABLE ListaNegra
    ADD CONSTRAINT fk_LN_Destino            
    FOREIGN KEY (idUsuarioDestino) REFERENCES Usuario(idUsuario);

-- Moderación & Reporte
ALTER TABLE Reporte
    ADD CONSTRAINT fk_Reporte_Reportante    
    FOREIGN KEY (idUsuarioReportante) REFERENCES Usuario(idUsuario);

ALTER TABLE Reporte
    ADD CONSTRAINT fk_Reporte_Reportado     
    FOREIGN KEY (idUsuarioReportado) REFERENCES Usuario(idUsuario);

ALTER TABLE Sancion
    ADD CONSTRAINT fk_Sancion_Reporte       
    FOREIGN KEY (idReporte) REFERENCES Reporte(idReporte);

ALTER TABLE Sancion
    ADD CONSTRAINT fk_Sancion_Usuario       
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

-- Búsqueda & Descubrimiento
ALTER TABLE HistorialBusqueda
    ADD CONSTRAINT fk_HB_Usuario            
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Usuario            
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario);

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Genero            
    FOREIGN KEY (idGenero) REFERENCES Genero(idGenero);

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Artista            
    FOREIGN KEY (idArtista) REFERENCES Artista(idArtista);

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Historial          
    FOREIGN KEY (idRegistro) REFERENCES Historial_Musical(idRegistro);

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Busqueda
    FOREIGN KEY (idBusqueda) REFERENCES HistorialBusqueda(idBusqueda);

-- #RESTRICCIONES DECLARATIVAS

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
