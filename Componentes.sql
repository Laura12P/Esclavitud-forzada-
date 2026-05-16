--------------------------------------------------------------
---------------------- Componentes ---------------------------
--------------------------------------------------------------

-----------------------------------------------------------
---------------------- CRUDE-------------------------------
-----------------------------------------------------------

--PA_CATALOGO_CANCIONES
CREATE OR REPLACE PACKAGE PA_CATALOGO_CANCIONES AS

    PROCEDURE insertar_cancion(
        p_titulo IN Cancion.tituloCancion%TYPE,
        p_duracion IN Cancion.duracion%TYPE,
        p_año IN Cancion.año%TYPE,
        p_idArtista IN Cancion.idArtista%TYPE
    );

    PROCEDURE actualizar_cancion(
        p_idCancion IN Cancion.idCancion%TYPE,
        p_titulo IN Cancion.tituloCancion%TYPE,
        p_duracion IN Cancion.duracion%TYPE,
        p_año IN Cancion.año%TYPE
    );

    PROCEDURE eliminar_cancion(
        p_idCancion IN Cancion.idCancion%TYPE
    );

    PROCEDURE consultar_cancion(
        p_idCancion IN  Cancion.idCancion%TYPE,
        p_titulo OUT Cancion.tituloCancion%TYPE,
        p_duracion OUT Cancion.duracion%TYPE,
        p_año OUT Cancion.año%TYPE
    );

    PROCEDURE insertar_genero(
        p_nombre IN Genero.nombreGenero%TYPE,
        p_descripcion IN Genero.descripcion%TYPE
    );

    PROCEDURE insertar_artista(
        p_nombre IN Artista.nombre%TYPE,
        p_pais IN Artista.paisOrigen%TYPE,
        p_añoDebut IN Artista.añoDebut%TYPE
    );

END PA_CATALOGO_CANCIONES;
/

-- PA_PERFIL_USUARIO
CREATE OR REPLACE PACKAGE PA_PERFIL_USUARIO AS

    PROCEDURE agregar_streaming(
        p_idUsuario IN Usuario_Streaming.idUsuario%TYPE,
        p_plataforma IN Usuario_Streaming.plataformaStreaming%TYPE
    );

    PROCEDURE eliminar_streaming(
        p_idUsuario IN Usuario_Streaming.idUsuario%TYPE,
        p_plataforma IN Usuario_Streaming.plataformaStreaming%TYPE
    );

    PROCEDURE asignar_membresia(
        p_idUsuario IN UsuarioMembresia.idUsuario%TYPE,
        p_fechaInicio IN UsuarioMembresia.fechaInicioMembresia%TYPE,
        p_fechaFin IN UsuarioMembresia.fechaFinMembresia%TYPE,
        p_estado IN UsuarioMembresia.estadoMembresia%TYPE,
        p_tipo IN UsuarioMembresia.tipoMembresia%TYPE
    );

    PROCEDURE actualizar_membresia(
        p_idUsuario IN UsuarioMembresia.idUsuario%TYPE,
        p_fechaFin IN UsuarioMembresia.fechaFinMembresia%TYPE,
        p_estado IN UsuarioMembresia.estadoMembresia%TYPE,
        p_tipo IN UsuarioMembresia.tipoMembresia%TYPE
    );

    PROCEDURE consultar_membresia(
        p_idUsuario IN  UsuarioMembresia.idUsuario%TYPE,
        p_estado OUT UsuarioMembresia.estadoMembresia%TYPE,
        p_tipo OUT UsuarioMembresia.tipoMembresia%TYPE,
        p_fechaFin OUT UsuarioMembresia.fechaFinMembresia%TYPE
    );

END PA_PERFIL_USUARIO;
/

-- PA_PUBLICACION
CREATE OR REPLACE PACKAGE PA_PUBLICACION AS

    PROCEDURE insertar_publicacion(
        p_contenido IN Publicacion.contenido%TYPE,
        p_idUsuario IN Publicacion.idUsuario%TYPE,
        p_idCancion IN Publicacion.idCancion%TYPE
    );

    PROCEDURE actualizar_publicacion(
        p_idPublicacion IN Publicacion.idPublicacion%TYPE,
        p_contenido IN Publicacion.contenido%TYPE
    );

    PROCEDURE eliminar_publicacion(
        p_idPublicacion IN Publicacion.idPublicacion%TYPE
    );

    PROCEDURE consultar_publicacion(
        p_idPublicacion IN  Publicacion.idPublicacion%TYPE,
        p_contenido OUT Publicacion.contenido%TYPE,
        p_fecha OUT Publicacion.fechaPublicacion%TYPE,
        p_likes OUT Publicacion.likes%TYPE
    );

    PROCEDURE insertar_comentario(
        p_contenido IN Comentario.contenido%TYPE,
        p_idPublicacion IN Comentario.idPublicacion%TYPE,
        p_idUsuario IN Comenta.idUsuario%TYPE
    );

    PROCEDURE eliminar_comentario(
        p_idComentario IN Comentario.idComentario%TYPE
    );

END PA_PUBLICACION;
/

--PA_RECOMENDACION; 
CREATE OR REPLACE PACKAGE PA_RECOMENDACION AS

    PROCEDURE insertar_recomendacion(
        p_mensaje IN Recomendacion.mensajeRecomendacion%TYPE,
        p_tipo IN Recomendacion.tipoRecomendacion%TYPE,
        p_idUsuario IN Recomendacion.idUsuarioRecomendador%TYPE,
        p_idCancion IN Recomendacion.idCancion%TYPE,
        p_idDestino IN Recomendacion.idUsuarioDestino%TYPE
    );

    PROCEDURE eliminar_recomendacion(
        p_idRecomendacion IN Recomendacion.idRecomendacion%TYPE
    );

    PROCEDURE marcar_visualizada(
        p_idRecomendacion IN Recomendacion.idRecomendacion%TYPE
    );

    PROCEDURE consultar_recomendaciones(
        p_idDestino IN  Recomendacion.idUsuarioDestino%TYPE,
        p_cursor OUT SYS_REFCURSOR
    );

    PROCEDURE actualizar_recomendacion(
         p_idRecomendacion IN Recomendacion.idRecomendacion%TYPE,
         p_mensaje         IN Recomendacion.mensajeRecomendacion%TYPE
    );

END PA_RECOMENDACION;
/

--PA_BUSQUEDAS_USUARIO
CREATE OR REPLACE PACKAGE PA_BUSQUEDAS_USUARIO AS

    PROCEDURE insertar_busqueda(
        p_termino IN HistorialBusqueda.terminoBusqueda%TYPE,
        p_idUsuario IN HistorialBusqueda.idUsuario%TYPE
    );

    PROCEDURE eliminar_busqueda(
        p_idBusqueda IN HistorialBusqueda.idBusqueda%TYPE
    );

    PROCEDURE insertar_filtro(
        p_exito IN FiltroBusqueda.exito%TYPE,
        p_periodo IN FiltroBusqueda.periodo%TYPE,
        p_idGenero IN FiltroBusqueda.idGenero%TYPE,
        p_idArtista IN FiltroBusqueda.idArtista%TYPE,
        p_idRegistro IN FiltroBusqueda.idRegistro%TYPE,
        p_idBusqueda IN FiltroBusqueda.idBusqueda%TYPE
    );

    PROCEDURE eliminar_filtro(
        p_idFiltro IN FiltroBusqueda.idFiltro%TYPE
    );

    PROCEDURE consultar_historial(
        p_idUsuario IN  HistorialBusqueda.idUsuario%TYPE,
        p_cursor OUT SYS_REFCURSOR
    );

END PA_BUSQUEDAS_USUARIO;
/

