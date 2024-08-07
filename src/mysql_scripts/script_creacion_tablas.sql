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

-- Tabla contadores.
CREATE TABLE contadores (
    id_contador INT AUTO_INCREMENT,
    fecha DATE NOT NULL UNIQUE,
    turnos_otorgados INT,
    recepciones_pacientes INT,
    ocupaciones_consultorios INT,
    registros_historias_clinicas INT,
    PRIMARY KEY (id_contador)
);

-- Tabla roles usuarios sistema
CREATE TABLE tipos_usuario_sistema (
    codigo_tipo_usuario VARCHAR(30),
    nombre_tipo_usuario VARCHAR(30) UNIQUE NOT NULL,
    PRIMARY KEY (codigo_tipo_usuario)
);

-- Tabla de funciones empleados.
CREATE TABLE funciones_empleados(
    codigo_funcion_empleado VARCHAR(30),
    nombre_funcion_empleado VARCHAR(30) UNIQUE,
    codigo_tipo_usuario_sistema VARCHAR(30), -- Relacion funcion empleado - Privilegios en sistema.
    PRIMARY KEY (codigo_funcion_empleado),
    FOREIGN KEY (codigo_tipo_usuario_sistema) REFERENCES tipos_usuario_sistema(codigo_tipo_usuario) ON UPDATE CASCADE ON DELETE SET NULL
);

-- Tabla de estados turnos.
CREATE TABLE estados_turnos (
    id_estado_turno INT AUTO_INCREMENT,
    estado_turno VARCHAR(30),
    PRIMARY KEY (id_estado_turno)
);

-- Tabla de Prestaciones de obras sociales.
CREATE TABLE prestaciones_obras_sociales (
    id_prestacion_obra_social INT AUTO_INCREMENT,
    obra_social VARCHAR(255),
    plan VARCHAR(255),
    en_servicio BOOLEAN,
    PRIMARY KEY (id_prestacion_obra_social)
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
    PRIMARY KEY (id_consultorio)
);

-- Tabla especialidades
CREATE TABLE especialidades_medicas (
    id_especialidad INT AUTO_INCREMENT,
    nombre_especialidad VARCHAR(100),
    PRIMARY KEY (id_especialidad)
);


