CREATE DATABASE administracionconsultorios;
USE administracionconsultorios;

-- Tabla roles usuarios sistema
CREATE TABLE roles_usuario_sistema(
    id_user_rol INT AUTO_INCREMENT,
    rol VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_user_rol)
);

-- Tabla de roles empleados
CREATE TABLE roles_empleados(
    id_funcion INT AUTO_INCREMENT,
    funcion VARCHAR(30) NOT NULL,
    abreviatura_funcion VARCHAR(3) UNIQUE,
    PRIMARY KEY (id_funcion)
);

-- Tabla de estados turnos.
CREATE TABLE estados_turnos (
    id_estado_turno INT AUTO_INCREMENT,
    estado_turno VARCHAR(30),
    PRIMARY KEY (id_estado_turno)
);

-- Tabla de Prestaciones
CREATE TABLE prestaciones (
    id_prestacion INT AUTO_INCREMENT,
    obra_social VARCHAR(255),
    plan VARCHAR(255),
    activa BOOLEAN,
    PRIMARY KEY (id_prestacion)
);

-- Tabla de Consultorios
CREATE TABLE consultorios (
    numero_consultorio INT,
    en_servicio BOOLEAN,
    PRIMARY KEY (numero_consultorio)
);

-- Tabla especialidades
CREATE TABLE especialidades_medicas (
    id_especialidad INT AUTO_INCREMENT,
    nombre VARCHAR(100),
    PRIMARY KEY (id_especialidad)
);

-- Tabla datos domicilios
CREATE TABLE datos_domicilios (
    id_datos_domicilio INT AUTO_INCREMENT,
    calle VARCHAR(255) NOT NULL,
    altura_calle INT NOT NULL,
    codigo_postal VARCHAR(20) NOT NULL,
    localidad VARCHAR(100) NOT NULL,
    provincia VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    latitud DECIMAL(10, 8) DEFAULT '0.0', 
    longitud DECIMAL(11, 8) DEFAULT '0.0',
    PRIMARY KEY (id_datos_domicilio)
);

-- Tabla datos_telefonicos
CREATE TABLE datos_telefonicos (
    id_datos_telefonicos INT AUTO_INCREMENT,
    telefono_celular VARCHAR(30) NOT NULL,
    telefono_fijo VARCHAR(30),
    telefono_urgencia VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_datos_telefonicos)
);


-- Tabla de Usuarios del Sistema
CREATE TABLE usuarios_sistema (
    user_id VARCHAR(30),
    user_email VARCHAR(254),
    user_password VARCHAR(255) NOT NULL,
    user_rol INT,
    user_status BOOLEAN DEFAULT TRUE,
    user_last_connection DATE DEFAULT NULL,
    user_password_recovery_code VARCHAR(30) DEFAULT NULL,
    user_password_recovery_expiration DATE DEFAULT NULL,
    PRIMARY KEY (user_id),
    FOREIGN KEY (user_rol) REFERENCES roles_usuario_sistema(id_user_rol)
);


-- Tabla de datos personales
CREATE TABLE datos_personales (
    dni VARCHAR(30),
    nombre1 VARCHAR(255) NOT NULL,
    nombre2 VARCHAR(255) DEFAULT NULL,
    apellido VARCHAR(255) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    domicilio INT,
    telefonos INT, 
    email_contacto VARCHAR(254),
    PRIMARY KEY (dni),
    FOREIGN KEY (domicilio) REFERENCES datos_domicilios(id_datos_domicilio),
    FOREIGN KEY (telefonos) REFERENCES datos_telefonicos(id_datos_telefonicos)
);



-- Tabla de Empleados
CREATE TABLE empleados (
    legajo_empleado VARCHAR(30),
    dni VARCHAR(30),
    user_system VARCHAR(30) DEFAULT NULL,
    id_funcion INT,
    PRIMARY KEY (legajo_empleado),
    FOREIGN KEY (dni) REFERENCES datos_personales(dni),
    FOREIGN KEY (user_system) REFERENCES usuarios_sistema(user_id),
    FOREIGN KEY (id_funcion) REFERENCES roles_empleados(id_funcion)
 );

 -- Tabla de Médicos
