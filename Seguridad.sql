------------------------------------------------------------------------
---------------------------- Seguridad ---------------------------------
-- Orden: Estructura y Restricciones -> Restricciones de Integridad
--        -> Indices y Vistas -> Componentes -> Seguridad
-- Requiere vistas de Indices y Vistas.sql
------------------------------------------------------------------------

----------------------------------------------------------
---------------- ActoresE---------------------------------
----------------------------------------------------------

-- PA_ADMIN_CONTENIDO_MUSICAL
CREATE OR REPLACE PACKAGE PA_ADMIN_CONTENIDO_MUSICAL AS

    PROCEDURE eliminar_genero(
        p_idGenero IN Genero.idGenero%TYPE
    );

    PROCEDURE actualizar_genero(
        p_idGenero IN Genero.idGenero%TYPE,
        p_nombre IN Genero.nombreGenero%TYPE,
        p_descripcion IN Genero.descripcion%TYPE
    );

    PROCEDURE eliminar_artista(
        p_idArtista IN Artista.idArtista%TYPE
    );

    PROCEDURE actualizar_artista(
        p_idArtista IN Artista.idArtista%TYPE,
        p_nombre IN Artista.nombre%TYPE,
        p_pais IN Artista.paisOrigen%TYPE
    );

    PROCEDURE asignar_genero_cancion(
        p_idCancion IN Tiene_Genero.idCancion%TYPE,
        p_idGenero IN Tiene_Genero.idGenero%TYPE
    );

    PROCEDURE quitar_genero_cancion(
        p_idCancion IN Tiene_Genero.idCancion%TYPE,
        p_idGenero IN Tiene_Genero.idGenero%TYPE
    );

END PA_ADMIN_CONTENIDO_MUSICAL;
/

-- PA_ARTISTA
CREATE OR REPLACE PACKAGE PA_ARTISTA AS

    PROCEDURE insertar_artista(
        p_nombre IN Artista.nombre%TYPE,
        p_pais IN Artista.paisOrigen%TYPE,
        p_añoDebut  IN Artista.añoDebut%TYPE
    );

    PROCEDURE actualizar_artista(
        p_idArtista IN Artista.idArtista%TYPE,
        p_nombre IN Artista.nombre%TYPE,
        p_pais IN Artista.paisOrigen%TYPE
    );

    PROCEDURE eliminar_artista(
        p_idArtista IN Artista.idArtista%TYPE
    );

    PROCEDURE consultar_artista(
        p_idArtista IN Artista.idArtista%TYPE,
        p_nombre OUT Artista.nombre%TYPE,
        p_pais OUT Artista.paisOrigen%TYPE,
        p_añoDebut OUT Artista.añoDebut%TYPE
    );

    PROCEDURE consultar_canciones_artista(
        p_idArtista IN  Artista.idArtista%TYPE,
        p_cursor OUT SYS_REFCURSOR
    );

    PROCEDURE consultar_usuarios_escuchan_canciones_mes(
        p_idArtista IN  Artista.idArtista%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    );
 
    PROCEDURE consultar_artistas_mas_escuchados(
        p_cursor OUT SYS_REFCURSOR
    );

END PA_ARTISTA;
/

-- PA_USUARIO
CREATE OR REPLACE PACKAGE PA_USUARIO AS

    PROCEDURE insertar_usuario(
        p_nombreUsuario IN Usuario.nombreUsuario%TYPE,
        p_correo IN Usuario.correo%TYPE,
        p_contraseña IN Usuario.contraseña%TYPE,
        p_descripcionPerfil IN Usuario.descripcionPerfil%TYPE
    );

    PROCEDURE actualizar_usuario(
        p_idUsuario IN Usuario.idUsuario%TYPE,
        p_correo IN Usuario.correo%TYPE,
        p_contraseña IN Usuario.contraseña%TYPE,
        p_descripcionPerfil IN Usuario.descripcionPerfil%TYPE
    );

    PROCEDURE eliminar_usuario(
        p_idUsuario IN Usuario.idUsuario%TYPE
    );

    PROCEDURE consultar_usuario(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_nombreUsuario OUT Usuario.nombreUsuario%TYPE,
        p_correo OUT Usuario.correo%TYPE,
        p_descripcionPerfil OUT Usuario.descripcionPerfil%TYPE
    );

    PROCEDURE consultar_publicaciones_mas_likes_mes(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    );

    PROCEDURE consultar_historial_musical_mas_escuchado(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    );
 
    PROCEDURE consultar_cantidad_publicaciones_periodo(
        p_idUsuario   IN  Usuario.idUsuario%TYPE,
        p_fechaInicio IN  DATE,
        p_fechaFin    IN  DATE,
        p_cursor      OUT SYS_REFCURSOR
    );
 
    PROCEDURE consultar_usuarios_bloqueados(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    );
 
    PROCEDURE consultar_quienes_pueden_ver_publicaciones(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    );

    PROCEDURE consultar_veces_bloqueado(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    );
 
    PROCEDURE consultar_recomendaciones_recibidas_mes(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    );
 
    PROCEDURE consultar_recomendaciones_por_tipo(
        p_idUsuario       IN  Usuario.idUsuario%TYPE,
        p_tipoRecomendacion IN Recomendacion.tipoRecomendacion%TYPE,
        p_cursor          OUT SYS_REFCURSOR
    );
 
    PROCEDURE consultar_usuarios_mas_recomendaciones(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    );

    PROCEDURE crear_publicacion(
        p_contenido IN Publicacion.contenido%TYPE,
        p_idUsuario IN Publicacion.idUsuario%TYPE,
        p_idCancion IN Publicacion.idCancion%TYPE
    );
 
    PROCEDURE modificar_publicacion(
        p_idPublicacion IN Publicacion.idPublicacion%TYPE,
        p_contenido     IN Publicacion.contenido%TYPE
    );
 
    PROCEDURE eliminar_publicacion(
        p_idPublicacion IN Publicacion.idPublicacion%TYPE
    );
 
    PROCEDURE consultar_publicaciones(
        p_idUsuario IN  Publicacion.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    );
 
    PROCEDURE crear_recomendacion(
        p_mensaje   IN Recomendacion.mensajeRecomendacion%TYPE,
        p_tipo      IN Recomendacion.tipoRecomendacion%TYPE,
        p_idDestino IN Recomendacion.idUsuarioDestino%TYPE,
        p_idUsuario IN Recomendacion.idUsuarioRecomendador%TYPE,
        p_idCancion IN Recomendacion.idCancion%TYPE
    );
 
    PROCEDURE crear_filtro_busqueda(
        p_terminoBusqueda IN HistorialBusqueda.terminoBusqueda%TYPE,
        p_periodo         IN FiltroBusqueda.periodo%TYPE,
        p_exito           IN FiltroBusqueda.exito%TYPE,
        p_idUsuario       IN HistorialBusqueda.idUsuario%TYPE
    );
 
    PROCEDURE modificar_filtro_busqueda(
        p_idFiltro        IN FiltroBusqueda.idFiltro%TYPE,
        p_terminoBusqueda IN HistorialBusqueda.terminoBusqueda%TYPE,
        p_exito           IN FiltroBusqueda.exito%TYPE
    );
 
    PROCEDURE eliminar_filtro_busqueda(
        p_idFiltro IN FiltroBusqueda.idFiltro%TYPE
    );
 
    PROCEDURE bloquear_usuario(
        p_idUsuarioBloqueado IN ListaNegra.idUsuarioBloqueado%TYPE,
        p_motivoBloqueo      IN ListaNegra.motivoBloqueo%TYPE,
        p_idUsuario          IN ListaNegra.idUsuario%TYPE
    );
 
    PROCEDURE desbloquear_usuario(
        p_idBloqueo IN ListaNegra.idBloqueo%TYPE
    );

