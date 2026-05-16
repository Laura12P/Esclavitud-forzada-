----------------------------------------------------------------------------------------------
------------------------------------------ ÍNDICES -------------------------------------------
----------------------------------------------------------------------------------------------

-- GRAN CONCEPTO: HISTORIAL MUSICAL
-- Acelera búsquedas de registros por usuario y por rango de fecha
CREATE INDEX Usuario_Fecha ON Historial_Musical (idUsuario, fechaRegistro);

-- Acelera búsquedas de registros por canción y por rango de fecha
CREATE INDEX Cancion_Fecha ON Historial_Musical (idCancion, fechaRegistro);

-- GRAN CONCEPTO: PUBLICACIÓN
-- Acelera búsquedas de publicaciones por usuario y por rango de fechas
CREATE INDEX Publicacion_Usuario_Fecha ON Publicacion (idUsuario, fechaPublicacion);

-- GRAN CONCEPTO: RECOMENDACIÓN
-- Acelera búsquedas de recomendaciones recibidas por un usuario en un período
CREATE INDEX Recomendacion_Destino_Fecha ON Recomendacion (idUsuarioDestino, fechaRecomendacion);

-- Acelera agrupaciones y conteos por destinatario y recomendador
CREATE INDEX Reco_UsuarioDest_UsuarioRecom ON Recomendacion (idUsuarioDestino, idUsuarioRecomendador);

-- GRAN CONCEPTO: MODERACIÓN & REPORTE
-- Acelera búsquedas y conteos de reportes sobre un usuario específico
CREATE INDEX Usuario_Reportado ON Reporte (idUsuarioReportado);

-- GRAN CONCEPTO: CONFIGURACIÓN & PRIVACIDAD
-- Acelera búsquedas de bloqueos recibidos por un usuario y su fecha
CREATE INDEX UsuarioBloqueado_Fecha ON ListaNegra (idUsuarioBloqueado, fechaBloqueo);

-- GRAN CONCEPTO: BÚSQUEDA & DESCUBRIMIENTO
-- Acelera filtros por fecha en el historial de búsquedas
CREATE INDEX HistorialBus_fecha ON HistorialBusqueda (fechaBusqueda);

-- Acelera filtros por resultado exitoso o fallido en filtros de búsqueda
CREATE INDEX Filtro_Exito ON FiltroBusqueda (exito);

-- GRAN CONCEPTO: CANCIÓN
-- Acelera búsquedas de canciones por artista
CREATE INDEX Cancion_Artista ON Cancion (idArtista);


----------------------------------------------------------------------------------------------
------------------------------------------ VISTAS --------------------------------------------
----------------------------------------------------------------------------------------------

-------------------------------------
-- GRAN CONCEPTO: HISTORIAL MUSICAL
-------------------------------------


-- Muestra las canciones y artistas presentes en el historial musical.
CREATE OR REPLACE VIEW Canciones_HistorialMusical AS
SELECT hm.idUsuario, hm.fechaRegistro, hm.idRegistro, c.idCancion, c.tituloCancion, c.idArtista
FROM Historial_Musical hm
JOIN Cancion c ON hm.idCancion = c.idCancion;

-- Muestra artistas, géneros y fechas de escucha del último mes.
CREATE OR REPLACE VIEW ArtistaMasEscuchado AS
SELECT a.idArtista, a.nombre, c.idCancion, hm.idRegistro, hm.fechaRegistro, g.idGenero, g.nombreGenero
FROM Historial_Musical hm
JOIN Cancion c  ON hm.idCancion = c.idCancion
JOIN Artista a  ON c.idArtista = a.idArtista
JOIN Tiene_Genero tg  ON c.idCancion = tg.idCancion
JOIN Genero g  ON tg.idGenero = g.idGenero
WHERE hm.fechaRegistro >= ADD_MONTHS(SYSDATE, -1);

-- Muestra qué usuarios han escuchado canciones de cada artista.
CREATE OR REPLACE VIEW UsuariosEscuchanArtista AS
SELECT c.idArtista, hm.idRegistro, c.idCancion, u.idUsuario, u.nombreUsuario
FROM Historial_Musical hm
JOIN Cancion c ON hm.idCancion = c.idCancion
JOIN Usuario u ON hm.idUsuario = u.idUsuario;