-- Tabla de Usuarios del Sistema
CREATE TABLE usuarios_sistema (
    user_system_id VARCHAR(30),
    user_password VARCHAR(255) NOT NULL,
    user_tipo VARCHAR(30) DEFAULT NULL,
    user_status BOOLEAN DEFAULT FALSE,
    user_last_connection DATE DEFAULT NULL,
    user_password_recovery_code VARCHAR(30) DEFAULT NULL,
    user_password_recovery_expiration DATE DEFAULT NULL,
    PRIMARY KEY (user_system_id),
    FOREIGN KEY (user_tipo) REFERENCES tipos_usuario_sistema(nombre_tipo_usuario) ON UPDATE CASCADE ON DELETE SET NULL
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
    -- id_datos_domicilio VARCHAR(30) DEFAULT NULL,
    -- id_datos_telefonicos VARCHAR(30) DEFAULT NULL, 
    user_system_id VARCHAR(30) DEFAULT NULL,
    PRIMARY KEY (id_ficha_datos_personales),
    -- FOREIGN KEY (id_datos_domicilio) REFERENCES datos_domicilios(id_datos_domicilio) ON UPDATE CASCADE  ON DELETE SET NULL,
    -- FOREIGN KEY (id_datos_telefonicos) REFERENCES datos_telefonicos(id_datos_telefonicos) ON UPDATE CASCADE  ON DELETE SET NULL,
    FOREIGN KEY (user_system_id) REFERENCES usuarios_sistema(user_system_id) ON UPDATE CASCADE ON DELETE SET NULL
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





-- Tabla de Pacientes
CREATE TABLE pacientes (
    legajo_paciente VARCHAR(30),
    dni VARCHAR(30) UNIQUE NOT NULL,
    PRIMARY KEY (legajo_paciente),
    FOREIGN KEY (dni) REFERENCES fichas_datos_personales(dni) ON UPDATE CASCADE ON DELETE CASCADE
    -- FOREIGN KEY (user_system) REFERENCES usuarios_sistema(user_id)
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


 -- Tabla de Médicos
CREATE TABLE prestaciones_medicas (
    id_prestacion_medica INT AUTO_INCREMENT,
    id_especialidad INT,
    matricula_medico VARCHAR(30),
    legajo_empleado VARCHAR(30) NOT NULL, /*Obvio debe ser medico...*/
    PRIMARY KEY (id_prestacion_medica),
    FOREIGN KEY (id_especialidad) REFERENCES especialidades_medicas(id_especialidad) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (legajo_empleado) REFERENCES empleados(legajo_empleado) ON UPDATE CASCADE ON DELETE CASCADE
);


-- Tabla para relacionar las prestaciones de obra social con las prestaciones médicas de los médicos
CREATE TABLE prestaciones_habilitadas_medicos (
    id_prestacion_habilitada INT AUTO_INCREMENT,
    id_prestacion_medica INT,
    id_prestacion_obra_social INT,
    PRIMARY KEY (id_prestacion_habilitada),
    FOREIGN KEY (id_prestacion_medica) REFERENCES prestaciones_medicas(id_prestacion_medica) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_prestacion_obra_social) REFERENCES prestaciones_obras_sociales(id_prestacion_obra_social) ON UPDATE CASCADE ON DELETE CASCADE
);



-- Tabla de Ocupación de Consultorios
CREATE TABLE registros_historias_clinicas (
    id_registro VARCHAR(30),
    id_prestacion_medica INT,
    legajo_paciente VARCHAR(30),
    diagnostico TEXT,
    observaciones TEXT,
    medicacion TEXT,
    fecha_hora DATETIME,
    PRIMARY KEY (id_registro),
    FOREIGN KEY (id_prestacion_medica) REFERENCES prestaciones_medicas(id_prestacion_medica) ,
    FOREIGN KEY (legajo_paciente) REFERENCES pacientes(legajo_paciente)
);

-- Tabla de Anuncios en Recepción
CREATE TABLE turnos_otorgados (
    id_turno VARCHAR(30),
    id_prestacion_medica INT,
    legajo_paciente VARCHAR(30) NOT NULL,
    fecha_hora_reservada DATETIME,
    id_prestacion_obra_social_inicial INT,
    fecha_hora_otorgamiento DATETIME,
    user_system_otorgante_turno VARCHAR(30),
    estado_turno INT,
    PRIMARY KEY (id_turno),
    FOREIGN KEY (id_prestacion_medica) REFERENCES prestaciones_medicas(id_prestacion_medica),
    FOREIGN KEY (legajo_paciente) REFERENCES pacientes(legajo_paciente),
    FOREIGN KEY (id_prestacion_obra_social_inicial) REFERENCES prestaciones_obras_sociales(id_prestacion_obra_social),
    FOREIGN KEY (estado_turno) REFERENCES estados_turnos(id_estado_turno) ON UPDATE CASCADE ON DELETE SET NULL
);

-- Tabla de Ocupación de Consultorios
CREATE TABLE ocupacion_consultorios (
    id_ocupacion_consultorio VARCHAR(30),
    legajo_empleado VARCHAR(30),
    id_consultorio INT NOT NULL,
    fecha_hora_inicio DATETIME NOT NULL,
    fecha_hora_fin DATETIME,
    PRIMARY KEY (id_ocupacion_consultorio),
    FOREIGN KEY (legajo_empleado) REFERENCES empleados(legajo_empleado) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (id_consultorio) REFERENCES consultorios(id_consultorio) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabla de Anuncios en Recepción
CREATE TABLE recepcion_pacientes (
    id_recepcion_paciente VARCHAR(30),
    id_puesto_recepcion INT DEFAULT NULL,
    id_turno VARCHAR(30), 
    id_consultorio_asignado INT,
    id_prestacion_obra_social_final INT,
    fecha_hora_anuncio DATETIME,
    fecha_hora_ingreso_consultorio DATETIME,
    fecha_hora_egreso_consultorio DATETIME,
    PRIMARY KEY (id_recepcion_paciente),
    FOREIGN KEY (id_turno) REFERENCES turnos_otorgados(id_turno) ON UPDATE CASCADE ON DELETE CASCADE, 
    FOREIGN KEY (id_consultorio_asignado) REFERENCES consultorios(id_consultorio) ON UPDATE CASCADE ON DELETE CASCADE ,
    FOREIGN KEY (id_prestacion_obra_social_final) REFERENCES prestaciones_obras_sociales(id_prestacion_obra_social)  ON UPDATE CASCADE ON DELETE CASCADE
);