END PA_USUARIO;
/

-- PA_ADMIN_USUARIOS
CREATE OR REPLACE PACKAGE PA_ADMIN_USUARIOS AS
 
    PROCEDURE crear_usuario(
        p_nombreUsuario     IN Usuario.nombreUsuario%TYPE,
        p_correo            IN Usuario.correo%TYPE,
        p_contraseña        IN Usuario.contraseña%TYPE,
        p_descripcionPerfil IN Usuario.descripcionPerfil%TYPE
    );
 
    PROCEDURE modificar_usuario(
        p_idUsuario         IN Usuario.idUsuario%TYPE,
        p_correo            IN Usuario.correo%TYPE,
        p_contraseña        IN Usuario.contraseña%TYPE,
        p_descripcionPerfil IN Usuario.descripcionPerfil%TYPE
    );
 
    PROCEDURE eliminar_usuario(
        p_idUsuario IN Usuario.idUsuario%TYPE
    );
 
    PROCEDURE consultar_usuario(
        p_idUsuario         IN  Usuario.idUsuario%TYPE,
        p_cursor            OUT SYS_REFCURSOR
    );
 
    PROCEDURE crear_recomendacion(
        p_mensaje   IN Recomendacion.mensajeRecomendacion%TYPE,
        p_tipo      IN Recomendacion.tipoRecomendacion%TYPE,
        p_idDestino IN Recomendacion.idUsuarioDestino%TYPE,
        p_idUsuario IN Recomendacion.idUsuarioRecomendador%TYPE,
        p_idCancion IN Recomendacion.idCancion%TYPE
    );
 
    PROCEDURE eliminar_recomendacion(
        p_idRecomendacion IN Recomendacion.idRecomendacion%TYPE
    );
 
    PROCEDURE suspender_usuario(
        p_idUsuario IN UsuarioMembresia.idUsuario%TYPE
    );
 
    PROCEDURE reactivar_usuario(
        p_idUsuario IN UsuarioMembresia.idUsuario%TYPE
    );
 
    PROCEDURE asignar_usuario_basico(
        p_idUsuario IN UsuarioBasico.idUsuario%TYPE
    );
 
    PROCEDURE consultar_usuarios_activos(
        p_cursor OUT SYS_REFCURSOR
    );
 
    PROCEDURE consultar_historial_busquedas_mes(
        p_cursor OUT SYS_REFCURSOR
    );
 
    PROCEDURE consultar_terminos_mas_buscados(
        p_cursor OUT SYS_REFCURSOR
    );
 
    PROCEDURE consultar_busquedas_fallidas(
        p_fechaInicio IN DATE,
        p_fechaFin    IN DATE,
        p_cursor      OUT SYS_REFCURSOR
    );
 
END PA_ADMIN_USUARIOS;
/

-- PA_MODERADOR_USUARIOS
CREATE OR REPLACE PACKAGE PA_MODERADOR_USUARIOS AS

    PROCEDURE insertar_reporte(
        p_idReportante IN Reporte.idUsuarioReportante%TYPE,
        p_idReportado IN Reporte.idUsuarioReportado%TYPE,
        p_motivo IN Reporte.motivoReporte%TYPE,
        p_descripcion IN Reporte.descripcionReporte%TYPE
    );

    PROCEDURE actualizar_estado_reporte(
        p_idReporte IN Reporte.idReporte%TYPE,
        p_estado IN Reporte.estadoReporte%TYPE
    );

    PROCEDURE eliminar_reporte(
        p_idReporte IN Reporte.idReporte%TYPE
    );

    PROCEDURE insertar_sancion(
        p_tipo IN Sancion.tipoSancion%TYPE,
        p_fechaFin IN Sancion.fechaFin%TYPE,
        p_motivo IN Sancion.motivoSancion%TYPE,
        p_idReporte IN Sancion.idReporte%TYPE,
        p_idUsuario IN Sancion.idUsuarioReportado%TYPE
    );

    PROCEDURE eliminar_sancion(
        p_idSancion IN Sancion.idSancion%TYPE
    );
     
    PROCEDURE consultar_reportes_recibidos_mes(
        p_cursor OUT SYS_REFCURSOR
    );
 
    PROCEDURE consultar_sanciones_activas_tipo(
        p_tipoSancion IN Sancion.tipoSancion%TYPE,
        p_cursor      OUT SYS_REFCURSOR
    );
 
    PROCEDURE consultar_usuarios_mas_reportados(
        p_cursor OUT SYS_REFCURSOR
    );

END PA_MODERADOR_USUARIOS;
/

----------------------------------------------------
-------------------- ActorI ------------------------
----------------------------------------------------

