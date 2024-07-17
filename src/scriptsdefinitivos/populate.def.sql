-- Tabla sedes_establecimiento
INSERT INTO sedes_establecimiento
(nombre_sede,en_servicio)
VALUES
('Sede 1',true),
('Sede 2', true),
('Sede 3', false);

-- Tabla consultorios
INSERT INTO consultorios
(id_sede_establecimiento, nombre_consultorio, en_servicio, disponible)
VALUES
(1, 101, true, true),
(1, 102, true, true),
(1, 103, true, true),
(1, 104, true, true),
(1, 201, false, true),
(1, 202, true, true),
(2, 203, false, true),
(2, 101, true, true),
(2, 102, true, true),
(2, 103, true, true),
(2, 104, true, true),
(2, 201, false, true),
(2, 202, true, true),
(2, 203, true, true);


-- Tabla de tipos_permisos_sistema les_usuario_sistema
INSERT INTO tipos_permisos_sistema 
(codigo_tipo_permiso, nombre_tipo_usuario)
VALUES  
('DEV','user_dev'),
('ADM','user_admin'),
('REC','user_recepcion'),
('MED','user_medico'),
('PAC','user_paciente'),
('EMP','user_empleado'),
('ENF','user_enfermeria');


--  Creando fichas datos personales.
CALL crear_ficha_datos_personales('12345678', 'Juan', '', 'Perez', '1990-05-15', 'juan@example.com', 'San Martín', 456, '1234', 'Rosario', 'Santa Fe', 'Argentina', -34.6037, -58.3816, '1122334455', '2233445566', '911');
CALL crear_ficha_datos_personales('98765432', 'María', 'Luisa', 'Gómez', '1985-08-20', 'maria@example.com', 'Belgrano', 789, '5678', 'Córdoba', 'Córdoba', 'Argentina', -12.0464, -77.0428, '9988776655', '7766554433', '911');
CALL crear_ficha_datos_personales('56789012', 'Pedro', 'José', 'Martinez', '1978-02-10', 'pedro@example.com', 'Independencia', 321, '9012', 'Mendoza', 'Mendoza', 'Argentina', 40.7128, -74.006, '1231231234', '4564564567', '911');
CALL crear_ficha_datos_personales('34567890', 'Ana', 'Lucía', 'Rodriguez', '1983-11-25', 'ana@example.com', 'Avenida Rivadavia', 654, '3456', 'Buenos Aires', 'Buenos Aires', 'Argentina', -22.9068, -43.1729, '9876543210', '5678901234', '911');
CALL crear_ficha_datos_personales('13579246', 'Carlos', '', 'González', '1987-04-03', 'carlos@example.com', 'San Juan', 753, '6789', 'San Juan', 'San Juan', 'Argentina', 41.3851, 2.1734, '5555555555', '6666666666', '911');
CALL crear_ficha_datos_personales('24680135', 'Laura', 'Isabel', 'Hernández', '1995-09-18', 'laura@example.com', 'General Paz', 852, '4321', 'La Plata', 'Buenos Aires', 'Argentina', -33.4489, -70.6693, '7777777777', '8888888888', '911');
CALL crear_ficha_datos_personales('98765433', 'Luis', 'Alberto', 'Martínez', '1980-07-12', 'luis@example.com', 'Roca', 567, '2345', 'Neuquén', 'Neuquén', 'Argentina', -34.6037, -58.3816, '1111111111', '2222222222', '911');
CALL crear_ficha_datos_personales('78901234', 'Julia', '', 'García', '1991-03-25', 'julia@example.com', 'San Luis', 789, '6789', 'San Luis', 'San Luis', 'Argentina', -12.0464, -77.0428, '3333333333', '4444444444', '911');
CALL crear_ficha_datos_personales('90123456', 'Miguel', 'Ángel', 'Suárez', '1988-11-08', 'miguel@example.com', 'San Juan', 963, '4567', 'San Juan', 'San Juan', 'Argentina', 40.7128, -74.006, '5555555555', '6666666666', '911');
CALL crear_ficha_datos_personales('65432109', 'Carolina', '', 'López', '1986-09-30', 'carolina@example.com', 'Alem', 357, '7890', 'Bahía Blanca', 'Buenos Aires', 'Argentina', -22.9068, -43.1729, '7777777777', '8888888888', '911');
CALL crear_ficha_datos_personales('11112222', 'Martín', 'Alejandro', 'Díaz', '1989-12-15', 'martin@example.com', 'Sarmiento', 246, '1357', 'Salta', 'Salta', 'Argentina', -24.7829, -65.4125, '9999999999', '8888888888', '911');
CALL crear_ficha_datos_personales('33334444', 'Lucía', '', 'Fernández', '1982-06-20', 'lucia@example.com', 'San Lorenzo', 789, '2468', 'San Fernando', 'Buenos Aires', 'Argentina', -34.4491, -58.5778, '7777777777', '6666666666', '911');
CALL crear_ficha_datos_personales('55556666', 'Diego', 'Alejandro', 'Giménez', '1992-04-10', 'diego@example.com', 'Maipú', 357, '1593', 'San Miguel de Tucumán', 'Tucumán', 'Argentina', -26.8083, -65.2176, '5555555555', '4444444444', '911');
CALL crear_ficha_datos_personales('77778888', 'Valentina', '', 'López', '1994-08-25', 'valentina@example.com', 'Balcarce', 963, '3579', 'Mar del Plata', 'Buenos Aires', 'Argentina', -38.0055, -57.5426, '3333333333', '2222222222', '911');
CALL crear_ficha_datos_personales('99990000', 'Lucas', 'Emilio', 'Mendoza', '1984-10-05', 'lucas@example.com', 'San Martín', 654, '4680', 'San Rafael', 'Mendoza', 'Argentina', -34.6177, -68.3301, '1111111111', '9999999999', '911');
CALL crear_ficha_datos_personales('12121212', 'Camila', '', 'Pérez', '1993-02-28', 'camila@example.com', 'Bartolomé Mitre', 852, '2468', 'La Rioja', 'La Rioja', 'Argentina', -29.4131, -66.8563, '7777777777', '6666666666', '911');
CALL crear_ficha_datos_personales('34343434', 'Julián', 'Andrés', 'Ríos', '1981-11-15', 'julian@example.com', 'San Martín', 357, '5791', 'San Salvador de Jujuy', 'Jujuy', 'Argentina', -24.1855, -65.2995, '5555555555', '4444444444', '911');
CALL crear_ficha_datos_personales('56565656', 'Martina', '', 'Sánchez', '1987-07-10', 'martina@example.com', 'Gral. Güemes', 963, '3579', 'Salta', 'Salta', 'Argentina', -24.7859, -65.4117, '3333333333', '2222222222', '911');
CALL crear_ficha_datos_personales('78787878', 'Felipe', 'Javier', 'Torres', '1990-09-15', 'felipe@example.com', 'San Martín', 654, '4680', 'Mendoza', 'Mendoza', 'Argentina', -32.8895, -68.8458, '1111111111', '9999999999', '911');