CREATE TABLE medicos (
    matricula_medico VARCHAR(30),
    dni VARCHAR(30),
    id_especialidad INT,
    PRIMARY KEY (matricula_medico),
    FOREIGN KEY (dni) REFERENCES datos_personales(dni),
    FOREIGN KEY (id_especialidad) REFERENCES especialidades_medicas(id_especialidad)
);


-- Tabla de Pacientes
CREATE TABLE pacientes (
    legajo_paciente VARCHAR(30),
    dni VARCHAR(30),
    user_system VARCHAR(30) DEFAULT NULL,
    PRIMARY KEY (legajo_paciente),
    FOREIGN KEY (dni) REFERENCES datos_personales(dni),
    FOREIGN KEY (user_system) REFERENCES usuarios_sistema(user_id)
);



-- Tabla de Ocupación de Consultorios
CREATE TABLE registros_historias_clinicas (
    id_registro VARCHAR(30),
    matricula_medico VARCHAR(30),
    legajo_paciente VARCHAR(30),
    diagnostico TEXT,
    observaciones TEXT,
    medicacion TEXT,
    fecha_hora DATETIME,
    PRIMARY KEY (id_registro),
    FOREIGN KEY (matricula_medico) REFERENCES medicos(matricula_medico),
    FOREIGN KEY (legajo_paciente) REFERENCES pacientes(legajo_paciente)
);


-- Tabla de Anuncios en Recepción
CREATE TABLE turnos_otorgados (
    id_turno VARCHAR(30),
    matricula_medico VARCHAR(30) NOT NULL,
    legajo_paciente VARCHAR(30) NOT NULL,
    fecha_hora_reservada DATETIME,
    id_prestacion_tentativa INT,
    fecha_hora_otorgamiento DATETIME,
    dni_otorgante_turno VARCHAR(30),
    estado_turno INT,
    consultorio_asignado INT,
    PRIMARY KEY (id_turno),
    FOREIGN KEY (matricula_medico) REFERENCES medicos(matricula_medico),
    FOREIGN KEY (legajo_paciente) REFERENCES pacientes(legajo_paciente),
    FOREIGN KEY (id_prestacion_tentativa) REFERENCES prestaciones(id_prestacion),
    FOREIGN KEY (estado_turno) REFERENCES estados_turnos(id_estado_turno),
    FOREIGN KEY (consultorio_asignado) REFERENCES consultorios(numero_consultorio)
);

-- Tabla de Ocupación de Consultorios
CREATE TABLE ocupacion_consultorios (
    id_ocupacion VARCHAR(30),
    legajo_empleado VARCHAR(30) NOT NULL,
    numero_consultorio INT NOT NULL,
    fecha_hora_inicio DATETIME NOT NULL,
    fecha_hora_fin DATETIME NOT NULL,
    PRIMARY KEY (id_ocupacion),
    FOREIGN KEY (legajo_empleado) REFERENCES empleados(legajo_empleado),
    FOREIGN KEY (numero_consultorio) REFERENCES consultorios(numero_consultorio)
);

-- Tabla de Anuncios en Recepción
CREATE TABLE registro_visitas_pacientes (
    id_visita VARCHAR(30),
    id_turno VARCHAR(30), 
    consultorio_asignado INT,
    prestacion_efectiva INT,
    fecha_hora_anuncio DATETIME,
    fecha_hora_ingreso_consultorio DATETIME,
    fecha_hora_egreso_consultorio DATETIME,
    PRIMARY KEY (id_visita),
    FOREIGN KEY (id_turno) REFERENCES turnos_otorgados(id_turno), 
    FOREIGN KEY (consultorio_asignado) REFERENCES consultorios(numero_consultorio),
    FOREIGN KEY (prestacion_efectiva) REFERENCES prestaciones(id_prestacion)
);


CREATE TABLE contador_id_asignados (
    id_contador_id_asignados INT AUTO_INCREMENT,
    turnos_otorgados INT,
    visitas_pacientes INT,
    ocupaciones_consultorios INT,
    registros_historias_clinicas INT,
    PRIMARY KEY (id_contador_id_asignados)
);