-- PA_CONFIGURACION_USUARIO
CREATE OR REPLACE PACKAGE PA_CONFIGURACION_USUARIO AS

    PROCEDURE insertar_configuracion(
        p_perfilPublico IN ConfiguracionUsuario.perfilPublico%TYPE,
        p_quienPuedeSeguir IN ConfiguracionUsuario.quienPuedeSeguir%TYPE,
        p_quienVeHistorial IN ConfiguracionUsuario.quienVeHistorial%TYPE,
        p_quienVePublicaciones IN ConfiguracionUsuario.quienVePublicaciones%TYPE,
        p_notificaciones IN ConfiguracionUsuario.notificacionesActivas%TYPE,
        p_idUsuario IN ConfiguracionUsuario.idUsuario%TYPE
    );

    PROCEDURE actualizar_configuracion(
        p_idUsuario IN ConfiguracionUsuario.idUsuario%TYPE,
        p_perfilPublico IN ConfiguracionUsuario.perfilPublico%TYPE,
        p_quienPuedeSeguir IN ConfiguracionUsuario.quienPuedeSeguir%TYPE,
        p_quienVeHistorial IN ConfiguracionUsuario.quienVeHistorial%TYPE,
        p_quienVePublicaciones IN ConfiguracionUsuario.quienVePublicaciones%TYPE,
        p_notificaciones IN ConfiguracionUsuario.notificacionesActivas%TYPE
    );

    PROCEDURE consultar_configuracion(
        p_idUsuario IN ConfiguracionUsuario.idUsuario%TYPE,
        p_perfilPublico OUT ConfiguracionUsuario.perfilPublico%TYPE,
        p_quienPuedeSeguir OUT ConfiguracionUsuario.quienPuedeSeguir%TYPE,
        p_quienVeHistorial OUT ConfiguracionUsuario.quienVeHistorial%TYPE,
        p_quienVePublicaciones OUT ConfiguracionUsuario.quienVePublicaciones%TYPE,
        p_notificaciones OUT ConfiguracionUsuario.notificacionesActivas%TYPE
    );

    PROCEDURE agregar_bloqueo(
        p_idUsuario IN ListaNegra.idUsuario%TYPE,
        p_idUsuarioBloqueado IN ListaNegra.idUsuarioBloqueado%TYPE,
        p_motivo IN ListaNegra.motivoBloqueo%TYPE
    );

    PROCEDURE eliminar_bloqueo(
        p_idBloqueo IN ListaNegra.idBloqueo%TYPE
    );

    PROCEDURE consultar_bloqueados(
        p_idUsuario IN ListaNegra.idUsuario%TYPE,
        p_cursor OUT SYS_REFCURSOR
    );

END PA_CONFIGURACION_USUARIO;
/

-- PA_REPORTES_SANCIONES
CREATE OR REPLACE PACKAGE PA_REPORTES_SANCIONES AS

    PROCEDURE consultar_reportes_pendientes(
        p_cursor OUT SYS_REFCURSOR
    );

    PROCEDURE consultar_sanciones_activas(
        p_cursor OUT SYS_REFCURSOR
    );

    PROCEDURE consultar_reportes_por_usuario(
        p_idUsuario IN Reporte.idUsuarioReportado%TYPE,
        p_cursor OUT SYS_REFCURSOR
    );

    PROCEDURE consultar_sanciones_por_usuario(
        p_idUsuario IN Sancion.idUsuarioReportado%TYPE,
        p_cursor OUT SYS_REFCURSOR
    );

END PA_REPORTES_SANCIONES;
/

-------------------------------------------------
------------------ CRUDI ------------------------
-------------------------------------------------

-- PA_CATALOGO_CANCIONES
CREATE OR REPLACE PACKAGE BODY PA_CATALOGO_CANCIONES AS
 
    PROCEDURE insertar_cancion(
        p_titulo    IN Cancion.tituloCancion%TYPE,
        p_duracion  IN Cancion.duracion%TYPE,
        p_año       IN Cancion.año%TYPE,
        p_idArtista IN Cancion.idArtista%TYPE
    ) AS
    BEGIN
        INSERT INTO Cancion (tituloCancion, duracion, año, idArtista)
        VALUES (p_titulo, p_duracion, p_año, p_idArtista);
        COMMIT;
    END insertar_cancion;
 
    -- ↓ CORREGIDO: p_año agregado
    PROCEDURE actualizar_cancion(
        p_idCancion IN Cancion.idCancion%TYPE,
        p_titulo    IN Cancion.tituloCancion%TYPE,
        p_duracion  IN Cancion.duracion%TYPE,
        p_año       IN Cancion.año%TYPE          -- ← NUEVO
    ) AS
    BEGIN
        UPDATE Cancion
        SET tituloCancion = p_titulo,
            duracion      = p_duracion,
            año           = p_año                -- ← NUEVO
        WHERE idCancion   = p_idCancion;
        COMMIT;
    END actualizar_cancion;
 
    PROCEDURE eliminar_cancion(
        p_idCancion IN Cancion.idCancion%TYPE
    ) AS
    BEGIN
        DELETE FROM Cancion WHERE idCancion = p_idCancion;
        COMMIT;
    END eliminar_cancion;
 
    PROCEDURE consultar_cancion(
        p_idCancion IN  Cancion.idCancion%TYPE,
        p_titulo    OUT Cancion.tituloCancion%TYPE,
        p_duracion  OUT Cancion.duracion%TYPE,
        p_año       OUT Cancion.año%TYPE
    ) AS
    BEGIN
        SELECT tituloCancion, duracion, año
        INTO   p_titulo, p_duracion, p_año
        FROM   Cancion
        WHERE  idCancion = p_idCancion;
    END consultar_cancion;
 
    PROCEDURE insertar_genero(
        p_nombre      IN Genero.nombreGenero%TYPE,
        p_descripcion IN Genero.descripcion%TYPE
    ) AS
    BEGIN
        INSERT INTO Genero (nombreGenero, descripcion)
        VALUES (p_nombre, p_descripcion);
        COMMIT;
    END insertar_genero;
 
    PROCEDURE insertar_artista(
        p_nombre    IN Artista.nombre%TYPE,
        p_pais      IN Artista.paisOrigen%TYPE,
        p_añoDebut  IN Artista.añoDebut%TYPE
    ) AS
    BEGIN
        INSERT INTO Artista (nombre, paisOrigen, añoDebut)
        VALUES (p_nombre, p_pais, p_añoDebut);
        COMMIT;
    END insertar_artista;
 
END PA_CATALOGO_CANCIONES;
/

-- PA_PUBLICACION
CREATE OR REPLACE PACKAGE BODY PA_PUBLICACION AS

    PROCEDURE insertar_publicacion(
        p_contenido IN Publicacion.contenido%TYPE,
        p_idUsuario IN Publicacion.idUsuario%TYPE,
        p_idCancion IN Publicacion.idCancion%TYPE
    ) AS
    BEGIN
        INSERT INTO Publicacion (contenido, fechaPublicacion, likes, idUsuario, idCancion)
        VALUES (p_contenido, SYSDATE, 0, p_idUsuario, p_idCancion);
        COMMIT;
    END insertar_publicacion;

    PROCEDURE actualizar_publicacion(
        p_idPublicacion IN Publicacion.idPublicacion%TYPE,
        p_contenido IN Publicacion.contenido%TYPE
    ) AS
    BEGIN
        UPDATE Publicacion
        SET contenido = p_contenido
        WHERE idPublicacion = p_idPublicacion;
        COMMIT;
    END actualizar_publicacion;

    PROCEDURE eliminar_publicacion(
        p_idPublicacion IN Publicacion.idPublicacion%TYPE
    ) AS
    BEGIN
        DELETE FROM Publicacion WHERE idPublicacion = p_idPublicacion;
        COMMIT;
    END eliminar_publicacion;

    PROCEDURE consultar_publicacion(
        p_idPublicacion IN  Publicacion.idPublicacion%TYPE,
        p_contenido OUT Publicacion.contenido%TYPE,
        p_fecha OUT Publicacion.fechaPublicacion%TYPE,
        p_likes OUT Publicacion.likes%TYPE
    ) AS
    BEGIN
        SELECT contenido, fechaPublicacion, likes
        INTO p_contenido, p_fecha, p_likes
        FROM Publicacion
        WHERE idPublicacion = p_idPublicacion;
    END consultar_publicacion;

    PROCEDURE insertar_comentario(
        p_contenido IN Comentario.contenido%TYPE,
        p_idPublicacion IN Comentario.idPublicacion%TYPE,
        p_idUsuario IN Comenta.idUsuario%TYPE
    ) AS
        v_idComentario Comentario.idComentario%TYPE;
    BEGIN
        INSERT INTO Comentario (contenido, fecha, likes, idPublicacion)
        VALUES (p_contenido, SYSDATE, 0, p_idPublicacion)
        RETURNING idComentario INTO v_idComentario;

        INSERT INTO Comenta (idUsuario, idComentario)
        VALUES (p_idUsuario, v_idComentario);
        COMMIT;
    END insertar_comentario;

    PROCEDURE eliminar_comentario(
        p_idComentario IN Comentario.idComentario%TYPE
    ) AS
    BEGIN
        DELETE FROM Comentario WHERE idComentario = p_idComentario;
        COMMIT;
    END eliminar_comentario;

END PA_PUBLICACION;
/

