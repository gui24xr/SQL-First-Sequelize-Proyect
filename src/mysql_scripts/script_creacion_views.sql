CREATE VIEW vista_datos_usuarios_sistema AS
SELECT
    datos_personales.dni,
    datos_personales.nombre1 AS nombre,
    datos_personales.apellido,
    datos_personales.email_contacto,
    datos_personales.user_id
FROM datos_personales
JOIN usuarios_sistema ON datos_personales.user_id = usuarios_sistema.user_id;


SELECT * FROM vista_datos_usuarios_sistema;