-- Creacion de users con permisos a eleccion. La politica de los niveles de usuario se dejara al backend y no a la base de datos por lo cual ahora se cargan aleatorios.

CALL crear_usuario_sistema('12345678', 'MED', CONCAT('password123456789', '12345678')); -- Juan Perez - MED
CALL crear_usuario_sistema('98765432', 'REC', CONCAT('password123456789', '98765432')); -- María Luisa Gómez - REC
CALL crear_usuario_sistema('56789012', 'PAC', CONCAT('password123456789', '56789012')); -- Pedro José Martinez - PAC
CALL crear_usuario_sistema('34567890', 'EMP', CONCAT('password123456789', '34567890')); -- Ana Lucía Rodriguez - EMP
CALL crear_usuario_sistema('13579246', 'ENF', CONCAT('password123456789', '13579246')); -- Carlos González - ENF
CALL crear_usuario_sistema('24680135', 'ADM', CONCAT('password123456789', '24680135')); -- Laura Isabel Hernández - ADM
CALL crear_usuario_sistema('98765433', 'DEV', CONCAT('password123456789', '98765433')); -- Luis Alberto Martínez - DEV
CALL crear_usuario_sistema('78901234', 'MED', CONCAT('password123456789', '78901234')); -- Julia García - MED
CALL crear_usuario_sistema('90123456', 'REC', CONCAT('password123456789', '90123456')); -- Miguel Ángel Suárez - REC
CALL crear_usuario_sistema('65432109', 'PAC', CONCAT('password123456789', '65432109')); -- Carolina López - PAC
CALL crear_usuario_sistema('11112222', 'EMP', CONCAT('password123456789', '11112222')); -- Martín Alejandro Díaz - EMP
CALL crear_usuario_sistema('33334444', 'ENF', CONCAT('password123456789', '33334444')); -- Lucía Fernández - ENF
CALL crear_usuario_sistema('55556666', 'ADM', CONCAT('password123456789', '55556666')); -- Diego Alejandro Giménez - ADM
CALL crear_usuario_sistema('77778888', 'DEV', CONCAT('password123456789', '77778888')); -- Valentina López - DEV
CALL crear_usuario_sistema('99990000', 'MED', CONCAT('password123456789', '99990000')); -- Lucas Emilio Mendoza - MED
CALL crear_usuario_sistema('12121212', 'REC', CONCAT('password123456789', '12121212')); -- Camila Pérez - REC
CALL crear_usuario_sistema('34343434', 'PAC', CONCAT('password123456789', '34343434')); -- Julián Andrés Ríos - PAC
CALL crear_usuario_sistema('56565656', 'EMP', CONCAT('password123456789', '56565656')); -- Martina Sánchez - EMP
CALL crear_usuario_sistema('78787878', 'ENF', CONCAT('password123456789', '78787878')); -- Felipe Javier Torres - ENF