-- PA_USUARIO
CREATE OR REPLACE PACKAGE BODY PA_USUARIO AS

    PROCEDURE insertar_usuario(
        p_nombreUsuario IN Usuario.nombreUsuario%TYPE,
        p_correo IN Usuario.correo%TYPE,
        p_contraseña IN Usuario.contraseña%TYPE,
        p_descripcionPerfil IN Usuario.descripcionPerfil%TYPE
    ) AS
    BEGIN
        INSERT INTO Usuario (nombreUsuario, correo, contraseña, fechaRegistro, descripcionPerfil)
        VALUES (p_nombreUsuario, p_correo, p_contraseña, SYSDATE, p_descripcionPerfil);
        COMMIT;
    END insertar_usuario;

    PROCEDURE actualizar_usuario(
        p_idUsuario IN Usuario.idUsuario%TYPE,
        p_correo IN Usuario.correo%TYPE,
        p_contraseña IN Usuario.contraseña%TYPE,
        p_descripcionPerfil IN Usuario.descripcionPerfil%TYPE
    ) AS
    BEGIN
        UPDATE Usuario
        SET correo = p_correo,
            contraseña = p_contraseña,
            descripcionPerfil = p_descripcionPerfil
        WHERE idUsuario = p_idUsuario;
        COMMIT;
    END actualizar_usuario;

    PROCEDURE eliminar_usuario(
        p_idUsuario IN Usuario.idUsuario%TYPE
    ) AS
    BEGIN
        DELETE FROM Usuario WHERE idUsuario = p_idUsuario;
        COMMIT;
    END eliminar_usuario;

    PROCEDURE consultar_usuario(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_nombreUsuario OUT Usuario.nombreUsuario%TYPE,
        p_correo OUT Usuario.correo%TYPE,
        p_descripcionPerfil OUT Usuario.descripcionPerfil%TYPE
    ) AS
    BEGIN
        SELECT nombreUsuario, correo, descripcionPerfil
        INTO p_nombreUsuario, p_correo, p_descripcionPerfil
        FROM Usuario
        WHERE idUsuario = p_idUsuario;
    END consultar_usuario;
    
    PROCEDURE consultar_publicaciones_mas_likes_mes(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT idPublicacion, contenido, likes,
                   tipoContenido, fechaPublicacion
            FROM TopPublicacionesLikes
            WHERE idUsuario = p_idUsuario
            ORDER BY likes DESC;
    END consultar_publicaciones_mas_likes_mes;
 
    PROCEDURE consultar_historial_musical_mas_escuchado(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT idRegistro, idCancion, tituloCancion,
                   idArtista, fechaRegistro
            FROM Canciones_HistorialMusical
            WHERE idUsuario = p_idUsuario
            ORDER BY fechaRegistro DESC;
    END consultar_historial_musical_mas_escuchado;
 
    PROCEDURE consultar_cantidad_publicaciones_periodo(
        p_idUsuario   IN  Usuario.idUsuario%TYPE,
        p_fechaInicio IN  DATE,
        p_fechaFin    IN  DATE,
        p_cursor      OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT idUsuario,
                   COUNT(*)              AS total_publicaciones,
                   MAX(fechaPublicacion) AS ultima_publicacion
            FROM CantidadPublicaciones
            WHERE idUsuario = p_idUsuario
              AND fechaPublicacion BETWEEN p_fechaInicio AND p_fechaFin
            GROUP BY idUsuario;
    END consultar_cantidad_publicaciones_periodo;
 
    PROCEDURE consultar_usuarios_bloqueados(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT idUsuarioBloqueado, nombreUsuario,
                   fechaBloqueo, motivoBloqueo
            FROM UsuariosBloqueados
            WHERE idUsuario = p_idUsuario
            ORDER BY fechaBloqueo DESC;
    END consultar_usuarios_bloqueados;
 
    PROCEDURE consultar_quienes_pueden_ver_publicaciones(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    ) AS
    BEGIN
        -- La configuración "quienVePublicaciones" define quién accede al contenido
        OPEN p_cursor FOR
            SELECT idUsuario, perfilPublico,
                   quienVePublicaciones, notificacionesActivas
            FROM vista_ConfiguracionUsuario
            WHERE idUsuario = p_idUsuario;
    END consultar_quienes_pueden_ver_publicaciones;
 
    PROCEDURE consultar_veces_bloqueado(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT COUNT(*)           AS veces_bloqueado,
                   MAX(fechaBloqueo)  AS ultimo_bloqueo
            FROM VecesBloqueado
            WHERE idUsuarioBloqueado = p_idUsuario;
    END consultar_veces_bloqueado;
 
    PROCEDURE consultar_recomendaciones_recibidas_mes(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT mensajeRecomendacion, tipoRecomendacion, fechaRecomendacion
            FROM RecomendacionesRecibidas
            WHERE idUsuarioDestino = p_idUsuario
            ORDER BY fechaRecomendacion DESC;
    END consultar_recomendaciones_recibidas_mes;
 
    PROCEDURE consultar_recomendaciones_por_tipo(
        p_idUsuario         IN  Usuario.idUsuario%TYPE,
        p_tipoRecomendacion IN  Recomendacion.tipoRecomendacion%TYPE,
        p_cursor            OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT tipoRecomendacion,
                   COUNT(*) AS total
            FROM RecomendacionesPorTipo
            WHERE idUsuarioDestino = p_idUsuario
              AND tipoRecomendacion = p_tipoRecomendacion
            GROUP BY tipoRecomendacion
            ORDER BY total DESC;
    END consultar_recomendaciones_por_tipo;
 
    PROCEDURE consultar_usuarios_mas_recomendaciones(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT nombreUsuario,
                   COUNT(*)                AS total_recomendaciones,
                   MAX(fechaRecomendacion) AS ultima_fecha
            FROM QuienMasRecomienda
            WHERE idUsuarioDestino = p_idUsuario
            GROUP BY idUsuario, nombreUsuario
            ORDER BY total_recomendaciones DESC;
    END consultar_usuarios_mas_recomendaciones;
    
    PROCEDURE crear_publicacion(
        p_contenido IN Publicacion.contenido%TYPE,
        p_idUsuario IN Publicacion.idUsuario%TYPE,
        p_idCancion IN Publicacion.idCancion%TYPE
    ) AS
    BEGIN
        INSERT INTO Publicacion (contenido, fechaPublicacion, likes, idUsuario, idCancion)
        VALUES (p_contenido, SYSDATE, 0, p_idUsuario, p_idCancion);
        COMMIT;
    END crear_publicacion;
 
    PROCEDURE modificar_publicacion(
        p_idPublicacion IN Publicacion.idPublicacion%TYPE,
        p_contenido     IN Publicacion.contenido%TYPE
    ) AS
    BEGIN
        UPDATE Publicacion
        SET contenido = p_contenido
        WHERE idPublicacion = p_idPublicacion;
        COMMIT;
    END modificar_publicacion;
 
    PROCEDURE eliminar_publicacion(
        p_idPublicacion IN Publicacion.idPublicacion%TYPE
    ) AS
    BEGIN
        DELETE FROM Publicacion WHERE idPublicacion = p_idPublicacion;
        COMMIT;
    END eliminar_publicacion;
 
    PROCEDURE consultar_publicaciones(
        p_idUsuario IN  Publicacion.idUsuario%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT idPublicacion, contenido, likes, fechaPublicacion
            FROM   Publicacion
            WHERE  idUsuario = p_idUsuario
            ORDER BY fechaPublicacion DESC;
    END consultar_publicaciones;
  
    PROCEDURE crear_recomendacion(
        p_mensaje IN Recomendacion.mensajeRecomendacion%TYPE,
        p_tipo IN Recomendacion.tipoRecomendacion%TYPE,
        p_idDestino IN Recomendacion.idUsuarioDestino%TYPE,
        p_idUsuario IN Recomendacion.idUsuarioRecomendador%TYPE,
        p_idCancion IN Recomendacion.idCancion%TYPE
    ) AS
    BEGIN
        INSERT INTO Recomendacion (
            mensajeRecomendacion, tipoRecomendacion,
            fechaRecomendacion, visualizacion,
            idUsuarioDestino, idUsuarioRecomendador, idCancion
        )
        VALUES (
            p_mensaje, p_tipo,
            SYSDATE, 0,
            p_idDestino, p_idUsuario, p_idCancion
        );
        COMMIT;
    END crear_recomendacion;
 
    -- ── Búsquedas ──────────────────────────────────────────
 
    PROCEDURE crear_filtro_busqueda(
        p_terminoBusqueda IN HistorialBusqueda.terminoBusqueda%TYPE,
        p_periodo IN FiltroBusqueda.periodo%TYPE,
        p_exito IN FiltroBusqueda.exito%TYPE,
        p_idUsuario IN HistorialBusqueda.idUsuario%TYPE
    ) AS
        v_idBusqueda HistorialBusqueda.idBusqueda%TYPE;
    BEGIN
    
        INSERT INTO HistorialBusqueda (terminoBusqueda, fechaBusqueda, idUsuario)
        VALUES (p_terminoBusqueda, SYSDATE, p_idUsuario)
        RETURNING idBusqueda INTO v_idBusqueda;
 
        INSERT INTO FiltroBusqueda (
            exito, fechaIntento, periodo, idBusqueda
        )
        VALUES (
            p_exito, SYSDATE, p_periodo, v_idBusqueda
        );
        COMMIT;
    END crear_filtro_busqueda;
 
    PROCEDURE modificar_filtro_busqueda(
        p_idFiltro        IN FiltroBusqueda.idFiltro%TYPE,
        p_terminoBusqueda IN HistorialBusqueda.terminoBusqueda%TYPE,
        p_exito           IN FiltroBusqueda.exito%TYPE
    ) AS
        v_idBusqueda FiltroBusqueda.idBusqueda%TYPE;
    BEGIN
        SELECT idBusqueda INTO v_idBusqueda
        FROM FiltroBusqueda WHERE idFiltro = p_idFiltro;
 
        UPDATE HistorialBusqueda
        SET terminoBusqueda = p_terminoBusqueda
        WHERE idBusqueda = v_idBusqueda;
 
        UPDATE FiltroBusqueda
        SET exito = p_exito
        WHERE idFiltro = p_idFiltro;
        COMMIT;
    END modificar_filtro_busqueda;
 
    PROCEDURE eliminar_filtro_busqueda(
        p_idFiltro IN FiltroBusqueda.idFiltro%TYPE
    ) AS
    BEGIN
        DELETE FROM FiltroBusqueda WHERE idFiltro = p_idFiltro;
        COMMIT;
    END eliminar_filtro_busqueda;
  
    PROCEDURE bloquear_usuario(
        p_idUsuarioBloqueado IN ListaNegra.idUsuarioBloqueado%TYPE,
        p_motivoBloqueo      IN ListaNegra.motivoBloqueo%TYPE,
        p_idUsuario          IN ListaNegra.idUsuario%TYPE
    ) AS
    BEGIN
        INSERT INTO ListaNegra (idUsuario, idUsuarioBloqueado, fechaBloqueo, motivoBloqueo)
        VALUES (p_idUsuario, p_idUsuarioBloqueado, SYSDATE, p_motivoBloqueo);
        COMMIT;
    END bloquear_usuario;
 
    PROCEDURE desbloquear_usuario(
        p_idBloqueo IN ListaNegra.idBloqueo%TYPE
    ) AS
    BEGIN
        DELETE FROM ListaNegra WHERE idBloqueo = p_idBloqueo;
        COMMIT;
    END desbloquear_usuario;

END PA_USUARIO;
/

-- PA_ADMIN_USUARIOS
CREATE OR REPLACE PACKAGE BODY PA_ADMIN_USUARIOS AS
 
    PROCEDURE crear_usuario(
        p_nombreUsuario IN Usuario.nombreUsuario%TYPE,
        p_correo IN Usuario.correo%TYPE,
        p_contraseña IN Usuario.contraseña%TYPE,
        p_descripcionPerfil IN Usuario.descripcionPerfil%TYPE
    ) AS
    BEGIN
        INSERT INTO Usuario (nombreUsuario, correo, contraseña, fechaRegistro, descripcionPerfil)
        VALUES (p_nombreUsuario, p_correo, p_contraseña, SYSDATE, p_descripcionPerfil);
        COMMIT;
    END crear_usuario;
 
    PROCEDURE modificar_usuario(
        p_idUsuario IN Usuario.idUsuario%TYPE,
        p_correo IN Usuario.correo%TYPE,
        p_contraseña IN Usuario.contraseña%TYPE,
        p_descripcionPerfil IN Usuario.descripcionPerfil%TYPE
    ) AS
    BEGIN
        UPDATE Usuario
        SET correo = p_correo,
            contraseña = p_contraseña,
            descripcionPerfil = p_descripcionPerfil
        WHERE idUsuario = p_idUsuario;
        COMMIT;
    END modificar_usuario;
 
    PROCEDURE eliminar_usuario(
        p_idUsuario IN Usuario.idUsuario%TYPE
    ) AS
    BEGIN
        DELETE FROM Usuario WHERE idUsuario = p_idUsuario;
        COMMIT;
    END eliminar_usuario;
 
    PROCEDURE consultar_usuario(
        p_idUsuario IN  Usuario.idUsuario%TYPE,
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT idUsuario, nombreUsuario, correo,
                   fechaRegistro, descripcionPerfil
            FROM   Usuario
            WHERE  idUsuario = p_idUsuario;
    END consultar_usuario;
  
    PROCEDURE crear_recomendacion(
        p_mensaje   IN Recomendacion.mensajeRecomendacion%TYPE,
        p_tipo IN Recomendacion.tipoRecomendacion%TYPE,
        p_idDestino IN Recomendacion.idUsuarioDestino%TYPE,
        p_idUsuario IN Recomendacion.idUsuarioRecomendador%TYPE,
        p_idCancion IN Recomendacion.idCancion%TYPE
    ) AS
    BEGIN
        INSERT INTO Recomendacion (
            mensajeRecomendacion, tipoRecomendacion,
            fechaRecomendacion, visualizacion,
            idUsuarioDestino, idUsuarioRecomendador, idCancion
        )
        VALUES (
            p_mensaje, p_tipo,
            SYSDATE, 0,
            p_idDestino, p_idUsuario, p_idCancion
        );
        COMMIT;
    END crear_recomendacion;
 
    PROCEDURE eliminar_recomendacion(
        p_idRecomendacion IN Recomendacion.idRecomendacion%TYPE
    ) AS
    BEGIN
        DELETE FROM Recomendacion WHERE idRecomendacion = p_idRecomendacion;
        COMMIT;
    END eliminar_recomendacion;
  
    PROCEDURE suspender_usuario(
        p_idUsuario IN UsuarioMembresia.idUsuario%TYPE
    ) AS
    BEGIN
        UPDATE UsuarioMembresia
        SET estadoMembresia = 'suspendida'
        WHERE idUsuario = p_idUsuario;
        COMMIT;
    END suspender_usuario;
 
    PROCEDURE reactivar_usuario(
        p_idUsuario IN UsuarioMembresia.idUsuario%TYPE
    ) AS
    BEGIN
        UPDATE UsuarioMembresia
        SET estadoMembresia = 'activa'
        WHERE idUsuario = p_idUsuario;
        COMMIT;
    END reactivar_usuario;
 
    PROCEDURE asignar_usuario_basico(
        p_idUsuario IN UsuarioBasico.idUsuario%TYPE
    ) AS
    BEGIN
        INSERT INTO UsuarioBasico (idUsuario) VALUES (p_idUsuario);
        COMMIT;
    END asignar_usuario_basico;
 
    PROCEDURE consultar_usuarios_activos(
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT u.idUsuario, u.nombreUsuario, u.correo,
                   m.tipoMembresia, m.fechaInicioMembresia
            FROM   Usuario u
            JOIN   UsuarioMembresia m ON u.idUsuario = m.idUsuario
            WHERE  m.estadoMembresia = 'activa'
            ORDER BY u.nombreUsuario;
    END consultar_usuarios_activos;
 
    PROCEDURE consultar_historial_busquedas_mes(
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT idBusqueda, terminoBusqueda, fechaBusqueda, exito
            FROM   HistorialUltimoMes
            ORDER BY fechaBusqueda DESC;
    END consultar_historial_busquedas_mes;
 
    -- CORREGIDO: usa HistorialBusqueda (todos los intentos),
    -- no BusquedasFallidas (solo las sin éxito)
    PROCEDURE consultar_terminos_mas_buscados(
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT hb.terminoBusqueda,
                   COUNT(*)             AS total_intentos,
                   MAX(hb.fechaBusqueda) AS ultima_busqueda
            FROM   HistorialBusqueda hb
            GROUP BY hb.terminoBusqueda
            ORDER BY total_intentos DESC;
    END consultar_terminos_mas_buscados;
 
    PROCEDURE consultar_busquedas_fallidas(
        p_fechaInicio IN DATE,
        p_fechaFin IN DATE,
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT idBusqueda, terminoBusqueda, fechaBusqueda, exito
            FROM   BusquedasFallidas
            WHERE  fechaBusqueda BETWEEN p_fechaInicio AND p_fechaFin
            ORDER BY fechaBusqueda DESC;
    END consultar_busquedas_fallidas;
 
END PA_ADMIN_USUARIOS;
/

-- PA_MODERADOR_USUARIOS
CREATE OR REPLACE PACKAGE BODY PA_MODERADOR_USUARIOS AS

    PROCEDURE insertar_reporte(
        p_idReportante IN Reporte.idUsuarioReportante%TYPE,
        p_idReportado IN Reporte.idUsuarioReportado%TYPE,
        p_motivo IN Reporte.motivoReporte%TYPE,
        p_descripcion IN Reporte.descripcionReporte%TYPE
    ) AS
    BEGIN
        INSERT INTO Reporte (
            idUsuarioReportante, idUsuarioReportado,
            motivoReporte, descripcionReporte,
            fechaReporte, estadoReporte
        )
        VALUES (
            p_idReportante, p_idReportado,
            p_motivo, p_descripcion,
            SYSDATE, 'pendiente'
        );
        COMMIT;
    END insertar_reporte;

    PROCEDURE actualizar_estado_reporte(
        p_idReporte IN Reporte.idReporte%TYPE,
        p_estado IN Reporte.estadoReporte%TYPE
    ) AS
    BEGIN
        UPDATE Reporte
        SET estadoReporte = p_estado
        WHERE idReporte = p_idReporte;
        COMMIT;
    END actualizar_estado_reporte;

    PROCEDURE eliminar_reporte(
        p_idReporte IN Reporte.idReporte%TYPE
    ) AS
    BEGIN
        DELETE FROM Reporte
        WHERE idReporte = p_idReporte;
        COMMIT;
    END eliminar_reporte;

    PROCEDURE insertar_sancion(
        p_tipo IN Sancion.tipoSancion%TYPE,
        p_fechaFin IN Sancion.fechaFin%TYPE,
        p_motivo IN Sancion.motivoSancion%TYPE,
        p_idReporte IN Sancion.idReporte%TYPE,
        p_idUsuario IN Sancion.idUsuarioReportado%TYPE
    ) AS
    BEGIN
        INSERT INTO Sancion (
            tipoSancion, fechaInicio, fechaFin,
            motivoSancion, idReporte, idUsuarioReportado
        )
        VALUES (
            p_tipo, SYSDATE, p_fechaFin,
            p_motivo, p_idReporte, p_idUsuario
        );
        COMMIT;
    END insertar_sancion;

    PROCEDURE eliminar_sancion(
        p_idSancion IN Sancion.idSancion%TYPE
    ) AS
    BEGIN
        DELETE FROM Sancion
        WHERE idSancion = p_idSancion;
        COMMIT;
    END eliminar_sancion;

    PROCEDURE consultar_reportes_recibidos_mes(
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT idUsuarioReportado, nombreUsuario,
                   motivoReporte, estadoReporte, fechaReporte
            FROM ReportesUltimoMes
            ORDER BY fechaReporte DESC;
    END consultar_reportes_recibidos_mes;
 
    PROCEDURE consultar_sanciones_activas_tipo(
        p_tipoSancion IN Sancion.tipoSancion%TYPE,
        p_cursor      OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT tipoSancion, motivoSancion, fechaInicio, fechaFin
            FROM SancionesActivas
            WHERE tipoSancion = p_tipoSancion
            ORDER BY fechaInicio DESC;
    END consultar_sanciones_activas_tipo;
 
    PROCEDURE consultar_usuarios_mas_reportados(
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT idUsuarioReportado,
                   nombreUsuario,
                   COUNT(idReporte) AS total_reportes
            FROM TopUsuariosReportados
            GROUP BY idUsuarioReportado, nombreUsuario
            ORDER BY total_reportes DESC;
    END consultar_usuarios_mas_reportados;

END PA_MODERADOR_USUARIOS;
/

-- PA_ADMIN_CONTENIDO_MUSICAL
CREATE OR REPLACE PACKAGE BODY PA_ADMIN_CONTENIDO_MUSICAL AS

    PROCEDURE eliminar_genero(
        p_idGenero IN Genero.idGenero%TYPE
    ) AS
    BEGIN
        DELETE FROM Genero
        WHERE idGenero = p_idGenero;
        COMMIT;
    END eliminar_genero;

    PROCEDURE actualizar_genero(
        p_idGenero IN Genero.idGenero%TYPE,
        p_nombre IN Genero.nombreGenero%TYPE,
        p_descripcion IN Genero.descripcion%TYPE
    ) AS
    BEGIN
        UPDATE Genero
        SET nombreGenero = p_nombre,
            descripcion = p_descripcion
        WHERE idGenero = p_idGenero;
        COMMIT;
    END actualizar_genero;

    PROCEDURE eliminar_artista(
        p_idArtista IN Artista.idArtista%TYPE
    ) AS
    BEGIN
        DELETE FROM Artista
        WHERE idArtista = p_idArtista;
        COMMIT;
    END eliminar_artista;

    PROCEDURE actualizar_artista(
        p_idArtista IN Artista.idArtista%TYPE,
        p_nombre IN Artista.nombre%TYPE,
        p_pais IN Artista.paisOrigen%TYPE
    ) AS
    BEGIN
        UPDATE Artista
        SET nombre = p_nombre,
            paisOrigen = p_pais
        WHERE idArtista = p_idArtista;
        COMMIT;
    END actualizar_artista;

    PROCEDURE asignar_genero_cancion(
        p_idCancion IN Tiene_Genero.idCancion%TYPE,
        p_idGenero IN Tiene_Genero.idGenero%TYPE
    ) AS
    BEGIN
        INSERT INTO Tiene_Genero (idCancion, idGenero)
        VALUES (p_idCancion, p_idGenero);
        COMMIT;
    END asignar_genero_cancion;

    PROCEDURE quitar_genero_cancion(
        p_idCancion IN Tiene_Genero.idCancion%TYPE,
        p_idGenero IN Tiene_Genero.idGenero%TYPE
    ) AS
    BEGIN
        DELETE FROM Tiene_Genero
        WHERE idCancion = p_idCancion
        AND idGenero = p_idGenero;
        COMMIT;
    END quitar_genero_cancion;

END PA_ADMIN_CONTENIDO_MUSICAL;
/

-- PA_ARTISTA
CREATE OR REPLACE PACKAGE BODY PA_ARTISTA AS
 
    PROCEDURE insertar_artista(
        p_nombre IN Artista.nombre%TYPE,
        p_pais IN Artista.paisOrigen%TYPE,
        p_añoDebut IN Artista.añoDebut%TYPE
    ) AS
    BEGIN
        INSERT INTO Artista (nombre, paisOrigen, añoDebut)
        VALUES (p_nombre, p_pais, p_añoDebut);
        COMMIT;
    END insertar_artista;
 
    PROCEDURE actualizar_artista(
        p_idArtista IN Artista.idArtista%TYPE,
        p_nombre IN Artista.nombre%TYPE,
        p_pais IN Artista.paisOrigen%TYPE
    ) AS
    BEGIN
        UPDATE Artista
        SET nombre = p_nombre,
            paisOrigen = p_pais
        WHERE idArtista = p_idArtista;
        COMMIT;
    END actualizar_artista;
 
    PROCEDURE eliminar_artista(
        p_idArtista IN Artista.idArtista%TYPE
    ) AS
    BEGIN
        DELETE FROM Artista WHERE idArtista = p_idArtista;
        COMMIT;
    END eliminar_artista;
 
    PROCEDURE consultar_artista(
        p_idArtista IN  Artista.idArtista%TYPE,
        p_nombre OUT Artista.nombre%TYPE,
        p_pais OUT Artista.paisOrigen%TYPE,
        p_añoDebut  OUT Artista.añoDebut%TYPE
    ) AS
    BEGIN
        SELECT nombre, paisOrigen, añoDebut
        INTO   p_nombre, p_pais, p_añoDebut
        FROM   Artista
        WHERE  idArtista = p_idArtista;
    END consultar_artista;
 
    PROCEDURE consultar_canciones_artista(
        p_idArtista IN  Artista.idArtista%TYPE,
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT idCancion, tituloCancion, duracion, año
            FROM Cancion
            WHERE  idArtista = p_idArtista
            ORDER BY año DESC;
    END consultar_canciones_artista;
 
    PROCEDURE consultar_usuarios_escuchan_canciones_mes(
        p_idArtista IN  Artista.idArtista%TYPE,
        p_cursor    OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT nombreUsuario,
                   COUNT(idRegistro) AS veces_escuchado
            FROM UsuariosEscuchanArtista
            WHERE idArtista = p_idArtista
            GROUP BY nombreUsuario
            ORDER BY veces_escuchado DESC;
    END consultar_usuarios_escuchan_canciones_mes;
 
    PROCEDURE consultar_artistas_mas_escuchados(
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT nombre,
                   nombreGenero,
                   COUNT(idRegistro) AS total_reproducciones
            FROM   ArtistaMasEscuchado
            GROUP BY nombre, nombreGenero
            ORDER BY total_reproducciones DESC;
    END consultar_artistas_mas_escuchados;
 
END PA_ARTISTA;
/

------------------------------------------------------------
---------------------- ActoresOk----------------------------
------------------------------------------------------------

------------------- PA_ADMIN_USUARIOS
-- UPDATE: Suspender
BEGIN
    PA_ADMIN_USUARIOS.suspender_usuario(p_idUsuario => 1);
    DBMS_OUTPUT.PUT_LINE('OK - suspender_usuario');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - suspender_usuario: ');
END;
/

-- UPDATE: Reactivar
BEGIN
    PA_ADMIN_USUARIOS.reactivar_usuario(p_idUsuario => 1);
    DBMS_OUTPUT.PUT_LINE('OK - reactivar_usuario');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - reactivar_usuario: ');
END;
/

-- INSERT: Usuario básico
BEGIN
    PA_ADMIN_USUARIOS.asignar_usuario_basico(p_idUsuario => 2);
    DBMS_OUTPUT.PUT_LINE('OK - asignar_usuario_basico');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - asignar_usuario_basico: ');
END;
/

-- READ: Usuarios activos (cursor)
DECLARE
    v_cursor SYS_REFCURSOR;
    v_idUsuario Usuario.idUsuario%TYPE;
    v_nombre Usuario.nombreUsuario%TYPE;
    v_correo Usuario.correo%TYPE;
    v_tipo UsuarioMembresia.tipoMembresia%TYPE;
    v_fechaInicio UsuarioMembresia.fechaInicioMembresia%TYPE;
BEGIN
    PA_ADMIN_USUARIOS.consultar_usuarios_activos(p_cursor => v_cursor);
    LOOP
        FETCH v_cursor INTO v_idUsuario, v_nombre, v_correo, v_tipo, v_fechaInicio;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('  Usuario activo: ' || v_nombre || ' | ' || v_tipo);
    END LOOP;
    CLOSE v_cursor;
    DBMS_OUTPUT.PUT_LINE('OK - consultar_usuarios_activos');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_usuarios_activos: ');
END;
/

-----------------  PA_MODERADOR_USUARIOS
-- INSERT: Reporte
BEGIN
    PA_MODERADOR_USUARIOS.insertar_reporte(
        p_idReportante => 1,
        p_idReportado => 3,
        p_motivo => 'contenido_inapropiado',
        p_descripcion => 'El usuario publica contenido inapropiado repetidamente'
    );
    DBMS_OUTPUT.PUT_LINE('OK - insertar_reporte');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - insertar_reporte: ');
END;
/

-- UPDATE: Estado del reporte
BEGIN
    PA_MODERADOR_USUARIOS.actualizar_estado_reporte(
        p_idReporte => 1,
        p_estado => 'resuelto'
    );
    DBMS_OUTPUT.PUT_LINE('OK - actualizar_estado_reporte');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - actualizar_estado_reporte: ');
END;
/

-- INSERT: Sanción
BEGIN
    PA_MODERADOR_USUARIOS.insertar_sancion(
        p_tipo => 'suspension_temporal',
        p_fechaFin => ADD_MONTHS(SYSDATE, 1),
        p_motivo => 'Reincidencia en contenido ofensivo',
        p_idReporte => 1,
        p_idUsuario => 3
    );
    DBMS_OUTPUT.PUT_LINE('OK - insertar_sancion');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - insertar_sancion: ');
END;
/

-- DELETE: Sanción
BEGIN
    PA_MODERADOR_USUARIOS.eliminar_sancion(p_idSancion => 1);
    DBMS_OUTPUT.PUT_LINE('OK - eliminar_sancion');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_sancion: ');
END;
/

-- DELETE: Reporte
BEGIN
    PA_MODERADOR_USUARIOS.eliminar_reporte(p_idReporte => 1);
    DBMS_OUTPUT.PUT_LINE('OK - eliminar_reporte');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_reporte: ');
END;
/


------------------ PA_ADMIN_CONTENIDO_MUSICAL
-- UPDATE: Género
BEGIN
    PA_ADMIN_CONTENIDO_MUSICAL.actualizar_genero(
        p_idGenero => 1,
        p_nombre => 'Reggaeton Moderno',
        p_descripcion => 'Evolución contemporánea del reggaeton clásico'
    );
    DBMS_OUTPUT.PUT_LINE('OK - actualizar_genero');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - actualizar_genero: ');
END;
/

-- UPDATE: Artista
BEGIN
    PA_ADMIN_CONTENIDO_MUSICAL.actualizar_artista(
        p_idArtista => 1,
        p_nombre => 'Bad Bunny (Benito)',
        p_pais => 'Puerto Rico'
    );
    DBMS_OUTPUT.PUT_LINE('OK - actualizar_artista');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - actualizar_artista: ');
END;
/

-- INSERT: Asignar género a canción
BEGIN
    PA_ADMIN_CONTENIDO_MUSICAL.asignar_genero_cancion(
        p_idCancion => 1,
        p_idGenero => 1
    );
    DBMS_OUTPUT.PUT_LINE('OK - asignar_genero_cancion');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - asignar_genero_cancion: ');
END;
/

-- DELETE: Quitar género de canción
BEGIN
    PA_ADMIN_CONTENIDO_MUSICAL.quitar_genero_cancion(
        p_idCancion => 1,
        p_idGenero => 1
    );
    DBMS_OUTPUT.PUT_LINE('OK - quitar_genero_cancion');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - quitar_genero_cancion: ');
END;
/

-- DELETE: Género
BEGIN
    PA_ADMIN_CONTENIDO_MUSICAL.eliminar_genero(p_idGenero => 1);
    DBMS_OUTPUT.PUT_LINE('OK - eliminar_genero');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_genero: ');
END;
/

-- DELETE: Artista
BEGIN
    PA_ADMIN_CONTENIDO_MUSICAL.eliminar_artista(p_idArtista => 1);
    DBMS_OUTPUT.PUT_LINE('OK - eliminar_artista');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_artista: ');
END;
/
-------------- PA_ARTISTA

-- INSERT
BEGIN
    PA_ARTISTA.insertar_artista(
        p_nombre => 'Karol G',
        p_pais => 'Colombia',
        p_añoDebut => TO_DATE('2010-01-01', 'YYYY-MM-DD')
    );
    DBMS_OUTPUT.PUT_LINE('OK - insertar_artista (PA_ARTISTA)');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - insertar_artista (PA_ARTISTA): ');
END;
/

-- UPDATE
BEGIN
    PA_ARTISTA.actualizar_artista(
        p_idArtista => 2,
        p_nombre => 'Karol G (Carolina)',
        p_pais => 'Colombia'
    );
    DBMS_OUTPUT.PUT_LINE('OK - actualizar_artista (PA_ARTISTA)');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - actualizar_artista (PA_ARTISTA): ');
END;
/

-- READ
DECLARE
    v_nombre Artista.nombre%TYPE;
    v_pais Artista.paisOrigen%TYPE;
    v_añoDebut Artista.añoDebut%TYPE;
BEGIN
    PA_ARTISTA.consultar_artista(
        p_idArtista => 2,
        p_nombre => v_nombre,
        p_pais => v_pais,
        p_añoDebut => v_añoDebut
    );
    DBMS_OUTPUT.PUT_LINE('OK - consultar_artista: ' || v_nombre || ' | ' || v_pais || ' | ' || v_añoDebut);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_artista: ');
END;
/

-- READ: Canciones del artista (cursor)
DECLARE
    v_cursor SYS_REFCURSOR;
    v_idCancion Cancion.idCancion%TYPE;
    v_titulo Cancion.tituloCancion%TYPE;
    v_duracion Cancion.duracion%TYPE;
    v_año Cancion.año%TYPE;
BEGIN
    PA_ARTISTA.consultar_canciones_artista(
        p_idArtista => 2,
        p_cursor    => v_cursor
    );
    LOOP
        FETCH v_cursor INTO v_idCancion, v_titulo, v_duracion, v_año;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('  Cancion: ' || v_titulo || ' | ' || v_año);
    END LOOP;
    CLOSE v_cursor;
    DBMS_OUTPUT.PUT_LINE('OK - consultar_canciones_artista');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_canciones_artista: ');
END;
/

-- DELETE
BEGIN
    PA_ARTISTA.eliminar_artista(p_idArtista => 2);
    DBMS_OUTPUT.PUT_LINE('OK - eliminar_artista (PA_ARTISTA)');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_artista (PA_ARTISTA): ');
END;
/

-------------------- PA_USUARIO
-- INSERT
BEGIN
    PA_USUARIO.insertar_usuario(
        p_nombreUsuario => 'juanito123',
        p_correo => 'juanito@email.com',
        p_contraseña => 'pass1234',
        p_descripcionPerfil => 'Amante de la música'
    );
    DBMS_OUTPUT.PUT_LINE('OK - insertar_usuario');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - insertar_usuario: ');
END;
/

-- UPDATE
BEGIN
    PA_USUARIO.actualizar_usuario(
        p_idUsuario => 1,
        p_correo => 'juanito_nuevo@email.com',
        p_contraseña => 'nuevapass99',
        p_descripcionPerfil => 'Fan del reggaeton'
    );
    DBMS_OUTPUT.PUT_LINE('OK - actualizar_usuario');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - actualizar_usuario: ');
END;
/

-----------------------------------------------
------------- Seguridad -----------------------
-----------------------------------------------

-- Creación de roles
CREATE ROLE administrador_usuarios;
CREATE ROLE moderador_usuarios;
CREATE ROLE admin_contenido_musical;

-- Permisos para administrador de usuarios
GRANT EXECUTE ON PA_USUARIO TO administrador_usuarios;
GRANT EXECUTE ON PA_ADMIN_USUARIOS TO administrador_usuarios;

-- Permisos para moderador
GRANT EXECUTE ON PA_MODERADOR_USUARIOS TO moderador_usuarios;

-- Permisos para administrador de contenido musical
GRANT EXECUTE ON PA_ADMIN_CONTENIDO_MUSICAL TO admin_contenido_musical;
GRANT EXECUTE ON PA_ARTISTA TO admin_contenido_musical;

-----------------------------------------------
---------------- SeguridadOK-------------------
-----------------------------------------------

-- OK: Moderador inserta reporte
BEGIN
    PA_MODERADOR_USUARIOS.insertar_reporte(
        p_idReportante => 1,
        p_idReportado => 2,
        p_motivo => 'spam',
        p_descripcion => 'Publicaciones repetitivas'
    );

    DBMS_OUTPUT.PUT_LINE('OK - moderador autorizado');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - moderador autorizado');
END;
/

-- OK: Administrador de contenido actualiza artista
BEGIN
    PA_ADMIN_CONTENIDO_MUSICAL.actualizar_artista(
        p_idArtista => 1,
        p_nombre => 'Bad Bunny',
        p_pais => 'Puerto Rico'
    );

    DBMS_OUTPUT.PUT_LINE('OK - admin contenido autorizado');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - admin contenido autorizado');
END;
/

-- ERROR esperado: moderador intentando acceder a administración musical
BEGIN
    PA_ADMIN_CONTENIDO_MUSICAL.eliminar_genero(
        p_idGenero => 1
    );

    DBMS_OUTPUT.PUT_LINE('ERROR - acceso no restringido');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('OK - acceso restringido correctamente');
END;
/

-- ERROR esperado: administrador musical intentando moderar usuarios
BEGIN
    PA_MODERADOR_USUARIOS.eliminar_reporte(
        p_idReporte => 1
    );

    DBMS_OUTPUT.PUT_LINE('ERROR - acceso no restringido');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('OK - acceso restringido correctamente');
END;
/

------------------------------------------------------------
-----------------------XSEGURIDAD---------------------------
------------------------------------------------------------

-- Revocación de permisos
REVOKE EXECUTE ON PA_USUARIO FROM administrador_usuarios;
REVOKE EXECUTE ON PA_ADMIN_USUARIOS FROM administrador_usuarios;
REVOKE EXECUTE ON PA_MODERADOR_USUARIOS FROM moderador_usuarios;
REVOKE EXECUTE ON PA_ADMIN_CONTENIDO_MUSICAL FROM admin_contenido_musical;
REVOKE EXECUTE ON PA_ARTISTA FROM admin_contenido_musical;

-- Eliminación de roles
DROP ROLE administrador_usuarios;
DROP ROLE moderador_usuarios;
DROP ROLE admin_contenido_musical;

DROP PACKAGE PA_ADMIN_CONTENIDO_MUSICAL;
DROP PACKAGE PA_ARTISTA;
DROP PACKAGE PA_ADMIN_USUARIOS;
DROP PACKAGE PA_USUARIO;
DROP PACKAGE PA_MODERADOR_USUARIOS;