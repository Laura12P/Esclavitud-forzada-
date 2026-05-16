-- XTABLAS — ELIMINACIÓN DE TABLAS
DROP TABLE Comenta;
DROP TABLE Tiene_Genero;
DROP TABLE Comentario;
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

-- idArtista NULLABLE: una canción puede no tener artista registrado
CREATE TABLE Cancion (
    idCancion       NUMBER(10),
    tituloCancion   VARCHAR(200)    NOT NULL,
    duracion        NUMBER(10)      NOT NULL,
    año             DATE            NOT NULL,
    idArtista       NUMBER(10)
);

-- Tabla asociativa 
CREATE TABLE Tiene_Genero (
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

-- Atributo multivaluado
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
    idUsuario           NUMBER(10)      NOT NULL,
    idCancion           NUMBER(10)
);

-- Atributo multivaluado
CREATE TABLE Publicacion_TipoContenido (
    idPublicacion   NUMBER(10)      NOT NULL,
    tipoContenido   VARCHAR(20)     NOT NULL
);

CREATE TABLE Comentario (
    idComentario    NUMBER(10),
    contenido       VARCHAR(255)    NOT NULL,
    fecha           DATE            NOT NULL,
    likes           NUMBER(10)      NOT NULL,
    idPublicacion   NUMBER(10)      NOT NULL
);

-- Tabla asociativa 
CREATE TABLE Comenta (
    idUsuario       NUMBER(10)      NOT NULL,
    idComentario    NUMBER(10)      NOT NULL
);

CREATE TABLE Historial_Musical (
    idRegistro          NUMBER(10),
    fechaRegistro       DATE            NOT NULL,
    notaPersonal        VARCHAR(255),
    idCancion           NUMBER(10),
    idUsuario           NUMBER(10)      NOT NULL
);

-- Atributo multivaluado
CREATE TABLE Historial_Periodo (
    idRegistro      NUMBER(10)      NOT NULL,
    periodo         DATE            NOT NULL
);

-- Atributo multivaluado
CREATE TABLE Historial_Emocion (
    idRegistro      NUMBER(10)      NOT NULL,
    emocion         VARCHAR(20)     NOT NULL
);

-- GRAN CONCEPTO: RECOMENDACIÓN

-- Recomendación puede quedar sin autor (usuario eliminado)
-- idUsuarioDestino sin FK: decisión de diseño, se preserva el destino aunque el usuario sea eliminado
CREATE TABLE Recomendacion (
    idRecomendacion         NUMBER(10),
    fechaRecomendacion      DATE            NOT NULL,
    mensajeRecomendacion    VARCHAR(255)    NOT NULL,
    tipoRecomendacion       VARCHAR(20)     NOT NULL,
    idUsuarioRecomendador   NUMBER(10),
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
    idUsuario           NUMBER(10)      NOT NULL,
    idUsuarioBloqueado  NUMBER(10)      NOT NULL,
    fechaBloqueo        DATE            NOT NULL,
    motivoBloqueo       VARCHAR(255)
);

-- GRAN CONCEPTO: MODERACIÓN & REPORTE

-- idUsuarioReportante NULLABLE: el reportante puede ser anónimo o eliminado
CREATE TABLE Reporte (
    idReporte               NUMBER(10),
    idUsuarioReportante     NUMBER(10),
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
    idUsuarioReportado  NUMBER(10)      NOT NULL
);

--  GRAN CONCEPTO: BÚSQUEDA & DESCUBRIMIENTO

-- idUsuario NULLABLE: el historial puede quedar sin usuario (usuario eliminado)
CREATE TABLE HistorialBusqueda (
    idBusqueda          NUMBER(10),
    terminoBusqueda     VARCHAR(255)    NOT NULL,
    fechaBusqueda       DATE            NOT NULL,
    idUsuario           NUMBER(10)
);