-- PA_RECOMENDACION
CREATE OR REPLACE PACKAGE BODY PA_RECOMENDACION AS
 
    PROCEDURE insertar_recomendacion(
        p_mensaje IN Recomendacion.mensajeRecomendacion%TYPE,
        p_tipo IN Recomendacion.tipoRecomendacion%TYPE,
        p_idUsuario IN Recomendacion.idUsuarioRecomendador%TYPE,
        p_idCancion IN Recomendacion.idCancion%TYPE,
        p_idDestino IN Recomendacion.idUsuarioDestino%TYPE
    ) AS
    BEGIN
        INSERT INTO Recomendacion (
            fechaRecomendacion, mensajeRecomendacion, tipoRecomendacion,
            idUsuarioRecomendador, idCancion, idUsuarioDestino, visualizacion
        )
        VALUES (SYSDATE, p_mensaje, p_tipo, p_idUsuario, p_idCancion, p_idDestino, 0);
        COMMIT;
    END insertar_recomendacion;
 
    PROCEDURE actualizar_recomendacion(
        p_idRecomendacion IN Recomendacion.idRecomendacion%TYPE,
        p_mensaje IN Recomendacion.mensajeRecomendacion%TYPE
    ) AS
    BEGIN
        UPDATE Recomendacion
        SET mensajeRecomendacion = p_mensaje
        WHERE idRecomendacion = p_idRecomendacion;
        COMMIT;
    END actualizar_recomendacion;
 
    PROCEDURE eliminar_recomendacion(
        p_idRecomendacion IN Recomendacion.idRecomendacion%TYPE
    ) AS
    BEGIN
        DELETE FROM Recomendacion
        WHERE idRecomendacion = p_idRecomendacion;
        COMMIT;
    END eliminar_recomendacion;
 
    PROCEDURE marcar_visualizada(
        p_idRecomendacion IN Recomendacion.idRecomendacion%TYPE
    ) AS
    BEGIN
        UPDATE Recomendacion
        SET visualizacion = 1
        WHERE  idRecomendacion = p_idRecomendacion;
        COMMIT;
    END marcar_visualizada;
 
    PROCEDURE consultar_recomendaciones(
        p_idDestino IN  Recomendacion.idUsuarioDestino%TYPE,
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT r.idRecomendacion, r.mensajeRecomendacion,
                   r.tipoRecomendacion, r.fechaRecomendacion,
                   c.tituloCancion, u.nombreUsuario
            FROM   Recomendacion r
            LEFT JOIN Cancion  c ON r.idCancion = c.idCancion
            LEFT JOIN Usuario  u ON r.idUsuarioRecomendador = u.idUsuario
            WHERE  r.idUsuarioDestino = p_idDestino
            ORDER BY r.fechaRecomendacion DESC;
    END consultar_recomendaciones;
 
END PA_RECOMENDACION;
/

-- PA_BUSQUEDAS_USUARIO
CREATE OR REPLACE PACKAGE BODY PA_BUSQUEDAS_USUARIO AS

    PROCEDURE insertar_busqueda(
        p_termino IN HistorialBusqueda.terminoBusqueda%TYPE,
        p_idUsuario IN HistorialBusqueda.idUsuario%TYPE
    ) AS
    BEGIN
        INSERT INTO HistorialBusqueda (terminoBusqueda, fechaBusqueda, idUsuario)
        VALUES (p_termino, SYSDATE, p_idUsuario);
        COMMIT;
    END insertar_busqueda;

    PROCEDURE eliminar_busqueda(
        p_idBusqueda IN HistorialBusqueda.idBusqueda%TYPE
    ) AS
        v_filtros_restantes NUMBER;
    BEGIN
        DELETE FROM FiltroBusqueda
        WHERE idBusqueda = p_idBusqueda
          AND exito = 0;

        SELECT COUNT(*) INTO v_filtros_restantes
        FROM FiltroBusqueda
        WHERE idBusqueda = p_idBusqueda;

        IF v_filtros_restantes > 0 THEN
            RAISE_APPLICATION_ERROR(-20019,
                'No se puede eliminar la búsqueda: tiene filtros exitosos asociados');
        END IF;

        DELETE FROM HistorialBusqueda
        WHERE idBusqueda = p_idBusqueda;
        COMMIT;
    END eliminar_busqueda;

    PROCEDURE insertar_filtro(
        p_exito IN FiltroBusqueda.exito%TYPE,
        p_periodo IN FiltroBusqueda.periodo%TYPE,
        p_idGenero IN FiltroBusqueda.idGenero%TYPE,
        p_idArtista IN FiltroBusqueda.idArtista%TYPE,
        p_idRegistro IN FiltroBusqueda.idRegistro%TYPE,
        p_idBusqueda IN FiltroBusqueda.idBusqueda%TYPE
    ) AS
    BEGIN
        INSERT INTO FiltroBusqueda (
            fechaIntento, exito, periodo,
            idGenero, idArtista, idRegistro, idBusqueda
        )
        VALUES (SYSDATE, p_exito, p_periodo, p_idGenero, p_idArtista, p_idRegistro, p_idBusqueda);
        COMMIT;
    END insertar_filtro;

    PROCEDURE eliminar_filtro(
        p_idFiltro IN FiltroBusqueda.idFiltro%TYPE
    ) AS
    BEGIN
        DELETE FROM FiltroBusqueda
        WHERE idFiltro = p_idFiltro;
        COMMIT;
    END eliminar_filtro;

    PROCEDURE consultar_historial(
        p_idUsuario IN  HistorialBusqueda.idUsuario%TYPE,
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT hb.idBusqueda, hb.terminoBusqueda,
                   hb.fechaBusqueda, fb.exito
            FROM HistorialBusqueda hb
            LEFT JOIN FiltroBusqueda fb ON hb.idBusqueda = fb.idBusqueda
            WHERE hb.idUsuario = p_idUsuario
            ORDER BY hb.fechaBusqueda DESC;
    END consultar_historial;

END PA_BUSQUEDAS_USUARIO;
/

-- CONFIGURACION_USUARIO
CREATE OR REPLACE PACKAGE BODY PA_CONFIGURACION_USUARIO AS

    PROCEDURE insertar_configuracion(
        p_perfilPublico IN ConfiguracionUsuario.perfilPublico%TYPE,
        p_quienPuedeSeguir IN ConfiguracionUsuario.quienPuedeSeguir%TYPE,
        p_quienVeHistorial IN ConfiguracionUsuario.quienVeHistorial%TYPE,
        p_quienVePublicaciones IN ConfiguracionUsuario.quienVePublicaciones%TYPE,
        p_notificaciones IN ConfiguracionUsuario.notificacionesActivas%TYPE,
        p_idUsuario IN ConfiguracionUsuario.idUsuario%TYPE
    ) AS
    BEGIN
        INSERT INTO ConfiguracionUsuario (
            perfilPublico, quienPuedeSeguir, quienVeHistorial,
            quienVePublicaciones, notificacionesActivas, idUsuario
        )
        VALUES (
            p_perfilPublico, p_quienPuedeSeguir, p_quienVeHistorial,
            p_quienVePublicaciones, p_notificaciones, p_idUsuario
        );
        COMMIT;
    END insertar_configuracion;

    PROCEDURE actualizar_configuracion(
        p_idUsuario IN ConfiguracionUsuario.idUsuario%TYPE,
        p_perfilPublico IN ConfiguracionUsuario.perfilPublico%TYPE,
        p_quienPuedeSeguir IN ConfiguracionUsuario.quienPuedeSeguir%TYPE,
        p_quienVeHistorial IN ConfiguracionUsuario.quienVeHistorial%TYPE,
        p_quienVePublicaciones IN ConfiguracionUsuario.quienVePublicaciones%TYPE,
        p_notificaciones IN ConfiguracionUsuario.notificacionesActivas%TYPE
    ) AS
    BEGIN
        UPDATE ConfiguracionUsuario
        SET perfilPublico = p_perfilPublico,
            quienPuedeSeguir = p_quienPuedeSeguir,
            quienVeHistorial = p_quienVeHistorial,
            quienVePublicaciones = p_quienVePublicaciones,
            notificacionesActivas = p_notificaciones
        WHERE idUsuario = p_idUsuario;
        COMMIT;
    END actualizar_configuracion;

    PROCEDURE consultar_configuracion(
        p_idUsuario IN  ConfiguracionUsuario.idUsuario%TYPE,
        p_perfilPublico OUT ConfiguracionUsuario.perfilPublico%TYPE,
        p_quienPuedeSeguir OUT ConfiguracionUsuario.quienPuedeSeguir%TYPE,
        p_quienVeHistorial OUT ConfiguracionUsuario.quienVeHistorial%TYPE,
        p_quienVePublicaciones OUT ConfiguracionUsuario.quienVePublicaciones%TYPE,
        p_notificaciones OUT ConfiguracionUsuario.notificacionesActivas%TYPE
    ) AS
    BEGIN
        SELECT perfilPublico, quienPuedeSeguir, quienVeHistorial,
               quienVePublicaciones, notificacionesActivas
        INTO p_perfilPublico, p_quienPuedeSeguir, p_quienVeHistorial,
             p_quienVePublicaciones, p_notificaciones
        FROM ConfiguracionUsuario
        WHERE idUsuario = p_idUsuario;
    END consultar_configuracion;

    PROCEDURE agregar_bloqueo(
        p_idUsuario IN ListaNegra.idUsuario%TYPE,
        p_idUsuarioBloqueado IN ListaNegra.idUsuarioBloqueado%TYPE,
        p_motivo IN ListaNegra.motivoBloqueo%TYPE
    ) AS
    BEGIN
        INSERT INTO ListaNegra (idUsuario, idUsuarioBloqueado, fechaBloqueo, motivoBloqueo)
        VALUES (p_idUsuario, p_idUsuarioBloqueado, SYSDATE, p_motivo);
        COMMIT;
    END agregar_bloqueo;

    PROCEDURE eliminar_bloqueo(
        p_idBloqueo IN ListaNegra.idBloqueo%TYPE
    ) AS
    BEGIN
        DELETE FROM ListaNegra
        WHERE idBloqueo = p_idBloqueo;
        COMMIT;
    END eliminar_bloqueo;

    PROCEDURE consultar_bloqueados(
        p_idUsuario IN  ListaNegra.idUsuario%TYPE,
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT ln.idBloqueo, u.nombreUsuario,
                   ln.fechaBloqueo, ln.motivoBloqueo
            FROM ListaNegra ln
            JOIN Usuario u ON ln.idUsuarioBloqueado = u.idUsuario
            WHERE ln.idUsuario = p_idUsuario
            ORDER BY ln.fechaBloqueo DESC;
    END consultar_bloqueados;

END PA_CONFIGURACION_USUARIO;
/

-- PA_REPORTES_SANCIONES
CREATE OR REPLACE PACKAGE BODY PA_REPORTES_SANCIONES AS

    PROCEDURE consultar_reportes_pendientes(
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT r.idReporte, u.nombreUsuario AS reportado,
                   r.motivoReporte, r.descripcionReporte,
                   r.fechaReporte, r.estadoReporte
            FROM Reporte r
            JOIN Usuario u ON r.idUsuarioReportado = u.idUsuario
            WHERE r.estadoReporte = 'pendiente'
            ORDER BY r.fechaReporte DESC;
    END consultar_reportes_pendientes;

    PROCEDURE consultar_sanciones_activas(
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT s.idSancion, s.tipoSancion,
                   s.fechaInicio, s.fechaFin,
                   s.motivoSancion, u.nombreUsuario AS sancionado
            FROM Sancion s
            JOIN Usuario u ON s.idUsuarioReportado = u.idUsuario
            WHERE s.fechaFin > SYSDATE OR s.fechaFin IS NULL
            ORDER BY s.fechaInicio DESC;
    END consultar_sanciones_activas;

    PROCEDURE consultar_reportes_por_usuario(
        p_idUsuario IN  Reporte.idUsuarioReportado%TYPE,
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT r.idReporte, r.motivoReporte,
                   r.descripcionReporte, r.fechaReporte,
                   r.estadoReporte
            FROM Reporte r
            WHERE r.idUsuarioReportado = p_idUsuario
            ORDER BY r.fechaReporte DESC;
    END consultar_reportes_por_usuario;

    PROCEDURE consultar_sanciones_por_usuario(
        p_idUsuario IN  Sancion.idUsuarioReportado%TYPE,
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
            SELECT s.idSancion, s.tipoSancion,
                   s.fechaInicio, s.fechaFin,
                   s.motivoSancion
            FROM Sancion s
            WHERE s.idUsuarioReportado = p_idUsuario
            ORDER BY s.fechaInicio DESC;
    END consultar_sanciones_por_usuario;

END PA_REPORTES_SANCIONES;
/

-- PA_PERFIL_USUARIO
CREATE OR REPLACE PACKAGE BODY PA_PERFIL_USUARIO AS

    PROCEDURE agregar_streaming(
        p_idUsuario IN Usuario_Streaming.idUsuario%TYPE,
        p_plataforma IN Usuario_Streaming.plataformaStreaming%TYPE
    ) AS
    BEGIN
        INSERT INTO Usuario_Streaming (idUsuario, plataformaStreaming)
        VALUES (p_idUsuario, p_plataforma);
        COMMIT;
    END agregar_streaming;

    PROCEDURE eliminar_streaming(
        p_idUsuario IN Usuario_Streaming.idUsuario%TYPE,
        p_plataforma IN Usuario_Streaming.plataformaStreaming%TYPE
    ) AS
    BEGIN
        DELETE FROM Usuario_Streaming
        WHERE idUsuario = p_idUsuario
        AND plataformaStreaming = p_plataforma;
        COMMIT;
    END eliminar_streaming;

    PROCEDURE asignar_membresia(
        p_idUsuario IN UsuarioMembresia.idUsuario%TYPE,
        p_fechaInicio IN UsuarioMembresia.fechaInicioMembresia%TYPE,
        p_fechaFin IN UsuarioMembresia.fechaFinMembresia%TYPE,
        p_estado IN UsuarioMembresia.estadoMembresia%TYPE,
        p_tipo IN UsuarioMembresia.tipoMembresia%TYPE
    ) AS
    BEGIN
        INSERT INTO UsuarioMembresia (idUsuario, fechaInicioMembresia, fechaFinMembresia, estadoMembresia, tipoMembresia)
        VALUES (p_idUsuario, p_fechaInicio, p_fechaFin, p_estado, p_tipo);
        COMMIT;
    END asignar_membresia;

    PROCEDURE actualizar_membresia(
        p_idUsuario IN UsuarioMembresia.idUsuario%TYPE,
        p_fechaFin IN UsuarioMembresia.fechaFinMembresia%TYPE,
        p_estado IN UsuarioMembresia.estadoMembresia%TYPE,
        p_tipo IN UsuarioMembresia.tipoMembresia%TYPE
    ) AS
    BEGIN
        UPDATE UsuarioMembresia
        SET fechaFinMembresia = p_fechaFin,
            estadoMembresia = p_estado,
            tipoMembresia = p_tipo
        WHERE idUsuario = p_idUsuario;
        COMMIT;
    END actualizar_membresia;

    PROCEDURE consultar_membresia(
        p_idUsuario IN  UsuarioMembresia.idUsuario%TYPE,
        p_estado OUT UsuarioMembresia.estadoMembresia%TYPE,
        p_tipo OUT UsuarioMembresia.tipoMembresia%TYPE,
        p_fechaFin OUT UsuarioMembresia.fechaFinMembresia%TYPE
    ) AS
    BEGIN
        SELECT estadoMembresia, tipoMembresia, fechaFinMembresia
        INTO p_estado, p_tipo, p_fechaFin
        FROM UsuarioMembresia
        WHERE idUsuario = p_idUsuario;
    END consultar_membresia;

END PA_PERFIL_USUARIO;
/

-----------------------------------------------------
--------------------- CRUDOK-------------------------
-----------------------------------------------------

--------------- PA_CATALOGO_CANCIONES
-- INSERT: Artista
BEGIN
    PA_CATALOGO_CANCIONES.insertar_artista(
        p_nombre => 'Bad Bunny',
        p_pais => 'Puerto Rico',
        p_añoDebut => TO_DATE('2016-01-01', 'YYYY-MM-DD')
    );
    DBMS_OUTPUT.PUT_LINE('OK - insertar_artista');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - insertar_artista: ');
END;
/

-- INSERT: Género
BEGIN
    PA_CATALOGO_CANCIONES.insertar_genero(
        p_nombre => 'Reggaeton',
        p_descripcion => 'Género urbano de origen latinoamericano'
    );
    DBMS_OUTPUT.PUT_LINE('OK - insertar_genero');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - insertar_genero: ');
END;
/

-- INSERT: Canción
BEGIN
    PA_CATALOGO_CANCIONES.insertar_cancion(
        p_titulo => 'Tití Me Preguntó',
        p_duracion => 238,
        p_año => TO_DATE('2022-01-01', 'YYYY-MM-DD'),
        p_idArtista => 1
    );
    DBMS_OUTPUT.PUT_LINE('OK - insertar_cancion');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - insertar_cancion: ');
END;
/

-- UPDATE: Canción
BEGIN
    PA_CATALOGO_CANCIONES.actualizar_cancion(
        p_idCancion => 1,
        p_titulo => 'Tití Me Preguntó (Remix)',
        p_duracion => 250,
        p_año => TO_DATE('1970-05-08', 'YYYY-MM-DD')
    );
    DBMS_OUTPUT.PUT_LINE('OK - actualizar_cancion');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - actualizar_cancion: ');
END;
/

-- READ: Canción
DECLARE
    v_titulo Cancion.tituloCancion%TYPE;
    v_duracion Cancion.duracion%TYPE;
    v_año Cancion.año%TYPE;
BEGIN
    PA_CATALOGO_CANCIONES.consultar_cancion(
        p_idCancion => 1,
        p_titulo => v_titulo,
        p_duracion => v_duracion,
        p_año => v_año
    );
    DBMS_OUTPUT.PUT_LINE('OK - consultar_cancion: ' || v_titulo || ' | ' || v_duracion || 's | ' || v_año);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_cancion: ');
END;
/

-- DELETE: Canción
BEGIN
    PA_CATALOGO_CANCIONES.eliminar_cancion(p_idCancion => 1);
    DBMS_OUTPUT.PUT_LINE('OK - eliminar_cancion');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_cancion: ');
END;
/

-- READ
DECLARE
    v_nombre Usuario.nombreUsuario%TYPE;
    v_correo Usuario.correo%TYPE;
    v_descripcion Usuario.descripcionPerfil%TYPE;
BEGIN
    PA_USUARIO.consultar_usuario(
        p_idUsuario => 1,
        p_nombreUsuario => v_nombre,
        p_correo => v_correo,
        p_descripcionPerfil => v_descripcion
    );
    DBMS_OUTPUT.PUT_LINE('OK - consultar_usuario: ' || v_nombre || ' | ' || v_correo);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_usuario: ');
END;
/
-- DELETE
BEGIN
    PA_USUARIO.eliminar_usuario(p_idUsuario => 1);
    DBMS_OUTPUT.PUT_LINE('OK - eliminar_usuario');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_usuario: ');
END;
/

------------------- PA_RECOMENDACION
-- INSERT
BEGIN
    PA_RECOMENDACION.insertar_recomendacion(
        p_mensaje => 'Te va a encantar esta canción',
        p_tipo => 'cancion',
        p_idUsuario => 1,
        p_idCancion => 1,
        p_idDestino => 2
    );
    DBMS_OUTPUT.PUT_LINE('OK - insertar_recomendacion');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - insertar_recomendacion: ');
END;
/

-- UPDATE: Marcar visualizada
BEGIN
    PA_RECOMENDACION.marcar_visualizada(p_idRecomendacion => 1);
    DBMS_OUTPUT.PUT_LINE('OK - marcar_visualizada');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - marcar_visualizada: ');
END;
/

-- READ: Consultar recomendaciones (cursor)
DECLARE
    v_cursor SYS_REFCURSOR;
    v_id Recomendacion.idRecomendacion%TYPE;
    v_mensaje Recomendacion.mensajeRecomendacion%TYPE;
    v_tipo Recomendacion.tipoRecomendacion%TYPE;
    v_fecha Recomendacion.fechaRecomendacion%TYPE;
    v_cancion Cancion.tituloCancion%TYPE;
    v_usuario Usuario.nombreUsuario%TYPE;
BEGIN
    PA_RECOMENDACION.consultar_recomendaciones(
        p_idDestino => 2,
        p_cursor => v_cursor
    );
    LOOP
        FETCH v_cursor INTO v_id, v_mensaje, v_tipo, v_fecha, v_cancion, v_usuario;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('  Recomendacion: ' || v_mensaje || ' | Cancion: ' || v_cancion);
    END LOOP;
    CLOSE v_cursor;
    DBMS_OUTPUT.PUT_LINE('OK - consultar_recomendaciones');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_recomendaciones: ');
END;
/

-- DELETE
BEGIN
    PA_RECOMENDACION.eliminar_recomendacion(p_idRecomendacion => 1);
    DBMS_OUTPUT.PUT_LINE('OK - eliminar_recomendacion');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_recomendacion: ');
END;
/

------------------ PA_BUSQUEDAS_USUARIO
-- INSERT: Búsqueda
BEGIN
    PA_BUSQUEDAS_USUARIO.insertar_busqueda(
        p_termino => 'Bad Bunny reggaeton',
        p_idUsuario => 1
    );
    DBMS_OUTPUT.PUT_LINE('OK - insertar_busqueda');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - insertar_busqueda: ');
END;
/

-- INSERT: Filtro
BEGIN
    PA_BUSQUEDAS_USUARIO.insertar_filtro(
        p_exito => 1,
        p_periodo => '2022-2023',
        p_idGenero => 1,
        p_idArtista => 1,
        p_idRegistro => 1,
        p_idBusqueda => 1
    );
    DBMS_OUTPUT.PUT_LINE('OK - insertar_filtro');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - insertar_filtro: ');
END;
/

-- READ: Historial (cursor)
DECLARE
    v_cursor SYS_REFCURSOR;
    v_id HistorialBusqueda.idBusqueda%TYPE;
    v_termino HistorialBusqueda.terminoBusqueda%TYPE;
    v_fecha HistorialBusqueda.fechaBusqueda%TYPE;
    v_exito FiltroBusqueda.exito%TYPE;
BEGIN
    PA_BUSQUEDAS_USUARIO.consultar_historial(
        p_idUsuario => 1,
        p_cursor => v_cursor
    );
    LOOP
        FETCH v_cursor INTO v_id, v_termino, v_fecha, v_exito;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('  Busqueda: ' || v_termino || ' | Fecha: ' || TO_CHAR(v_fecha, 'DD/MM/YYYY'));
    END LOOP;
    CLOSE v_cursor;
    DBMS_OUTPUT.PUT_LINE('OK - consultar_historial');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_historial: ');
END;
/

-- DELETE: Filtro
BEGIN
    PA_BUSQUEDAS_USUARIO.eliminar_filtro(p_idFiltro => 1);
    DBMS_OUTPUT.PUT_LINE('OK - eliminar_filtro');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_filtro: ');
END;
/

-- DELETE: Búsqueda
BEGIN
    PA_BUSQUEDAS_USUARIO.eliminar_busqueda(p_idBusqueda => 1);
    DBMS_OUTPUT.PUT_LINE('OK - eliminar_busqueda');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_busqueda: ');
END;
/
-------------- PA_CONFIGURACION_USUARIO
-- INSERT
BEGIN
    PA_CONFIGURACION_USUARIO.insertar_configuracion(
        p_perfilPublico => 1,
        p_quienPuedeSeguir => 'todos',
        p_quienVeHistorial => 'amigos',
        p_quienVePublicaciones => 'todos',
        p_notificaciones => 1,
        p_idUsuario => 1
    );
    DBMS_OUTPUT.PUT_LINE('OK - insertar_configuracion');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - insertar_configuracion: ');
END;
/

-- UPDATE
BEGIN
    PA_CONFIGURACION_USUARIO.actualizar_configuracion(
        p_idUsuario => 1,
        p_perfilPublico => 0,
        p_quienPuedeSeguir => 'nadie',
        p_quienVeHistorial => 'nadie',
        p_quienVePublicaciones => 'amigos',
        p_notificaciones => 0
    );
    DBMS_OUTPUT.PUT_LINE('OK - actualizar_configuracion');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - actualizar_configuracion: ');
END;
/

-- READ
DECLARE
    v_perfilPublico ConfiguracionUsuario.perfilPublico%TYPE;
    v_quienPuedeSeguir ConfiguracionUsuario.quienPuedeSeguir%TYPE;
    v_quienVeHistorial ConfiguracionUsuario.quienVeHistorial%TYPE;
    v_quienVePublicaciones ConfiguracionUsuario.quienVePublicaciones%TYPE;
    v_notificaciones ConfiguracionUsuario.notificacionesActivas%TYPE;
BEGIN
    PA_CONFIGURACION_USUARIO.consultar_configuracion(
        p_idUsuario => 1,
        p_perfilPublico => v_perfilPublico,
        p_quienPuedeSeguir => v_quienPuedeSeguir,
        p_quienVeHistorial => v_quienVeHistorial,
        p_quienVePublicaciones => v_quienVePublicaciones,
        p_notificaciones => v_notificaciones
    );
    DBMS_OUTPUT.PUT_LINE('OK - consultar_configuracion: Publico=' || v_perfilPublico || ' | Seguir=' || v_quienPuedeSeguir);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_configuracion: ');
END;
/

-- INSERT: Bloqueo
BEGIN
    PA_CONFIGURACION_USUARIO.agregar_bloqueo(
        p_idUsuario => 1,
        p_idUsuarioBloqueado => 3,
        p_motivo => 'Spam constante'
    );
    DBMS_OUTPUT.PUT_LINE('OK - agregar_bloqueo');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - agregar_bloqueo: ');
END;
/

-- READ: Bloqueados (cursor)
DECLARE
    v_cursor SYS_REFCURSOR;
    v_idBloqueo ListaNegra.idBloqueo%TYPE;
    v_nombre Usuario.nombreUsuario%TYPE;
    v_fecha ListaNegra.fechaBloqueo%TYPE;
    v_motivo ListaNegra.motivoBloqueo%TYPE;
BEGIN
    PA_CONFIGURACION_USUARIO.consultar_bloqueados(
        p_idUsuario => 1,
        p_cursor => v_cursor
    );
    LOOP
        FETCH v_cursor INTO v_idBloqueo, v_nombre, v_fecha, v_motivo;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('  Bloqueado: ' || v_nombre || ' | Motivo: ' || v_motivo);
    END LOOP;
    CLOSE v_cursor;
    DBMS_OUTPUT.PUT_LINE('OK - consultar_bloqueados');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_bloqueados: ');
END;
/

-- DELETE: Bloqueo
BEGIN
    PA_CONFIGURACION_USUARIO.eliminar_bloqueo(p_idBloqueo => 1);
    DBMS_OUTPUT.PUT_LINE('OK - eliminar_bloqueo');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_bloqueo: ');
END;
/
----------------- PA_REPORTES_SANCIONES
-- READ: Reportes pendientes
DECLARE
    v_cursor SYS_REFCURSOR;
    v_idReporte Reporte.idReporte%TYPE;
    v_reportado Usuario.nombreUsuario%TYPE;
    v_motivo Reporte.motivoReporte%TYPE;
    v_desc Reporte.descripcionReporte%TYPE;
    v_fecha Reporte.fechaReporte%TYPE;
    v_estado Reporte.estadoReporte%TYPE;
BEGIN
    PA_REPORTES_SANCIONES.consultar_reportes_pendientes(p_cursor => v_cursor);
    LOOP
        FETCH v_cursor INTO v_idReporte, v_reportado, v_motivo, v_desc, v_fecha, v_estado;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('  Reporte: ' || v_reportado || ' | ' || v_motivo);
    END LOOP;
    CLOSE v_cursor;
    DBMS_OUTPUT.PUT_LINE('OK - consultar_reportes_pendientes');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_reportes_pendientes: ');
END;
/

-- READ: Sanciones activas
DECLARE
    v_cursor SYS_REFCURSOR;
    v_idSancion Sancion.idSancion%TYPE;
    v_tipo Sancion.tipoSancion%TYPE;
    v_inicio Sancion.fechaInicio%TYPE;
    v_fin Sancion.fechaFin%TYPE;
    v_motivo Sancion.motivoSancion%TYPE;
    v_sancionado Usuario.nombreUsuario%TYPE;
BEGIN
    PA_REPORTES_SANCIONES.consultar_sanciones_activas(p_cursor => v_cursor);
    LOOP
        FETCH v_cursor INTO v_idSancion, v_tipo, v_inicio, v_fin, v_motivo, v_sancionado;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('  Sancion: ' || v_sancionado || ' | ' || v_tipo);
    END LOOP;
    CLOSE v_cursor;
    DBMS_OUTPUT.PUT_LINE('OK - consultar_sanciones_activas');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_sanciones_activas: ');
END;
/

-- READ: Reportes por usuario
DECLARE
    v_cursor SYS_REFCURSOR;
    v_idReporte Reporte.idReporte%TYPE;
    v_motivo Reporte.motivoReporte%TYPE;
    v_desc Reporte.descripcionReporte%TYPE;
    v_fecha Reporte.fechaReporte%TYPE;
    v_estado Reporte.estadoReporte%TYPE;
BEGIN
    PA_REPORTES_SANCIONES.consultar_reportes_por_usuario(
        p_idUsuario => 3,
        p_cursor => v_cursor
    );
    LOOP
        FETCH v_cursor INTO v_idReporte, v_motivo, v_desc, v_fecha, v_estado;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('  Reporte: ' || v_motivo || ' | Estado: ' || v_estado);
    END LOOP;
    CLOSE v_cursor;
    DBMS_OUTPUT.PUT_LINE('OK - consultar_reportes_por_usuario');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_reportes_por_usuario: ');
END;
/

-- READ: Sanciones por usuario
DECLARE
    v_cursor SYS_REFCURSOR;
    v_idSancion Sancion.idSancion%TYPE;
    v_tipo Sancion.tipoSancion%TYPE;
    v_inicio Sancion.fechaInicio%TYPE;
    v_fin Sancion.fechaFin%TYPE;
    v_motivo Sancion.motivoSancion%TYPE;
BEGIN
    PA_REPORTES_SANCIONES.consultar_sanciones_por_usuario(
        p_idUsuario => 3,
        p_cursor => v_cursor
    );
    LOOP
        FETCH v_cursor INTO v_idSancion, v_tipo, v_inicio, v_fin, v_motivo;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('  Sancion: ' || v_tipo || ' | ' || v_motivo);
    END LOOP;
    CLOSE v_cursor;
    DBMS_OUTPUT.PUT_LINE('OK - consultar_sanciones_por_usuario');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_sanciones_por_usuario: ');
END;
/
----------------------- PA_PUBLICACION
-- INSERT: Publicación
BEGIN
    PA_PUBLICACION.insertar_publicacion(
        p_contenido => 'Esta canción es un banger total 🔥',
        p_idUsuario => 1,
        p_idCancion => 1
    );
    DBMS_OUTPUT.PUT_LINE('OK - insertar_publicacion');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - insertar_publicacion: ');
END;
/

-- UPDATE: Publicación
BEGIN
    PA_PUBLICACION.actualizar_publicacion(
        p_idPublicacion => 1,
        p_contenido => 'Esta canción es un banger total, la mejor del año'
    );
    DBMS_OUTPUT.PUT_LINE('OK - actualizar_publicacion');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - actualizar_publicacion: ');
END;
/

-- READ: Publicación
DECLARE
    v_contenido Publicacion.contenido%TYPE;
    v_fecha Publicacion.fechaPublicacion%TYPE;
    v_likes Publicacion.likes%TYPE;
BEGIN
    PA_PUBLICACION.consultar_publicacion(
        p_idPublicacion => 1,
        p_contenido => v_contenido,
        p_fecha => v_fecha,
        p_likes => v_likes
    );
    DBMS_OUTPUT.PUT_LINE('OK - consultar_publicacion: ' || v_contenido || ' | Likes: ' || v_likes);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_publicacion: ');
END;
/

-- INSERT: Comentario
BEGIN
    PA_PUBLICACION.insertar_comentario(
        p_contenido => 'Totalmente de acuerdo!',
        p_idPublicacion => 1,
        p_idUsuario => 2
    );
    DBMS_OUTPUT.PUT_LINE('OK - insertar_comentario');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - insertar_comentario: ');
END;
/

-- DELETE: Comentario
BEGIN
    PA_PUBLICACION.eliminar_comentario(p_idComentario => 1);
    DBMS_OUTPUT.PUT_LINE('OK - eliminar_comentario');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_comentario: ');
END;
/

-- DELETE: Publicación
BEGIN
    PA_PUBLICACION.eliminar_publicacion(p_idPublicacion => 1);
    DBMS_OUTPUT.PUT_LINE('OK - eliminar_publicacion');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_publicacion: ');
END;
/
------------- PA_PERFIL_USUARIO
-- INSERT: Streaming
BEGIN
    PA_PERFIL_USUARIO.agregar_streaming(
        p_idUsuario => 1,
        p_plataforma => 'Spotify'
    );
    DBMS_OUTPUT.PUT_LINE('OK - agregar_streaming');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - agregar_streaming: ');
END;
/

-- DELETE: Streaming
BEGIN
    PA_PERFIL_USUARIO.eliminar_streaming(
        p_idUsuario => 1,
        p_plataforma => 'Spotify'
    );
    DBMS_OUTPUT.PUT_LINE('OK - eliminar_streaming');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_streaming: ');
END;
/

-- INSERT: Membresía
BEGIN
    PA_PERFIL_USUARIO.asignar_membresia(
        p_idUsuario => 1,
        p_fechaInicio => SYSDATE,
        p_fechaFin => ADD_MONTHS(SYSDATE, 1),
        p_estado => 'activa',
        p_tipo => 'premium'
    );
    DBMS_OUTPUT.PUT_LINE('OK - asignar_membresia');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - asignar_membresia: ');
END;
/

-- UPDATE: Membresía
BEGIN
    PA_PERFIL_USUARIO.actualizar_membresia(
        p_idUsuario => 1,
        p_fechaFin => ADD_MONTHS(SYSDATE, 3),
        p_estado => 'activa',
        p_tipo => 'premium_anual'
    );
    DBMS_OUTPUT.PUT_LINE('OK - actualizar_membresia');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - actualizar_membresia: ');
END;
/

-- READ: Membresía
DECLARE
    v_estado UsuarioMembresia.estadoMembresia%TYPE;
    v_tipo UsuarioMembresia.tipoMembresia%TYPE;
    v_fechaFin UsuarioMembresia.fechaFinMembresia%TYPE;
BEGIN
    PA_PERFIL_USUARIO.consultar_membresia(
        p_idUsuario => 1,
        p_estado => v_estado,
        p_tipo => v_tipo,
        p_fechaFin => v_fechaFin
    );
    DBMS_OUTPUT.PUT_LINE('OK - consultar_membresia: ' || v_estado || ' | ' || v_tipo || ' | ' || TO_CHAR(v_fechaFin, 'DD/MM/YYYY'));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR - consultar_membresia: ');
END;
/

--------------------------------------------------------
------------------- CrudnoOK----------------------------
--------------------------------------------------------

----------- PA_CATALOGO_CANCIONES
-- ERROR: Insertar artista con nombre NULL (campo obligatorio)
BEGIN
    PA_CATALOGO_CANCIONES.insertar_artista(
        p_nombre => NULL,
        p_pais => 'Puerto Rico',
        p_añoDebut => TO_DATE('2016-01-01', 'YYYY-MM-DD')
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_artista: debio fallar por nombre NULL');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_artista: nombre NULL rechazado');
END;
/

-- ERROR: Insertar género con nombre NULL
BEGIN
    PA_CATALOGO_CANCIONES.insertar_genero(
        p_nombre => NULL,
        p_descripcion => 'Sin nombre'
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_genero: debio fallar por nombre NULL');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_genero: nombre NULL rechazado');
END;
/

-- ERROR: Insertar canción con FK de artista inexistente
BEGIN
    PA_CATALOGO_CANCIONES.insertar_cancion(
        p_titulo => 'Cancion Fantasma',
        p_duracion => 200,
        p_año => TO_DATE('2023-01-01', 'YYYY-MM-DD'),
        p_idArtista => 99999
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_cancion: debio fallar por FK artista inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_cancion: FK artista inexistente rechazada');
END;
/

-- ERROR: Insertar canción con título NULL
BEGIN
    PA_CATALOGO_CANCIONES.insertar_cancion(
        p_titulo => NULL,
        p_duracion => 200,
        p_año => TO_DATE('2023-01-01', 'YYYY-MM-DD'),
        p_idArtista => 1
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_cancion: debio fallar por titulo NULL');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_cancion: titulo NULL rechazado');
END;
/

-- ERROR: Actualizar canción con ID inexistente
BEGIN
    PA_CATALOGO_CANCIONES.actualizar_cancion(
        p_idCancion => 99999,
        p_titulo => 'No Existe',
        p_duracion => 100,
        p_año => TO_DATE('2020-01-01', 'YYYY-MM-DD')
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - actualizar_cancion: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - actualizar_cancion: ID inexistente rechazado');
END;
/

-- ERROR: Consultar canción con ID inexistente (NO_DATA_FOUND)
DECLARE
    v_titulo Cancion.tituloCancion%TYPE;
    v_duracion Cancion.duracion%TYPE;
    v_año Cancion.año%TYPE;
BEGIN
    PA_CATALOGO_CANCIONES.consultar_cancion(
        p_idCancion => 99999,
        p_titulo => v_titulo,
        p_duracion => v_duracion,
        p_año => v_año
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - consultar_cancion: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - consultar_cancion: ID inexistente rechazado');
END;
/

-- ERROR: Eliminar canción con ID inexistente
BEGIN
    PA_CATALOGO_CANCIONES.eliminar_cancion(p_idCancion => 99999);
    DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_cancion: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - eliminar_cancion: ID inexistente rechazado');
END;
/

------------------ PA_PERFIL_USUARIO
-- ERROR: Agregar streaming con FK de usuario inexistente
BEGIN
    PA_PERFIL_USUARIO.agregar_streaming(
        p_idUsuario => 99999,
        p_plataforma => 'Spotify'
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - agregar_streaming: debio fallar por FK usuario inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - agregar_streaming: FK usuario inexistente rechazada');
END;
/

-- ERROR: Agregar streaming con plataforma NULL
BEGIN
    PA_PERFIL_USUARIO.agregar_streaming(
        p_idUsuario => 1,
        p_plataforma => NULL
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - agregar_streaming: debio fallar por plataforma NULL');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - agregar_streaming: plataforma NULL rechazada');
END;
/

-- ERROR: Asignar membresía con FK de usuario inexistente
BEGIN
    PA_PERFIL_USUARIO.asignar_membresia(
        p_idUsuario => 99999,
        p_fechaInicio => SYSDATE,
        p_fechaFin => ADD_MONTHS(SYSDATE, 1),
        p_estado => 'activa',
        p_tipo => 'premium'
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - asignar_membresia: debio fallar por FK usuario inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - asignar_membresia: FK usuario inexistente rechazada');
END;
/

-- ERROR: Asignar membresía duplicada (PK repetida)
BEGIN
    PA_PERFIL_USUARIO.asignar_membresia(
        p_idUsuario => 1,
        p_fechaInicio => SYSDATE,
        p_fechaFin => ADD_MONTHS(SYSDATE, 1),
        p_estado => 'activa',
        p_tipo => 'premium'
    );
    PA_PERFIL_USUARIO.asignar_membresia(
        p_idUsuario => 1,
        p_fechaInicio => SYSDATE,
        p_fechaFin => ADD_MONTHS(SYSDATE, 1),
        p_estado => 'activa',
        p_tipo => 'premium'
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - asignar_membresia: debio fallar por PK duplicada');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - asignar_membresia: PK duplicada rechazada');
END;
/

-- ERROR: Actualizar membresía con ID inexistente
BEGIN
    PA_PERFIL_USUARIO.actualizar_membresia(
        p_idUsuario => 99999,
        p_fechaFin => ADD_MONTHS(SYSDATE, 3),
        p_estado => 'activa',
        p_tipo => 'premium'
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - actualizar_membresia: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - actualizar_membresia: ID inexistente rechazado');
END;
/

-- ERROR: Consultar membresía con ID inexistente (NO_DATA_FOUND)
DECLARE
    v_estado UsuarioMembresia.estadoMembresia%TYPE;
    v_tipo UsuarioMembresia.tipoMembresia%TYPE;
    v_fechaFin UsuarioMembresia.fechaFinMembresia%TYPE;
BEGIN
    PA_PERFIL_USUARIO.consultar_membresia(
        p_idUsuario => 99999,
        p_estado => v_estado,
        p_tipo => v_tipo,
        p_fechaFin => v_fechaFin
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - consultar_membresia: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - consultar_membresia: ID inexistente rechazado');
END;
/
---------------------------- PA_PUBLICACION
-- ERROR: Insertar publicación con FK de usuario inexistente
BEGIN
    PA_PUBLICACION.insertar_publicacion(
        p_contenido => 'Publicacion huerfana',
        p_idUsuario => 99999,
        p_idCancion => 1
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_publicacion: debio fallar por FK usuario inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_publicacion: FK usuario inexistente rechazada');
END;
/
-- ERROR: Insertar publicación con FK de canción inexistente
BEGIN
    PA_PUBLICACION.insertar_publicacion(
        p_contenido => 'Publicacion sin cancion',
        p_idUsuario => 1,
        p_idCancion => 99999
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_publicacion: debio fallar por FK cancion inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_publicacion: FK cancion inexistente rechazada');
END;
/
-- ERROR: Insertar publicación con contenido NULL
BEGIN
    PA_PUBLICACION.insertar_publicacion(
        p_contenido => NULL,
        p_idUsuario => 1,
        p_idCancion => 1
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_publicacion: debio fallar por contenido NULL');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_publicacion: contenido NULL rechazado');
END;
/

-- ERROR: Actualizar publicación con ID inexistente
BEGIN
    PA_PUBLICACION.actualizar_publicacion(
        p_idPublicacion => 99999,
        p_contenido => 'Nada'
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - actualizar_publicacion: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - actualizar_publicacion: ID inexistente rechazado');
END;
/
-- ERROR: Consultar publicación con ID inexistente (NO_DATA_FOUND)
DECLARE
    v_contenido Publicacion.contenido%TYPE;
    v_fecha Publicacion.fechaPublicacion%TYPE;
    v_likes Publicacion.likes%TYPE;
BEGIN
    PA_PUBLICACION.consultar_publicacion(
        p_idPublicacion => 99999,
        p_contenido => v_contenido,
        p_fecha => v_fecha,
        p_likes => v_likes
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - consultar_publicacion: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - consultar_publicacion: ID inexistente rechazado');
END;
/

-- ERROR: Insertar comentario con FK de publicación inexistente
BEGIN
    PA_PUBLICACION.insertar_comentario(
        p_contenido => 'Comentario huerfano',
        p_idPublicacion => 99999,
        p_idUsuario => 1
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_comentario: debio fallar por FK publicacion inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_comentario: FK publicacion inexistente rechazada');
END;
/

-- ERROR: Eliminar comentario con ID inexistente
BEGIN
    PA_PUBLICACION.eliminar_comentario(p_idComentario => 99999);
    DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_comentario: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - eliminar_comentario: ID inexistente rechazado');
END;
/

-- ERROR: Eliminar publicación con ID inexistente
BEGIN
    PA_PUBLICACION.eliminar_publicacion(p_idPublicacion => 99999);
    DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_publicacion: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - eliminar_publicacion: ID inexistente rechazado');
END;
/

--------------------------------- PA_RECOMENDACION
-- ERROR: Insertar recomendación con FK de usuario recomendador inexistente
BEGIN
    PA_RECOMENDACION.insertar_recomendacion(
        p_mensaje => 'Recomendacion sin origen',
        p_tipo => 'cancion',
        p_idUsuario => 99999,
        p_idCancion => 1,
        p_idDestino => 2
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_recomendacion: debio fallar por FK usuario inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_recomendacion: FK usuario inexistente rechazada');
END;
/

-- ERROR: Insertar recomendación con FK de canción inexistente
BEGIN
    PA_RECOMENDACION.insertar_recomendacion(
        p_mensaje => 'Recomendacion sin cancion',
        p_tipo => 'cancion',
        p_idUsuario => 1,
        p_idCancion => 99999,
        p_idDestino => 2
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_recomendacion: debio fallar por FK cancion inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_recomendacion: FK cancion inexistente rechazada');
END;
/

-- ERROR: Marcar visualizada con ID inexistente
BEGIN
    PA_RECOMENDACION.marcar_visualizada(p_idRecomendacion => 99999);
    DBMS_OUTPUT.PUT_LINE('ERROR - marcar_visualizada: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - marcar_visualizada: ID inexistente rechazado');
END;
/

-- ERROR: Eliminar recomendación con ID inexistente
BEGIN
    PA_RECOMENDACION.eliminar_recomendacion(p_idRecomendacion => 99999);
    DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_recomendacion: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - eliminar_recomendacion: ID inexistente rechazado');
END;
/
--------------------- PA_BUSQUEDAS_USUARIO
-- ERROR: Insertar búsqueda con FK de usuario inexistente
BEGIN
    PA_BUSQUEDAS_USUARIO.insertar_busqueda(
        p_termino => 'Busqueda huerfana',
        p_idUsuario => 99999
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_busqueda: debio fallar por FK usuario inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_busqueda: FK usuario inexistente rechazada');
END;
/

-- ERROR: Insertar búsqueda con término NULL
BEGIN
    PA_BUSQUEDAS_USUARIO.insertar_busqueda(
        p_termino => NULL,
        p_idUsuario => 1
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_busqueda: debio fallar por termino NULL');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_busqueda: termino NULL rechazado');
END;
/

-- ERROR: Insertar filtro con FK de búsqueda inexistente
BEGIN
    PA_BUSQUEDAS_USUARIO.insertar_filtro(
        p_exito => 1,
        p_periodo => '2022-2023',
        p_idGenero => 1,
        p_idArtista => 1,
        p_idRegistro => 1,
        p_idBusqueda => 99999
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_filtro: debio fallar por FK busqueda inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_filtro: FK busqueda inexistente rechazada');
END;
/

-- ERROR: Eliminar filtro con ID inexistente
BEGIN
    PA_BUSQUEDAS_USUARIO.eliminar_filtro(p_idFiltro => 99999);
    DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_filtro: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - eliminar_filtro: ID inexistente rechazado');
END;
/

-- ERROR: Eliminar búsqueda con ID inexistente
BEGIN
    PA_BUSQUEDAS_USUARIO.eliminar_busqueda(p_idBusqueda => 99999);
    DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_busqueda: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - eliminar_busqueda: ID inexistente rechazado');
END;
/

----------------- PA_CONFIGURACION_USUARIO
-- ERROR: Insertar configuración con FK de usuario inexistente
BEGIN
    PA_CONFIGURACION_USUARIO.insertar_configuracion(
        p_perfilPublico => 1,
        p_quienPuedeSeguir => 'todos',
        p_quienVeHistorial => 'todos',
        p_quienVePublicaciones => 'todos',
        p_notificaciones => 1,
        p_idUsuario => 99999
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_configuracion: debio fallar por FK usuario inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_configuracion: FK usuario inexistente rechazada');
END;
/

-- ERROR: Insertar configuración duplicada (PK repetida)
BEGIN
    PA_CONFIGURACION_USUARIO.insertar_configuracion(
        p_perfilPublico => 1,
        p_quienPuedeSeguir => 'todos',
        p_quienVeHistorial => 'todos',
        p_quienVePublicaciones => 'todos',
        p_notificaciones => 1,
        p_idUsuario => 1
    );
    PA_CONFIGURACION_USUARIO.insertar_configuracion(
        p_perfilPublico => 0,
        p_quienPuedeSeguir => 'nadie',
        p_quienVeHistorial => 'nadie',
        p_quienVePublicaciones => 'nadie',
        p_notificaciones => 0,
        p_idUsuario => 1
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - insertar_configuracion: debio fallar por PK duplicada');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - insertar_configuracion: PK duplicada rechazada');
END;
/

-- ERROR: Actualizar configuración con ID inexistente
BEGIN
    PA_CONFIGURACION_USUARIO.actualizar_configuracion(
        p_idUsuario => 99999,
        p_perfilPublico => 0,
        p_quienPuedeSeguir => 'nadie',
        p_quienVeHistorial => 'nadie',
        p_quienVePublicaciones => 'nadie',
        p_notificaciones => 0
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - actualizar_configuracion: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - actualizar_configuracion: ID inexistente rechazado');
END;
/

-- ERROR: Consultar configuración con ID inexistente (NO_DATA_FOUND)
DECLARE
    v_perfilPublico ConfiguracionUsuario.perfilPublico%TYPE;
    v_quienPuedeSeguir ConfiguracionUsuario.quienPuedeSeguir%TYPE;
    v_quienVeHistorial ConfiguracionUsuario.quienVeHistorial%TYPE;
    v_quienVePublicaciones ConfiguracionUsuario.quienVePublicaciones%TYPE;
    v_notificaciones ConfiguracionUsuario.notificacionesActivas%TYPE;
BEGIN
    PA_CONFIGURACION_USUARIO.consultar_configuracion(
        p_idUsuario => 99999,
        p_perfilPublico => v_perfilPublico,
        p_quienPuedeSeguir => v_quienPuedeSeguir,
        p_quienVeHistorial => v_quienVeHistorial,
        p_quienVePublicaciones => v_quienVePublicaciones,
        p_notificaciones => v_notificaciones
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - consultar_configuracion: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - consultar_configuracion: ID inexistente rechazado');
END;
/

-- ERROR: Agregar bloqueo con FK de usuario bloqueado inexistente
BEGIN
    PA_CONFIGURACION_USUARIO.agregar_bloqueo(
        p_idUsuario => 1,
        p_idUsuarioBloqueado => 99999,
        p_motivo => 'Bloqueo invalido'
    );
    DBMS_OUTPUT.PUT_LINE('ERROR - agregar_bloqueo: debio fallar por FK usuario bloqueado inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - agregar_bloqueo: FK usuario bloqueado inexistente rechazada');
END;
/

-- ERROR: Eliminar bloqueo con ID inexistente
BEGIN
    PA_CONFIGURACION_USUARIO.eliminar_bloqueo(p_idBloqueo => 99999);
    DBMS_OUTPUT.PUT_LINE('ERROR - eliminar_bloqueo: debio fallar por ID inexistente');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('NoOK CORRECTO - eliminar_bloqueo: ID inexistente rechazado');
END;
/
------------------------------------------------------------
---------------------- XCRUD -------------------------------
------------------------------------------------------------

DROP PACKAGE PA_CATALOGO_CANCIONES;
DROP PACKAGE PA_PERFIL_USUARIO;
DROP PACKAGE PA_PUBLICACION;
DROP PACKAGE PA_RECOMENDACION;
DROP PACKAGE PA_BUSQUEDAS_USUARIO;
DROP PACKAGE PA_CONFIGURACION_USUARIO;
DROP PACKAGE PA_REPORTES_SANCIONES;
