CREATE DATABASE administracionconsultorios;
USE administracionconsultorios;

-- Tabla para ingresar datos en formato JSON.
CREATE TABLE datos_ingresados_json(
    id_ingreso_datos INT AUTO_INCREMENT,
    ingresado DATETIME DEFAULT NOW(),
    categoria ENUM ('datos_personales','empleados','pacientes','turnos'),
    data JSON,
    PRIMARY KEY(id_ingreso_datos)
);


-- Tabla de sedes del establecimiento
CREATE TABLE sedes_establecimiento (
    id_sede_establecimiento INT AUTO_INCREMENT,
    nombre_sede VARCHAR(100),
    en_servicio BOOLEAN,
    PRIMARY KEY (id_sede_establecimiento)
);


-- Tabla de Consultorios
CREATE TABLE consultorios (
    id_consultorio INT AUTO_INCREMENT,
    id_sede_establecimiento INT DEFAULT NULL,
    nombre_consultorio VARCHAR(100),
    en_servicio BOOLEAN,
    disponible BOOLEAN,
    PRIMARY KEY (id_consultorio),
    FOREIGN KEY (id_sede_establecimiento) REFERENCES sedes_establecimiento(id_sede_establecimiento) ON UPDATE CASCADE ON DELETE CASCADE
);




-- Tabla de datos personales
CREATE TABLE fichas_datos_personales (
    id_ficha_datos_personales INT AUTO_INCREMENT,
    dni VARCHAR(30) UNIQUE,
    nombre1 VARCHAR(255),
    nombre2 VARCHAR(255) DEFAULT NULL,
    apellido VARCHAR(255) DEFAULT NULL,
    fecha_nacimiento DATE DEFAULT NULL ,
    email VARCHAR(254) NOT NULL,
    PRIMARY KEY (id_ficha_datos_personales)
);


-- Tabla datos domicilios
CREATE TABLE datos_domicilios (
    id_datos_domicilio INT AUTO_INCREMENT,
    dni VARCHAR(30) UNIQUE,
    calle VARCHAR(255) DEFAULT NULL,
    altura_calle INT DEFAULT NULL,
    codigo_postal VARCHAR(20) DEFAULT NULL,
    localidad VARCHAR(100) DEFAULT NULL,
    provincia VARCHAR(100) DEFAULT NULL,
    pais VARCHAR(100) DEFAULT NULL,
    latitud DECIMAL(10, 8) DEFAULT '0.0', 
    longitud DECIMAL(11, 8) DEFAULT '0.0',
    PRIMARY KEY (id_datos_domicilio),
    FOREIGN KEY (dni) REFERENCES fichas_datos_personales(dni) ON UPDATE CASCADE ON DELETE CASCADE
);



-- Tabla datos_telefonicos
CREATE TABLE datos_telefonicos (
    id_datos_telefonicos  INT AUTO_INCREMENT,
    dni VARCHAR(30) UNIQUE,
    telefono_movil VARCHAR(30) DEFAULT NULL,
    telefono_fijo VARCHAR(30) DEFAULT NULL,
    telefono_urgencia VARCHAR(30) DEFAULT NULL,
    PRIMARY KEY (id_datos_telefonicos),
    FOREIGN KEY (dni) REFERENCES fichas_datos_personales(dni) ON UPDATE CASCADE ON DELETE CASCADE
);


-- Tabla roles usuarios sistema
CREATE TABLE tipos_permisos_sistema (
    codigo_tipo_permiso VARCHAR(30),
    nombre_tipo_usuario VARCHAR(30) UNIQUE NOT NULL,
    PRIMARY KEY (codigo_tipo_permiso)
);