CREATE TABLE FiltroBusqueda (
    idFiltro            NUMBER(10),
    fechaIntento        DATE            NOT NULL,
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
    ADD CONSTRAINT pk_cancion PRIMARY KEY (idCancion);

ALTER TABLE Tiene_Genero
    ADD CONSTRAINT pk_tiene_genero PRIMARY KEY (idCancion, idGenero);

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

ALTER TABLE Comentario
    ADD CONSTRAINT pk_comentario PRIMARY KEY (idComentario);

ALTER TABLE Comenta
    ADD CONSTRAINT pk_comenta PRIMARY KEY (idUsuario, idComentario);

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

ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT uk_config_usuario UNIQUE (idUsuario);

ALTER TABLE ListaNegra
    ADD CONSTRAINT pk_lista_negra PRIMARY KEY (idBloqueo);

--------------- GRAN CONCEPTO: MODERACION & REPORTE ----------------------------------

ALTER TABLE Reporte
    ADD CONSTRAINT pk_reporte PRIMARY KEY (idReporte);

ALTER TABLE Sancion
    ADD CONSTRAINT pk_sancion PRIMARY KEY (idSancion);

--------------- GRAN CONCEPTO: BUSQUEDA & DESCUBRIMIENTO ----------------------------------

ALTER TABLE HistorialBusqueda
    ADD CONSTRAINT pk_historialBusqueda PRIMARY KEY (idBusqueda);

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT pk_FiltroBusqueda PRIMARY KEY (idFiltro);

---------------------------FK LLAVES-------------------------------------

--------------- GRAN CONCEPTO: CANCION ----------------------------------

ALTER TABLE Cancion
    ADD CONSTRAINT fk_Cancion_Artista FOREIGN KEY (idArtista) REFERENCES Artista(idArtista)
        ON DELETE SET NULL;

ALTER TABLE Tiene_Genero
    ADD CONSTRAINT fk_TG_Cancion FOREIGN KEY (idCancion) REFERENCES Cancion(idCancion)
        ON DELETE CASCADE;

ALTER TABLE Tiene_Genero
    ADD CONSTRAINT fk_TG_Genero FOREIGN KEY (idGenero) REFERENCES Genero(idGenero)
        ON DELETE CASCADE;

--------------- GRAN CONCEPTO: USUARIO ----------------------------------

ALTER TABLE Usuario_Streaming
    ADD CONSTRAINT fk_US_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
        ON DELETE CASCADE;

ALTER TABLE UsuarioBasico
    ADD CONSTRAINT fk_UsuarioBasico FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
        ON DELETE CASCADE;

ALTER TABLE UsuarioMembresia
    ADD CONSTRAINT fk_UsuarioMembresia FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
        ON DELETE CASCADE;

--------------- GRAN CONCEPTO: HUELLA MUSICAL ----------------------------------

ALTER TABLE Publicacion
    ADD CONSTRAINT fk_Publicacion_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
        ON DELETE CASCADE;

ALTER TABLE Publicacion
    ADD CONSTRAINT fk_Publicacion_Cancion FOREIGN KEY (idCancion) REFERENCES Cancion(idCancion)
        ON DELETE SET NULL;

ALTER TABLE Publicacion_TipoContenido
    ADD CONSTRAINT fk_PTC_Publicacion FOREIGN KEY (idPublicacion) REFERENCES Publicacion(idPublicacion)
        ON DELETE CASCADE;

ALTER TABLE Comentario
    ADD CONSTRAINT fk_Comentario_Publicacion FOREIGN KEY (idPublicacion) REFERENCES Publicacion(idPublicacion)
        ON DELETE CASCADE;

ALTER TABLE Comenta
    ADD CONSTRAINT fk_Comenta_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
        ON DELETE CASCADE;

ALTER TABLE Comenta
    ADD CONSTRAINT fk_Comenta_Comentario FOREIGN KEY (idComentario) REFERENCES Comentario(idComentario)
        ON DELETE CASCADE;

ALTER TABLE Historial_Musical
    ADD CONSTRAINT fk_HM_Cancion FOREIGN KEY (idCancion) REFERENCES Cancion(idCancion)
        ON DELETE SET NULL;

ALTER TABLE Historial_Musical
    ADD CONSTRAINT fk_HM_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
        ON DELETE CASCADE;

-- Historial_Periodo
ALTER TABLE Historial_Periodo
    ADD CONSTRAINT fk_HP_Historial FOREIGN KEY (idRegistro) REFERENCES Historial_Musical(idRegistro)
        ON DELETE CASCADE;

-- Historial_Emocion
ALTER TABLE Historial_Emocion
    ADD CONSTRAINT fk_HE_Historial FOREIGN KEY (idRegistro) REFERENCES Historial_Musical(idRegistro)
        ON DELETE CASCADE;

--------------- GRAN CONCEPTO: RECOMENDACION ----------------------------------

ALTER TABLE Recomendacion
    ADD CONSTRAINT fk_Reco_Recomendador FOREIGN KEY (idUsuarioRecomendador) REFERENCES Usuario(idUsuario)
        ON DELETE SET NULL;

ALTER TABLE Recomendacion
    ADD CONSTRAINT fk_Reco_Cancion FOREIGN KEY (idCancion) REFERENCES Cancion(idCancion)
        ON DELETE SET NULL;

--------------- GRAN CONCEPTO: CONFIGURACION & PRIVACIDAD ----------------------------------

ALTER TABLE ConfiguracionUsuario
    ADD CONSTRAINT fk_Config_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
        ON DELETE CASCADE;

-- idUsuarioBloqueado sin FK por decisión de diseño
ALTER TABLE ListaNegra
    ADD CONSTRAINT fk_LN_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
        ON DELETE CASCADE;

--------------- GRAN CONCEPTO: MODERACION & REPORTE ----------------------------------

-- ON DELETE SET NULL: si el reportante es eliminado, el reporte se preserva sin autor
ALTER TABLE Reporte
    ADD CONSTRAINT fk_Reporte_Reportante FOREIGN KEY (idUsuarioReportante) REFERENCES Usuario(idUsuario)
        ON DELETE SET NULL;

-- idUsuarioReportado sin FK por decisión de diseño

-- Sancion.idReporte: NO ACTION — el trigger trg_reporte_delete bloquea la eliminación de reportes con sanciones
ALTER TABLE Sancion
    ADD CONSTRAINT fk_Sancion_Reporte FOREIGN KEY (idReporte) REFERENCES Reporte(idReporte);

-- idUsuarioReportado en Sancion sin FK por decisión de diseño

--------------- GRAN CONCEPTO: BUSQUEDA & DESCUBRIMIENTO ----------------------------------

-- ON DELETE SET NULL: el historial de búsqueda se preserva aunque el usuario sea eliminado
ALTER TABLE HistorialBusqueda
    ADD CONSTRAINT fk_HB_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
        ON DELETE SET NULL;

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Genero FOREIGN KEY (idGenero) REFERENCES Genero(idGenero)
        ON DELETE SET NULL;

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Artista FOREIGN KEY (idArtista) REFERENCES Artista(idArtista)
        ON DELETE SET NULL;

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Historial FOREIGN KEY (idRegistro) REFERENCES Historial_Musical(idRegistro)
        ON DELETE SET NULL;

ALTER TABLE FiltroBusqueda
    ADD CONSTRAINT fk_FB_Busqueda FOREIGN KEY (idBusqueda) REFERENCES HistorialBusqueda(idBusqueda);

--------------------------------------------------------------
----------------------- PoblarOk -----------------------------
--------------------------------------------------------------

-- GRAN CONCEPTO: CANCIÓN

INSERT INTO Genero VALUES (1, 'Rock', 'Musica con guitarras electricas y baterias');
INSERT INTO Genero VALUES (2, 'Pop', 'Musica popular de consumo masivo');
INSERT INTO Genero VALUES (3, 'Jazz', 'Genero afroamericano de improvisacion');
INSERT INTO Genero VALUES (4, 'Reggaeton','Ritmo urbano de origen caribeño');
INSERT INTO Genero VALUES (5, 'Clasica', 'Musica academica de tradicion occidental');

INSERT INTO Artista VALUES (1, 'The Beatles', 'Reino Unido', TO_DATE('1960-01-01','YYYY-MM-DD'));
INSERT INTO Artista VALUES (2, 'Taylor Swift', 'Estados Unidos', TO_DATE('2006-06-01','YYYY-MM-DD'));
INSERT INTO Artista VALUES (3, 'Bad Bunny', 'Puerto Rico', TO_DATE('2016-01-01','YYYY-MM-DD'));
INSERT INTO Artista VALUES (4, 'Miles Davis', 'Estados Unidos', TO_DATE('1944-01-01','YYYY-MM-DD'));
INSERT INTO Artista VALUES (5, 'Rosalia', 'España', TO_DATE('2017-01-01','YYYY-MM-DD'));

INSERT INTO Cancion VALUES (1, 'Let It Be', 243, TO_DATE('1970-05-08','YYYY-MM-DD'), 1);
INSERT INTO Cancion VALUES (2, 'Anti-Hero', 200, TO_DATE('2022-10-21','YYYY-MM-DD'), 2);
INSERT INTO Cancion VALUES (3, 'Titi Me Pregunto', 196, TO_DATE('2022-06-10','YYYY-MM-DD'), 3);
INSERT INTO Cancion VALUES (4, 'Kind of Blue', 562, TO_DATE('1959-08-17','YYYY-MM-DD'), 4);
INSERT INTO Cancion VALUES (5, 'Malamente', 194, TO_DATE('2017-05-26','YYYY-MM-DD'), 5);

INSERT INTO Tiene_Genero VALUES (1, 1);
INSERT INTO Tiene_Genero VALUES (2, 2);
INSERT INTO Tiene_Genero VALUES (3, 4);
INSERT INTO Tiene_Genero VALUES (4, 3);
INSERT INTO Tiene_Genero VALUES (5, 1);

-- GRAN CONCEPTO: USUARIO

INSERT INTO Usuario VALUES (1, 'juangomez',  'juan@gmail.com',   'Password1', TO_DATE('2023-01-15','YYYY-MM-DD'), 'Fan del rock');
INSERT INTO Usuario VALUES (2, 'mariaperez', 'maria@gmail.com',  'Segura456', TO_DATE('2023-03-20','YYYY-MM-DD'), NULL);
INSERT INTO Usuario VALUES (3, 'carlos88',   'carlos@gmail.com', 'Jazz4Ever', TO_DATE('2023-06-10','YYYY-MM-DD'), 'Amante del jazz');
INSERT INTO Usuario VALUES (4, 'adminUser',  'admin@app.com',    'Admin1234', TO_DATE('2022-11-01','YYYY-MM-DD'), 'Administrador');
INSERT INTO Usuario VALUES (5, 'testUser5',  'test5@app.com',    'Test5678x', TO_DATE('2024-02-01','YYYY-MM-DD'), NULL);

INSERT INTO Usuario_Streaming VALUES (1, 'spotify');
INSERT INTO Usuario_Streaming VALUES (2, 'apple_music');
INSERT INTO Usuario_Streaming VALUES (3, 'youtube_music');
INSERT INTO Usuario_Streaming VALUES (4, 'deezer');
INSERT INTO Usuario_Streaming VALUES (5, 'tidal');

INSERT INTO UsuarioBasico VALUES (3);
INSERT INTO UsuarioBasico VALUES (5);

INSERT INTO UsuarioMembresia VALUES (1, TO_DATE('2024-01-01','YYYY-MM-DD'), NULL,'activa', 'premium');
INSERT INTO UsuarioMembresia VALUES (2, TO_DATE('2023-06-01','YYYY-MM-DD'), TO_DATE('2024-06-01','YYYY-MM-DD'), 'inactiva','basica');
INSERT INTO UsuarioMembresia VALUES (4, TO_DATE('2024-03-01','YYYY-MM-DD'), NULL, 'activa', 'familia');

-- GRAN CONCEPTO: HUELLA MUSICAL

INSERT INTO Publicacion VALUES (1, 'Clásico atemporal de los 70s', TO_DATE('2024-05-01','YYYY-MM-DD'), 0, 1, 1);
INSERT INTO Publicacion VALUES (2, 'Taylor vuelve a dominar',       TO_DATE('2024-06-15','YYYY-MM-DD'), 0, 2, 2);
INSERT INTO Publicacion VALUES (3, 'El reggaeton sigue fuerte',     TO_DATE('2024-07-20','YYYY-MM-DD'), 0, 3, 3);
INSERT INTO Publicacion VALUES (4, 'Miles Davis es inmortal',       TO_DATE('2024-08-01','YYYY-MM-DD'), 0, 4, 4);
INSERT INTO Publicacion VALUES (5, 'Rosalia fusiona flamenco',      TO_DATE('2024-09-05','YYYY-MM-DD'), 0, 1, 5);

INSERT INTO Publicacion_TipoContenido VALUES (1, 'cancion');
INSERT INTO Publicacion_TipoContenido VALUES (2, 'album');
INSERT INTO Publicacion_TipoContenido VALUES (3, 'artista');
INSERT INTO Publicacion_TipoContenido VALUES (4, 'playlist');
INSERT INTO Publicacion_TipoContenido VALUES (5, 'cancion');

INSERT INTO Comentario VALUES (1, 'Gran cancion clasica!', TO_DATE('2024-05-02','YYYY-MM-DD'), 0, 1);
INSERT INTO Comentario VALUES (2, 'Taylor siempre entrega', TO_DATE('2024-06-16','YYYY-MM-DD'), 0, 2);
INSERT INTO Comentario VALUES (3, 'Bad Bunny dominando', TO_DATE('2024-07-21','YYYY-MM-DD'), 0, 3);

INSERT INTO Comenta VALUES (2, 1);
INSERT INTO Comenta VALUES (3, 2);
INSERT INTO Comenta VALUES (1, 3);

INSERT INTO Historial_Musical VALUES (1, TO_DATE('2024-03-01','YYYY-MM-DD'), 'Me recuerda mi infancia', 1, 1);
INSERT INTO Historial_Musical VALUES (2, TO_DATE('2024-04-10','YYYY-MM-DD'), NULL, 2, 2);
INSERT INTO Historial_Musical VALUES (3, TO_DATE('2024-05-22','YYYY-MM-DD'), 'Excelente ritmo', 3, 3);
INSERT INTO Historial_Musical VALUES (4, TO_DATE('2024-06-14','YYYY-MM-DD'), 'Para concentrarme', 4, 4);
INSERT INTO Historial_Musical VALUES (5, TO_DATE('2024-07-03','YYYY-MM-DD'), 'Descubrimiento nuevo', 5, 1);

INSERT INTO Historial_Periodo VALUES (1, TO_DATE('2024-03-01','YYYY-MM-DD'));
INSERT INTO Historial_Periodo VALUES (2, TO_DATE('2024-04-01','YYYY-MM-DD'));
INSERT INTO Historial_Periodo VALUES (3, TO_DATE('2024-05-01','YYYY-MM-DD'));

INSERT INTO Historial_Emocion VALUES (1, 'feliz');
INSERT INTO Historial_Emocion VALUES (2, 'triste');
INSERT INTO Historial_Emocion VALUES (3, 'animado');

-- GRAN CONCEPTO: RECOMENDACIÓN

INSERT INTO Recomendacion VALUES (1, TO_DATE('2024-06-01','YYYY-MM-DD'), 'Te va a encantar', 'directa', 1, 1, 2, 0);
INSERT INTO Recomendacion VALUES (2, TO_DATE('2024-06-10','YYYY-MM-DD'), 'Escucha esto', 'publica', 2, 2, 3, 0);
INSERT INTO Recomendacion VALUES (3, TO_DATE('2024-07-01','YYYY-MM-DD'), 'Del playlist top', 'comunidad', 3, 3, 1, 0);
INSERT INTO Recomendacion VALUES (4, TO_DATE('2024-08-05','YYYY-MM-DD'), 'Jazz imperdible', 'directa', 4, 4, 1, 1);

-- GRAN CONCEPTO: CONFIGURACIÓN & PRIVACIDAD

INSERT INTO ConfiguracionUsuario VALUES (1, 1, 'todos', 'seguidores', 'todos', 1, 1);
INSERT INTO ConfiguracionUsuario VALUES (2, 0, 'seguidores', 'nadie', 'seguidores', 0, 2);
INSERT INTO ConfiguracionUsuario VALUES (3, 1, 'todos', 'todos', 'todos', 1, 3);
INSERT INTO ConfiguracionUsuario VALUES (4, 1, 'nadie', 'nadie', 'nadie', 0, 4);
INSERT INTO ConfiguracionUsuario VALUES (5, 0, 'seguidores', 'seguidores', 'seguidores', 1, 5);

INSERT INTO ListaNegra VALUES (1, 1, 5, TO_DATE('2024-05-10','YYYY-MM-DD'), 'Comportamiento inapropiado');
INSERT INTO ListaNegra VALUES (2, 2, 4, TO_DATE('2024-06-20','YYYY-MM-DD'), NULL);
INSERT INTO ListaNegra VALUES (3, 3, 5, TO_DATE('2024-07-15','YYYY-MM-DD'), 'Spam continuo');

-- GRAN CONCEPTO: MODERACIÓN & REPORTE

INSERT INTO Reporte VALUES (1, 1, 5, 'spam', 'Publicaciones repetidas de ads', TO_DATE('2024-07-01','YYYY-MM-DD'), 'pendiente');
INSERT INTO Reporte VALUES (2, 3, 4, 'acoso', 'Mensajes agresivos constantes', TO_DATE('2024-07-10','YYYY-MM-DD'), 'revisado');
INSERT INTO Reporte VALUES (3, 2, 5, 'contenido_inapropiado','Imagenes ofensivas en perfil', TO_DATE('2024-08-01','YYYY-MM-DD'), 'resuelto');
INSERT INTO Reporte VALUES (4, 1, 4, 'derechos_autor', 'Subio album sin permiso', TO_DATE('2024-08-15','YYYY-MM-DD'), 'descartado');
INSERT INTO Reporte VALUES (5, 3, 2, 'otro', 'Conducta sospechosa', TO_DATE('2024-09-01','YYYY-MM-DD'), 'pendiente');

INSERT INTO Sancion VALUES (1, 'advertencia', TO_DATE('2024-01-01','YYYY-MM-DD'), TO_DATE('2024-02-01','YYYY-MM-DD'), 'Primera advertencia por spam', 1, 5);
INSERT INTO Sancion VALUES (2, 'suspension_temporal', TO_DATE('2024-03-01','YYYY-MM-DD'), TO_DATE('2024-04-01','YYYY-MM-DD'), 'Suspension por acoso reiterado', 2, 4);

-- GRAN CONCEPTO: BÚSQUEDA & DESCUBRIMIENTO

INSERT INTO HistorialBusqueda VALUES (1, 'The Beatles', TO_DATE('2024-08-01','YYYY-MM-DD'), 1);
INSERT INTO HistorialBusqueda VALUES (2, 'reggaeton 2022', TO_DATE('2024-08-05','YYYY-MM-DD'), 2);
INSERT INTO HistorialBusqueda VALUES (3, 'jazz clasico', TO_DATE('2024-08-10','YYYY-MM-DD'), 3);
INSERT INTO HistorialBusqueda VALUES (4, 'pop latino', TO_DATE('2024-09-01','YYYY-MM-DD'), 4);
INSERT INTO HistorialBusqueda VALUES (5, 'flamenco moderno',TO_DATE('2024-09-10','YYYY-MM-DD'), 1);

INSERT INTO FiltroBusqueda VALUES (1, TO_DATE('2024-08-01','YYYY-MM-DD'), 1, NULL, NULL, 1, NULL, 1);
INSERT INTO FiltroBusqueda VALUES (2, TO_DATE('2024-08-05','YYYY-MM-DD'), 0, NULL, 4, NULL, NULL, 2);
INSERT INTO FiltroBusqueda VALUES (3, TO_DATE('2024-08-10','YYYY-MM-DD'), 1, TO_DATE('2022-01-01','YYYY-MM-DD'),3, NULL, 1, 3);
INSERT INTO FiltroBusqueda VALUES (4, TO_DATE('2024-09-01','YYYY-MM-DD'), 0, NULL, NULL, 3, NULL, 4);
INSERT INTO FiltroBusqueda VALUES (5, TO_DATE('2024-09-10','YYYY-MM-DD'), 1, TO_DATE('2017-01-01','YYYY-MM-DD'),1, 5, 5, 5);

----------------------------------------------------------------------------------------------
-------------------------------------- PoblarNoOk --------------------------------------------
----------------------------------------------------------------------------------------------

------- Gran Concepto: Genero

-- Tipo incorrecto
INSERT INTO Genero VALUES ('TEXTO', 'Electronica', 'Musica sintetica');

-- NOT NULL
INSERT INTO Genero VALUES (10, NULL, 'Sin nombre');

-- PK duplicada
INSERT INTO Genero VALUES (1, 'Duplicado', 'No deberia entrar');

-- NOT NULL
INSERT INTO Artista VALUES (10, 'Artista Sin Pais', NULL, TO_DATE('2000-01-01','YYYY-MM-DD'));

-- PK duplicada
INSERT INTO Artista VALUES (2, 'Copia Swift', 'USA', TO_DATE('2006-01-01','YYYY-MM-DD'));

-- Tipo incorrecto
INSERT INTO Cancion VALUES (99, 'Prueba Tipo', 'LARGA', TO_DATE('2020-01-01','YYYY-MM-DD'), 1);

-- NOT NULL
INSERT INTO Cancion VALUES (99, NULL, 200, TO_DATE('2020-01-01','YYYY-MM-DD'), 1);

-- PK duplicada
INSERT INTO Cancion VALUES (1, 'Copia song', 180, TO_DATE('2020-01-01','YYYY-MM-DD'), 1);

-- FK inexistente (Artista)
INSERT INTO Cancion VALUES (20, 'Sin Artista', 180, TO_DATE('2020-01-01','YYYY-MM-DD'), 999);

----- Gran Concepto: Usuario

-- NOT NULL correo
INSERT INTO Usuario VALUES (10, 'usuarioX', NULL, 'Password1', SYSDATE, NULL);

-- NOT NULL contraseña
INSERT INTO Usuario VALUES (11, 'usuarioY', 'y@mail.com', NULL, SYSDATE, NULL);

-- PK duplicada
INSERT INTO Usuario VALUES (1, 'copiaUser', 'copia@mail.com', 'Password1', SYSDATE, NULL);

-- UNIQUE nombreUsuario
INSERT INTO Usuario VALUES (20, 'juangomez', 'diferente@mail.com', 'Password1', SYSDATE, NULL);

-- UNIQUE correo
INSERT INTO Usuario VALUES (21, 'nuevouser1', 'juan@gmail.com', 'Password1', SYSDATE, NULL);

-- NOT NULL tipoMembresia
INSERT INTO UsuarioMembresia VALUES (3, SYSDATE, NULL, 'activa', NULL);

----- Gran Concepto: Huella Musical

-- PK duplicada
INSERT INTO Publicacion VALUES (1, 'Publicacion duplicada', SYSDATE, 0, 2, NULL);

-- FK usuario inexistente
INSERT INTO Publicacion VALUES (20, 'Usuario inexistente', SYSDATE, 0, 999, NULL);

-- FK canción inexistente
INSERT INTO Publicacion VALUES (21, 'Cancion adjunta inexistente', SYSDATE, 0, 1, 999);

-- PK compuesta duplicada
INSERT INTO Publicacion_TipoContenido VALUES (1, 'cancion');

-- PK duplicada
INSERT INTO Historial_Musical VALUES (1, SYSDATE, 'Duplicado', 1, 1);

-- FK canción inexistente
INSERT INTO Historial_Musical VALUES (20, SYSDATE, NULL, 999, 1);

-- FK usuario inexistente
INSERT INTO Historial_Musical VALUES (21, SYSDATE, NULL, 1, 999);

-- FK inexistente
INSERT INTO Historial_Periodo VALUES (999, TO_DATE('2024-01-01','YYYY-MM-DD'));

-- FK inexistente
INSERT INTO Historial_Emocion VALUES (999, 'feliz');

------ Gran Concepto: Recomendación

-- Tipo incorrecto
INSERT INTO Recomendacion VALUES (99, SYSDATE, 'Tipo invalido', 'directa', 1, 1, 2, 'X');

-- NOT NULL
INSERT INTO Recomendacion VALUES (99, SYSDATE, NULL, 'directa', 1, 1, 2, 0);

-- PK duplicada
INSERT INTO Recomendacion VALUES (1, SYSDATE, 'Duplicada', 'directa', 2, 2, 3, 0);

-- FK canción inexistente
INSERT INTO Recomendacion VALUES (20, SYSDATE, 'Cancion inexistente', 'directa', 1, 999, 2, 0);

-- FK recomendador inexistente
INSERT INTO Recomendacion VALUES (21, SYSDATE, 'Recomendador inexistente', 'directa', 999, 1, 2, 0);

------ Gran Concepto: Configuracion & Privacidad

-- Tipo incorrecto
INSERT INTO ConfiguracionUsuario VALUES (99, 'SI', 'todos', 'todos', 'todos', 1, 1);

-- FK inexistente
INSERT INTO ConfiguracionUsuario VALUES (20, 1, 'todos', 'todos', 'todos', 1, 999);

-- Tipo incorrecto
INSERT INTO ListaNegra VALUES (99, 1, 2, 99999, 'Tipo invalido');

-- PK duplicada
INSERT INTO ListaNegra VALUES (1, 2, 3, SYSDATE, 'Bloqueo duplicado');

-- FK bloqueador inexistente
INSERT INTO ListaNegra VALUES (20, 999, 1, SYSDATE, 'Bloqueador inexistente');

------ Gran Concepto: Moderacion & Reporte

-- NOT NULL
INSERT INTO Reporte VALUES (99, 1, 5, 'spam', 'desc', SYSDATE, NULL);

-- FK inexistente (reportante)
INSERT INTO Reporte VALUES (20, 999, 2, 'spam', 'Reportante inexistente', SYSDATE, 'pendiente');

-- NOT NULL
INSERT INTO Sancion VALUES (99, 'advertencia', SYSDATE, NULL, NULL, 1, 5);

-- FK reporte inexistente
INSERT INTO Sancion VALUES (20, 'advertencia', SYSDATE, NULL, 'Sin reporte padre', 999, 1);

--- Gran Concepto: Busqueda & Descubrimiento

-- FK usuario inexistente
INSERT INTO HistorialBusqueda VALUES (20, 'busqueda huerfana', SYSDATE, 999);

-- NOT NULL
INSERT INTO FiltroBusqueda VALUES (99, SYSDATE, NULL, NULL, NULL, NULL, NULL, 1);

-- PK duplicada
INSERT INTO FiltroBusqueda VALUES (1, SYSDATE, 0, NULL, NULL, NULL, NULL, 1);

-- FK inexistente (Busqueda)
INSERT INTO FiltroBusqueda VALUES (20, SYSDATE, 1, NULL, NULL, NULL, NULL, 999);

-- FK inexistente (Genero)
INSERT INTO FiltroBusqueda VALUES (21, SYSDATE, 0, NULL, 999, NULL, NULL, 1);

----------------------------------------------------------------------------------------------
-------------------------------------- XPoblar --------------------------------------------
----------------------------------------------------------------------------------------------
-- GRAN CONCEPTO: BÚSQUEDA & DESCUBRIMIENTO
DELETE FROM FiltroBusqueda;
DELETE FROM HistorialBusqueda;

-- GRAN CONCEPTO: MODERACIÓN & REPORTE
DELETE FROM Sancion;
DELETE FROM Reporte;

-- GRAN CONCEPTO: CONFIGURACIÓN & PRIVACIDAD
DELETE FROM ListaNegra;
DELETE FROM ConfiguracionUsuario;

-- GRAN CONCEPTO: RECOMENDACIÓN
DELETE FROM Recomendacion;

-- GRAN CONCEPTO: HUELLA MUSICAL
DELETE FROM Comenta;
DELETE FROM Comentario;
DELETE FROM Historial_Emocion;
DELETE FROM Historial_Periodo;
DELETE FROM Historial_Musical;
DELETE FROM Publicacion_TipoContenido;
DELETE FROM Publicacion;

-- GRAN CONCEPTO: USUARIO
DELETE FROM UsuarioMembresia;
DELETE FROM UsuarioBasico;
DELETE FROM Usuario_Streaming;
DELETE FROM Usuario;

-- GRAN CONCEPTO: CANCIÓN
DELETE FROM Tiene_Genero;
DELETE FROM Cancion;
DELETE FROM Artista;
DELETE FROM Genero;
