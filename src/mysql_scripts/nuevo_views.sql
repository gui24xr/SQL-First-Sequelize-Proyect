CREATE VIEW datos_personales AS
SELECT 
	fichas_datos_personales.dni as DNI,
    fichas_datos_personales.apellido as Apellido,
    CONCAT(fichas_datos_personales.nombre1,' ', fichas_datos_personales.nombre2) as Nombres,
    fichas_datos_personales.fecha_nacimiento as 'Fecha Nacimiento',
    fichas_datos_personales.email as 'E-mail',
	CONCAT(datos_domicilios.calle,' ', datos_domicilios.altura_calle) as 'Domicilio',
    datos_domicilios.codigo_postal as 'CP',
    CONCAT(datos_domicilios.localidad,'/',datos_domicilios.provincia,'/',datos_domicilios.pais) as 'Ubicacion',
    datos_telefonicos.telefono_movil as 'Telefono Movil',
    datos_telefonicos.telefono_fijo as 'Telefono fijo',
    datos_telefonicos.telefono_urgencia as 'Contacto Urgencia'
FROM fichas_datos_personales 
LEFT JOIN datos_domicilios ON fichas_datos_personales.dni = datos_domicilios.dni
LEFT JOIN datos_telefonicos ON fichas_datos_personales.dni = datos_telefonicos.dni;
