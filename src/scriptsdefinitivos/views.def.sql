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

CREATE VIEW datos_personales_medicos AS
SELECT 
	medicos.id_medico as id_medico,
	especialidades_medicas.nombre_especialidad_medica as Especialidad,
	vista_empleados_personas.apellido,
	vista_empleados_personas.nombres
FROM medicos
INNER JOIN especialidades_medicas ON medicos.id_especialidad_medica = especialidades_medicas.id_especialidad_medica
INNER JOIN 
	(SELECT 
		empleados.dni as DNI,
        empleados.legajo_empleado as legajo_empleado,
		datos_personales.apellido as Apellido,
		datos_personales.nombres as Nombres
		FROM empleados
		INNER JOIN datos_personales ON empleados.dni = datos_personales.dni) AS vista_empleados_personas ON medicos.legajo_empleado = vista_empleados_personas.legajo_empleado;


/*------------------------------------------ */

SELECT 
    prestaciones_medicas.id_prestacion_medica,
    especialidades_medicas.nombre_especialidad_medica,
    prestaciones_medicas.id_especialidad_medica,
    prestaciones_medicas.id_medico,
    prestaciones_medicas.id_sede_establecimiento,
    datos_personales_medicos.apellido,
    datos_personales_medicos.nombres
FROM prestaciones_medicas
LEFT JOIN datos_personales_medicos ON prestaciones_medicas.id_medico = datos_personales_medicos.id_medico
LEFT JOIN especialidades_medicas ON prestaciones_medicas.id_prestacion_medica = especialidades_medicas.id_especialidad_medica
LEFT JOIN sedes_establecimiento ON prestaciones_medicas.id_sede_establecimiento = sedes_establecimiento.id_sede_establecimiento;