-- Tabla de Usuarios del Sistema
CREATE TABLE usuarios_sistema (
    user_system_id VARCHAR(30),
    dni VARCHAR(30) UNIQUE,
    user_password VARCHAR(255) NOT NULL,
    user_system_role VARCHAR(30) DEFAULT NULL,
    user_status BOOLEAN DEFAULT FALSE,
    user_last_connection DATE DEFAULT NULL,
    user_password_recovery_code VARCHAR(30) DEFAULT NULL,
    user_password_recovery_expiration DATE DEFAULT NULL,
    PRIMARY KEY (user_system_id),
    FOREIGN KEY (dni) REFERENCES fichas_datos_personales(dni) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabla de permisos de cada usuario del sistema;
CREATE TABLE permisos_usuarios_sistema (ser_system_id VARCHAR(30),
    dni VARCHAR(30) UNIQUE,
    codigo_tipo_permiso VARCHAR(30),
    FOREIGN KEY (dni) REFERENCES usuarios_sistema(dni) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (codigo_tipo_permiso) REFERENCES tipos_permisos_sistema(codigo_tipo_permiso) ON UPDATE CASCADE ON DELETE SET NULL
);




-- Tabla de Pacientes
CREATE TABLE pacientes (
    legajo_paciente VARCHAR(30),
    dni VARCHAR(30) UNIQUE NOT NULL,
    PRIMARY KEY (legajo_paciente),
    FOREIGN KEY (dni) REFERENCES fichas_datos_personales(dni) ON UPDATE CASCADE ON DELETE CASCADE
);


-- Tabla de funciones empleados.
CREATE TABLE funciones_empleados(
    codigo_funcion_empleado VARCHAR(30),
    nombre_funcion_empleado VARCHAR(30) UNIQUE,
    PRIMARY KEY (codigo_funcion_empleado)
);


-- Tabla de Empleados
CREATE TABLE empleados (
    legajo_empleado VARCHAR(30),
    dni VARCHAR(30) UNIQUE NOT NULL,
    codigo_funcion_empleado VARCHAR(30),
    PRIMARY KEY (legajo_empleado),
    FOREIGN KEY (dni) REFERENCES fichas_datos_personales(dni) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (codigo_funcion_empleado) REFERENCES funciones_empleados(codigo_funcion_empleado) ON UPDATE CASCADE ON DELETE SET NULL
 );


-- Tabla especialidades
CREATE TABLE especialidades_medicas (
    id_especialidad_medica INT AUTO_INCREMENT,
    nombre_especialidad_medica VARCHAR(100),
    PRIMARY KEY (id_especialidad_medica)
);

 -- Tabla de Medicos
CREATE TABLE medicos (
    id_medico INT AUTO_INCREMENT,
    legajo_empleado VARCHAR(30),
    id_especialidad_medica INT,
    matricula_medico VARCHAR(30) UNIQUE,
    PRIMARY KEY (id_medico),
    FOREIGN KEY (legajo_empleado) REFERENCES empleados(legajo_empleado) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_especialidad_medica) REFERENCES especialidades_medicas(id_especialidad_medica) ON UPDATE CASCADE ON DELETE SET NULL
);



 -- Tabla de Médicos
CREATE TABLE prestaciones_medicas (
    id_prestacion_medica INT AUTO_INCREMENT,
    id_especialidad_medica INT,
    id_medico INT,
    id_sede_establecimiento INT,
    PRIMARY KEY (id_prestacion_medica),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_sede_establecimiento) REFERENCES sedes_establecimiento(id_sede_establecimiento) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_especialidad_medica) REFERENCES especialidades_medicas(id_especialidad_medica) ON UPDATE CASCADE ON DELETE SET NULL
);

-- Tabla de estados turnos.
CREATE TABLE estados_turnos (
    id_estado_turno INT AUTO_INCREMENT,
    estado_turno VARCHAR(30),
    PRIMARY KEY (id_estado_turno)
);

-- Hay que hacer un trigger que no permita que para un id_prestacion_medica se repita la combinacion fecha_turno,horario inicio y horario fin.
CREATE TABLE turnos(
    id_turno INT AUTO_INCREMENT,
    id_prestacion_medica INT NOT NULL,
    fecha_turno DATE,
    horario_cita TIME, -- SI es sobreturno debe ser null...
    legajo_paciente VARCHAR(30),
    es_sobreturno BOOLEAN NOT NULL,
    PRIMARY KEY (id_turno),
    FOREIGN KEY (id_prestacion_medica) REFERENCES prestaciones_medicas(id_prestacion_medica) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (legajo_paciente) REFERENCES pacientes(legajo_paciente) ON UPDATE CASCADE ON DELETE SET NULL
);



-- Desde que ingresan al establecimiento hasta irse, lleva trigger para llenar seguimiento turnos
CREATE TABLE seguimiento_pacientes(
    id_seguimiento_paciente INT AUTO_INCREMENT,
    id_turno INT,
    horario_llegada DATETIME,
    horario_ingreso_atencion DATETIME,
    horario_egreso_atencion DATETIME,
    PRIMARY KEY (id_seguimiento_paciente),
    FOREIGN KEY (id_turno) REFERENCES turnos(id_turno) ON UPDATE CASCADE ON DELETE CASCADE
);