---------------------------------------------------------------
-- GRAN CONCEPTO: HISTORIAL MUSICAL - EMOCIONES Y CONFIGURACIÓN
---------------------------------------------------------------

-- Muestra el historial musical de cada usuario con sus emociones anotadas.
CREATE OR REPLACE VIEW HistoriaMusicalUsuario AS
SELECT hm.idUsuario, hm.fechaRegistro, hm.notaPersonal, he.emocion
FROM Historial_Musical hm LEFT JOIN Historial_Emocion he ON hm.idRegistro = he.idRegistro;

--------------------------------------------
-- GRAN CONCEPTO: BÚSQUEDA & DESCUBRIMIENTO
--------------------------------------------

-- Muestra las búsquedas realizadas en los últimos 30 días con su resultado.
CREATE OR REPLACE VIEW HistorialUltimoMes AS
SELECT hb.idBusqueda, hb.terminoBusqueda, hb.fechaBusqueda, fb.exito
FROM HistorialBusqueda hb
JOIN FiltroBusqueda fb ON hb.idBusqueda = fb.idBusqueda
WHERE hb.fechaBusqueda >= SYSDATE - 30;

-- Muestra únicamente las búsquedas sin resultados exitosos.
CREATE OR REPLACE VIEW BusquedasFallidas AS
SELECT hb.idBusqueda, hb.terminoBusqueda, hb.fechaBusqueda, fb.exito
FROM HistorialBusqueda hb
JOIN FiltroBusqueda fb ON hb.idBusqueda = fb.idBusqueda
WHERE fb.exito = 0;

-------------------------------------
-- GRAN CONCEPTO: MODERACIÓN & REPORTE
-------------------------------------

-- Muestra los reportes emitidos en los últimos 30 días con datos del reportado.
CREATE OR REPLACE VIEW ReportesUltimoMes AS
SELECT r.idUsuarioReportado, r.motivoReporte, r.descripcionReporte, r.estadoReporte, r.fechaReporte, u.idUsuario, u.nombreUsuario
FROM Reporte r
JOIN Usuario u ON r.idUsuarioReportado = u.idUsuario
WHERE r.fechaReporte >= SYSDATE - 30;

-- Muestra las sanciones que actualmente están vigentes.
CREATE OR REPLACE VIEW SancionesActivas AS
SELECT tipoSancion, motivoSancion, fechaInicio, fechaFin
FROM Sancion
WHERE fechaFin > SYSDATE OR fechaFin IS NULL;

-- Muestra todos los reportes vinculando el usuario reportado con su nombre.
CREATE OR REPLACE VIEW TopUsuariosReportados AS
SELECT r.idUsuarioReportado, r.idReporte, u.idUsuario, u.nombreUsuario
FROM Reporte  r
JOIN Usuario  u ON r.idUsuarioReportado = u.idUsuario;

-------------------------------------
-- GRAN CONCEPTO: PUBLICACIÓN
-------------------------------------

-- Muestra publicaciones con sus tipos de contenido y comentarios asociados.
CREATE OR REPLACE VIEW TopPublicacionesLikes AS
SELECT p.idPublicacion, p.contenido, p.likes, p.idUsuario, p.fechaPublicacion, ptc.tipoContenido, co.idComentario, co.contenido AS contenidoComentario
FROM Publicacion p
JOIN  Publicacion_TipoContenido ptc ON p.idPublicacion = ptc.idPublicacion
LEFT JOIN Comentario co ON p.idPublicacion = co.idPublicacion;

-- Muestra solo el usuario y fecha de publicación para calcular cantidades fácilmente.
CREATE OR REPLACE VIEW CantidadPublicaciones AS
SELECT idUsuario, fechaPublicacion
FROM Publicacion;

-------------------------------------
-- GRAN CONCEPTO: CONFIGURACIÓN & PRIVACIDAD
-------------------------------------

