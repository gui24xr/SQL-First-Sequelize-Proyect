
-- Vista datos personales.
CREATE VIEW vista_datos_personales AS
SELECT 
datos_personales.dni as DNI, 
datos_personales.apellido as 'Apellido/s',
CASE
    WHEN datos_personales.nombre2 IS NULL THEN datos_personales.nombre1
    ELSE CONCAT(datos_personales.nombre1,' ',datos_personales.nombre2) 
END AS 'Nombre/s',
datos_personales.fecha_nacimiento AS 'Fecha Nacimiento',
CONCAT(datos_domicilios.calle,' ',datos_domicilios.altura_calle) AS 'Domicilio',
CONCAT(datos_domicilios.localidad,' (CP',datos_domicilios.codigo_postal,')') AS 'Localidad',
CONCAT(datos_domicilios.provincia,'/',datos_domicilios.pais) AS 'Provincia/Pais',
datos_telefonicos.telefono_celular AS 'Telefono movil',
datos_telefonicos.telefono_fijo AS 'Telefono Fijo',
datos_personales.email_contacto AS 'Email contacto'
FROM datos_personales
JOIN datos_domicilios ON datos_personales.domicilio = datos_domicilios.id_datos_domicilio
JOIN datos_telefonicos ON datos_personales.telefonos = datos_telefonicos.id_datos_telefonicos;



--getEdad(datos_personales.fecha_nacimiento) as Edad

--Vista Usuarios sistema vs Personas
SELECT
    datos_personales.dni AS DNI,
    datos_personales.apellido AS 'Apellido/s',
    CASE
        WHEN datos_personales.nombre2 IS NULL THEN datos_personales.nombre1
        ELSE CONCAT(datos_personales.nombre1, ' ', datos_personales.nombre2) 
    END AS 'Nombre/s',
    COALESCE(datos_personales.user_id,'No registrado en sistema.') AS 'UserId',
    COALESCE(usuarios_sistema.user_email,'No registrado en sistema.') AS 'Email Sistema',
    COALESCE(usuarios_sistema.user_rol,'No registrado en sistema.') AS 'Permisos',
    CASE    
        WHEN usuarios_sistema.user_status = TRUE THEN 'Activo'
        ELSE 'Inactivo'
    END AS 'Estado User'
FROM 
    datos_personales
LEFT JOIN 
    usuarios_sistema ON datos_personales.user_id = usuarios_sistema.user_id;