-- NAce por los updated de la tabla turnos, llegadas a consultorio, ingreso y egreso a consultorios.
CREATE TABLE seguimiento_turnos(
    id_evento_turno INT AUTO_INCREMENT,
    id_turno INT,
    id_estado_turno INT,
    PRIMARY KEY (id_evento_turno),
    FOREIGN KEY (id_turno) REFERENCES turnos(id_turno) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_estado_turno) REFERENCES estados_turnos(id_estado_turno) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE ocupacion_consultorios_prestacion_medica (
    id_ocupacion_consultorios_prestacion_medica INT AUTO_INCREMENT,
    id_prestacion_medica INT,
    hora_inicio DATETIME,
    hora_finalizacion DATETIME,
    PRIMARY KEY (id_ocupacion_consultorios_prestacion_medica),
    FOREIGN KEY (id_prestacion_medica) REFERENCES prestaciones_medicas(id_prestacion_medica) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabla de Prestaciones de obras sociales disponibles.
CREATE TABLE prestaciones_obras_sociales (
    id_prestacion_obra_social INT AUTO_INCREMENT,
    obra_social VARCHAR(255),
    plan VARCHAR(255),
    en_servicio BOOLEAN,
    PRIMARY KEY (id_prestacion_obra_social)
);

-- Prestaciones de obras sociales disponibles por prestacion medica para poder seleccionar.
CREATE TABLE obras_sociales_disponibles_prestaciones_medicas(
    id_prestacion_disponible INT AUTO_INCREMENT,
    id_prestacion_medica INT NOT NULL,
    id_prestacion_obra_social INT NOT NULL,
    PRIMARY KEY (id_prestacion_disponible),
    FOREIGN KEY (id_prestacion_medica) REFERENCES prestaciones_medicas(id_prestacion_medica) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_prestacion_obra_social) REFERENCES prestaciones_obras_sociales(id_prestacion_obra_social) ON UPDATE CASCADE ON DELETE CASCADE
);


-- Tabla de registros historias clinicas.
/* SI mañana desaparece el medico de la base de datos queda id_medico en not null entonces es interesante
 un trigger luego de insercion que tome los datos y esto vaya a una tabla que solo almacena y guarda la 
 informacion texttual e inmmodificable. Esta tabla puede servir para busquedas e insercion,pero la historica
 es simplemente para informacion.
*/
CREATE TABLE registros_historias_clinicas (
    id_registro_historia_clinica VARCHAR(30),
    id_prestacion_medica INT,
    legajo_paciente VARCHAR(30),
    id_medico INT,
    diagnostico TEXT,
    observaciones TEXT,
    medicacion TEXT,
    fecha_hora DATETIME,
    PRIMARY KEY (id_registro_historia_clinica),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico) ON UPDATE CASCADE ON DELETE SET NULL ,
    FOREIGN KEY (legajo_paciente) REFERENCES pacientes(legajo_paciente)
);


/* Esta tabla nacera por accion de un trigger ...*/
CREATE TABLE registros_seguro_historias_clinicas (
    id_registro_seguro_historia_clinica INT AUTO_INCREMENT,
    dni_paciente VARCHAR(30) NOT NULL,   
    apellido_paciente VARCHAR(100) NOT NULL,
    nombre_paciente VARCHAR(100) NOT NULL,
    matricula_medico vARCHAR(30) NOT NULL,    
    apellido_medico VARCHAR(100) NOT NULL,
    nombre_medico VARCHAR(100) NOT NULL,
    diagnostico TEXT NOT NULL,
    observaciones TEXT NOT NULL,
    medicacion TEXT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    PRIMARY KEY(id_registro_seguro_historia_clinica)
);

/* Esta tabla debe tener un trigger para registros de uso*/
CREATE TABLE uso_consultorios (
    id_uso_consultorios INT AUTO_INCREMENT,
    id_consultorio INT,
    hora_inicio DATETIME,
    hora_finalizacion DATETIME,
    legajo_empleado VARCHAR(30),
    detalle_uso TEXT,
    PRIMARY KEY (id_uso_consultorios),
    FOREIGN KEY (legajo_empleado) REFERENCES empleados(legajo_empleado) ON UPDATE CASCADE ON DELETE CASCADE
)