-- Inserción de los primeros 10 pacientes con legajo.
INSERT INTO pacientes 
(legajo_paciente, dni)
VALUES
('LEG-PAC-1', '12345678'),
('LEG-PAC-2', '98765432'),
('LEG-PAC-3', '56789012'),
('LEG-PAC-4', '34567890'),
('LEG-PAC-5', '13579246'),
('LEG-PAC-6', '24680135'),
('LEG-PAC-7', '98765433'),
('LEG-PAC-8', '78901234'),
('LEG-PAC-9', '90123456'),
('LEG-PAC-10', '65432109');

INSERT INTO funciones_empleados 
(codigo_funcion_empleado, nombre_funcion_empleado)
VALUES
('MED', 'Medico'),
('LPZ', 'Limpieza'),
('ADM', 'Administracion'),
('MAN', 'Mantenimiento'),
('REC', 'Recepcion'),
('COC', 'Cocina'),
('ENF', 'Enfermeria');


INSERT INTO empleados (legajo_empleado, dni, codigo_funcion_empleado)
VALUES
('LEG-EMP-1', '13579246', 'MED'),
('LEG-EMP-2', '24680135', 'LPZ'),
('LEG-EMP-3', '98765433', 'ADM'),
('LEG-EMP-4', '78901234', 'MAN'),
('LEG-EMP-5', '90123456', 'MED'),
('LEG-EMP-6', '65432109', 'REC'),
('LEG-EMP-7', '11112222', 'COC'),
('LEG-EMP-8', '33334444', 'ENF'),
('LEG-EMP-9', '55556666', 'MED'),
('LEG-EMP-10', '77778888', 'LPZ');


INSERT INTO 
especialidades_medicas (nombre_especialidad_medica)
VALUES
('Cardiología'),
('Dermatología'),
('Endocrinología'),
('Gastroenterología'),
('Geriatría'),
('Ginecología'),
('Hematología'),
('Neurología'),
('Oftalmología'),
('Otorrinolaringología'),
('Pediatría'),
('Psiquiatría'),
('Reumatología'),
('Traumatología'),
('Urología');


-- Consulta para insertar datos en la tabla medicos
INSERT INTO medicos (legajo_empleado, id_especialidad_medica, matricula_medico)
VALUES
('LEG-EMP-1', 1, 'MED-001'),
('LEG-EMP-5', 2, 'MED-005'),
('LEG-EMP-9', 3, 'MED-009');



CALL crear_prestacion_medica('LEG-EMP-1','Geriatría',1);
CALL crear_prestacion_medica('LEG-EMP-5','Oftalmología',1);
CALL crear_prestacion_medica('LEG-EMP-9','Reumatología',1);


-- Tabla de estados turnos
INSERT INTO estados_turnos
(estado_turno)
VALUES
('pendiente'),
('confirmado'),
('anunciado'),
('consultorio'),
('finalizado'),
('cancelado'),
('reprogramado'),
('ausente');

select * from empleados where codigo_funcion_empleado = 'MED';
select * from medicos;
select * from prestaciones_medicas;