-- Muestra los usuarios bloqueados junto con el nombre del usuario bloqueado.
CREATE OR REPLACE VIEW UsuariosBloqueados AS
SELECT ln.idUsuario, ln.idUsuarioBloqueado, ln.fechaBloqueo, ln.motivoBloqueo, u.nombreUsuario
FROM ListaNegra ln
JOIN Usuario u ON ln.idUsuarioBloqueado = u.idUsuario;

-- Muestra las configuraciones de privacidad relevantes de cada usuario.
CREATE OR REPLACE VIEW vista_ConfiguracionUsuario AS
SELECT idUsuario, perfilPublico, quienVeHistorial, quienVePublicaciones, notificacionesActivas
FROM ConfiguracionUsuario;

-- Muestra cada registro de bloqueo con su fecha para conteo de incidencias.
CREATE OR REPLACE VIEW VecesBloqueado AS
SELECT idUsuarioBloqueado, fechaBloqueo
FROM ListaNegra;

-----------------------------------
-- GRAN CONCEPTO: RECOMENDACIÓN
-----------------------------------

-- Muestra recomendaciones recibidas en los últimos 30 días por destinatario.
CREATE OR REPLACE VIEW RecomendacionesRecibidas AS
SELECT idUsuarioDestino, mensajeRecomendacion, tipoRecomendacion, fechaRecomendacion
FROM Recomendacion
WHERE fechaRecomendacion >= SYSDATE - 30;

-- Muestra destinatario y tipo de cada recomendación para agrupar por tipo.
CREATE OR REPLACE VIEW RecomendacionesPorTipo AS
SELECT idUsuarioDestino, tipoRecomendacion
FROM Recomendacion;

-- Muestra quién recomienda a quién y cuándo, con el nombre del recomendador.
CREATE OR REPLACE VIEW QuienMasRecomienda AS
SELECT u.idUsuario, u.nombreUsuario, r.idUsuarioDestino, r.fechaRecomendacion
FROM Recomendacion r
JOIN Usuario u ON r.idUsuarioRecomendador = u.idUsuario;


----------------------------------------------------------------------------------------------
------------------------------------- INDICESVISTASOK ----------------------------------------
----------------------------------------------------------------------------------------------

-- 1. Canciones escuchadas por un usuario específico
SELECT idRegistro, idCancion, tituloCancion, idArtista, fechaRegistro
FROM Canciones_HistorialMusical
WHERE idUsuario = 1
ORDER BY fechaRegistro DESC;

-- 2. Artistas más escuchados del último mes
SELECT nombre, nombreGenero, COUNT(idRegistro) AS total_reproducciones
FROM ArtistaMasEscuchado
GROUP BY nombre, nombreGenero
ORDER BY total_reproducciones DESC;

-- 3. Usuarios que escuchan a un artista concreto
SELECT nombreUsuario, COUNT(idRegistro) AS veces_escuchado
FROM UsuariosEscuchanArtista
WHERE idArtista = 1
GROUP BY nombreUsuario
ORDER BY veces_escuchado DESC;

-- 4. Historial musical con emociones de un usuario
SELECT fechaRegistro, emocion, notaPersonal
FROM HistoriaMusicalUsuario
WHERE idUsuario = 1
ORDER BY fechaRegistro DESC;

-- 5. Búsquedas del último mes de un usuario 
SELECT idBusqueda, terminoBusqueda, fechaBusqueda, exito
FROM HistorialUltimoMes
ORDER BY fechaBusqueda DESC;

-- 6. Términos más buscados sin éxito 
SELECT terminoBusqueda, COUNT(*) AS intentos_fallidos, MAX(fechaBusqueda) AS ultimo_intento
FROM BusquedasFallidas
GROUP BY terminoBusqueda
ORDER BY intentos_fallidos DESC;

-- 7. Reportes del último mes con datos del usuario reportado
SELECT idUsuarioReportado, nombreUsuario, motivoReporte, estadoReporte, fechaReporte
FROM ReportesUltimoMes
ORDER BY fechaReporte DESC;

-- 8. Sanciones actualmente vigentes
SELECT tipoSancion, motivoSancion, fechaInicio, fechaFin
FROM SancionesActivas
ORDER BY fechaInicio DESC;

-- 9. Usuarios con más reportes acumulados
SELECT idUsuarioReportado, nombreUsuario, COUNT(idReporte) AS total_reportes
FROM TopUsuariosReportados
GROUP BY idUsuarioReportado, nombreUsuario
ORDER BY total_reportes DESC;

-- 10. Publicaciones con más likes de un usuario
SELECT idPublicacion, contenido, likes, tipoContenido, fechaPublicacion
FROM TopPublicacionesLikes
WHERE idUsuario = 1
ORDER BY likes DESC;

-- 11. Cantidad de publicaciones de un usuario en un rango de fechas
SELECT idUsuario, COUNT(*) AS total_publicaciones, MAX(fechaPublicacion) AS ultima_publicacion
FROM CantidadPublicaciones
WHERE idUsuario = 1 AND fechaPublicacion BETWEEN TO_DATE('2024-01-01','YYYY-MM-DD') AND SYSDATE
GROUP BY idUsuario;

-- 12. Usuarios bloqueados por un usuario y fecha de bloqueo
SELECT idUsuarioBloqueado, nombreUsuario, fechaBloqueo, motivoBloqueo
FROM UsuariosBloqueados
WHERE idUsuario = 1
ORDER BY fechaBloqueo DESC;

-- 13. Configuración de privacidad de un usuario
SELECT idUsuario, perfilPublico, quienVeHistorial, notificacionesActivas
FROM vista_ConfiguracionUsuario
WHERE idUsuario = 1;

-- 14. Cuántas veces fue bloqueado un usuario
SELECT COUNT(*) AS veces_bloqueado, MAX(fechaBloqueo) AS ultimo_bloqueo
FROM VecesBloqueado
WHERE idUsuarioBloqueado = 1;

-- 15. Recomendaciones recibidas por un usuario en el último mes
SELECT mensajeRecomendacion, tipoRecomendacion, fechaRecomendacion
FROM RecomendacionesRecibidas
WHERE idUsuarioDestino = 1
ORDER BY fechaRecomendacion DESC;

-- 16. Recomendaciones agrupadas por tipo para un destinatario
SELECT tipoRecomendacion, COUNT(*) AS total
FROM RecomendacionesPorTipo
WHERE idUsuarioDestino = 1
GROUP BY tipoRecomendacion
ORDER BY total DESC;

-- 17. Quién más recomienda a un usuario y cuándo fue la última vez
SELECT nombreUsuario, COUNT(*) AS total_recomendaciones, MAX(fechaRecomendacion) AS ultima_fecha
FROM QuienMasRecomienda
WHERE idUsuarioDestino = 1
GROUP BY idUsuario, nombreUsuario
ORDER BY total_recomendaciones DESC;

----------------------------------------------------------------------------------------------
--------------------------------------- XINDICESVISTAS ---------------------------------------
----------------------------------------------------------------------------------------------

-- Eliminación de vistas
DROP VIEW Canciones_HistorialMusical;
DROP VIEW ArtistaMasEscuchado;
DROP VIEW UsuariosEscuchanArtista;
DROP VIEW HistoriaMusicalUsuario;
DROP VIEW HistorialUltimoMes;
DROP VIEW BusquedasFallidas;
DROP VIEW ReportesUltimoMes;
DROP VIEW SancionesActivas;
DROP VIEW TopUsuariosReportados;
DROP VIEW TopPublicacionesLikes;
DROP VIEW CantidadPublicaciones;
DROP VIEW UsuariosBloqueados;
DROP VIEW vista_ConfiguracionUsuario;
DROP VIEW VecesBloqueado;
DROP VIEW RecomendacionesRecibidas;
DROP VIEW RecomendacionesPorTipo;
DROP VIEW QuienMasRecomienda;

-- Eliminación de índices
DROP INDEX Usuario_Fecha;
DROP INDEX Cancion_Fecha;
DROP INDEX Publicacion_Usuario_Fecha;
DROP INDEX Recomendacion_Destino_Fecha;
DROP INDEX Reco_UsuarioDest_UsuarioRecom;
DROP INDEX Usuario_Reportado;
DROP INDEX UsuarioBloqueado_Fecha;
DROP INDEX HistorialBus_fecha;
DROP INDEX Filtro_Exito;
DROP INDEX Cancion_Artista;