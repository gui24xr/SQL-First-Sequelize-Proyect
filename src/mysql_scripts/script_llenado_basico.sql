-- Tabla de roles_usuario_sistema
INSERT INTO roles_usuario_sistema 
(rol)
VALUES  
('user_dev'),
('user_premium'),
('user_admin'),
('user_recepcion'),
('user_medico'),
('user_paciente'),
('user_empleado');
        
        
-- Tabla roles empleados
INSERT INTO roles_empleados 
(funcion)
VALUES
('medico'),
('limpieza'),
('administracion'),
('mantenimiento'),
('recepcion'),
('cocina'),
('enfermeria');


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


-- Tabla de Prestaciones
INSERT INTO prestaciones
(obra_social,plan,activa)
VALUES
('PARTICULAR', 'S/N', true),
('GALENO', 'S/N', true),
('OSDE', 'S/N', true),
('OSECACO', 'S/N', true),
('MEDICSOC', 'S/N', true),
('PLOMA', 'S/N', true),
('MEDICPLAN', 'S/N', true),
('MEDICUS', 'S/N', true),
('SALUPLAN', 'S/N', true);


-- Tabla consultorios
INSERT INTO consultorios
(numero_consultorio, en_servicio)
VALUES
(101, true),
(102, true),
(103, true),
(104, true),
(201, false),
(202, true),
(203, false);


-- Tabla especialidades medicas
INSERT INTO especialidades_medicas
(nombre)
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


-- Tabla datos_domicilios
INSERT INTO datos_domicilios
(calle, altura_calle, codigo_postal, localidad, provincia, pais)
VALUES
('Santa Fe', 1234, 1425, 'Buenos Aires', 'Buenos Aires', 'Argentina'),
('Florida', 567, 1005, 'Buenos Aires', 'Buenos Aires', 'Argentina'),
('Corrientes', 7890, 1043, 'Buenos Aires', 'Buenos Aires', 'Argentina'),
('Lavalle', 1011, 1048, 'Buenos Aires', 'Buenos Aires', 'Argentina'),
('9 de Julio', 1213, 1113, 'Buenos Aires', 'Buenos Aires', 'Argentina'),
('Córdoba', 1415, 5000, 'Córdoba', 'Córdoba', 'Argentina'),
('San Martín', 1617, 5500, 'Mendoza', 'Mendoza', 'Argentina'),
('Sarmiento', 1819, 2000, 'Rosario', 'Santa Fe', 'Argentina'),
('Belgrano', 2021, 4400, 'Salta', 'Salta', 'Argentina'),
('Rivadavia', 2223, 1033, 'Buenos Aires', 'Buenos Aires', 'Argentina'),
('Independencia', 2356, 4107, 'Tucumán', 'Tucumán', 'Argentina'),  -- Ejemplo adicional
('Entre Ríos', 2718, 5001, 'Córdoba', 'Córdoba', 'Argentina');  -- Ejemplo adicional



-- Tabla datos_telefonicos
INSERT INTO datos_telefonicos
(telefono_celular,telefono_fijo,telefono_urgencia)
VALUES
('(123) 456-7890', '(098) 765-4321', '(112) 233-4455'),
('(223) 344-5566', '(667) 788-9900', '(334) 455-6677'),
('(445) 566-7788', '(887) 766-5544', '(556) 677-8899'),
('(556) 677-8899', '(998) 877-6655', '(667) 788-9900'),
('(667) 788-9900', '(110) 099-8877', '(778) 899-0011'),
('(778) 899-0011', '(221) 100-9988', '(889) 900-1122'),
('(889) 900-1122', '(332) 211-0099', '(990) 011-2233'),
('(990) 011-2233', '(443) 322-1100', '(001) 122-3344'),
('(001) 122-3344', '(554) 433-2211', '(112) 233-4455'),
('(112) 233-4455', '(665) 544-3322', '(223) 344-5566'),
('(777) 888-9999', '(999) 888-7777', '(111) 222-3333'),  
('(444) 555-6666', '(666) 555-4444', '(333) 444-5555');  




-- Tabla usuarios_sistema
INSERT INTO usuarios_sistema
(user_email, user_password, user_rol, user_status)
VALUES
('usuario1@gmail.com', '12345678', NULL, true),
('pedro.gomez@gmail.com', '12345678', NULL, true),
('juan.gomez@gmail.com', '12345678', NULL, true),
('usuario4@gmail.com', '12345678', NULL, true),
('maria.lopez@gmail.com', '12345678', NULL, true),
('usuario6@gmail.com', '12345678', NULL, true),
('ana.rodriguez@gmail.com', '12345678', NULL, true),
('usuario8@gmail.com', '12345678', NULL, true),
('carolina.fernandez@gmail.com', '12345678', NULL, true),
('usuario10@gmail.com', '12345678', NULL, true),
('lucia.gutierrez@gmail.com', '12345678', NULL, true),
('usuario12@gmail.com', '12345678', NULL, true),
('developer01@gmail.com', '12345678', 1, true),
('developer02@gmail.com', '12345678', 1, true);


-- Tabla datos_personales
INSERT INTO datos_personales
(dni, nombre1, apellido, fecha_nacimiento, domicilio_principal, telefonos, email_contacto, user_id)
VALUES
('34823344', 'Guillermo', 'Guar', '1986-02-24', 1, 2, 'usuario1@gmail.com', NULL),
('34823324', 'Pedro', 'Gomez', '1983-01-24', 3, 3, 'pedro.gomez@gmail.com', 2),
('34823224', 'Juan', 'Gomez', '1980-01-24', NULL, 4, 'juan.gomez@gmail.com', 3),
('24822224', 'Vicente', 'Gonzalez', '1960-11-29', 2, NULL, 'usuario4@gmail.com', 4),
('14523988', 'María', 'López', '1990-05-15', 5, 5, 'maria.lopez@gmail.com', 5),
('53782931', 'Luis', 'Martínez', '1975-08-10', 6, 6, 'usuario6@gmail.com', 6),
('98762451', 'Ana', 'Rodríguez', '1988-12-03', NULL, 7, 'ana.rodriguez@gmail.com', 7),
('65478932', 'Roberto', 'Sánchez', '1982-04-17', 8, NULL, 'usuario8@gmail.com', 8),
('23456789', 'Carolina', 'Fernández', '1987-09-22', 9, 9, 'carolina.fernandez@gmail.com', 9),
('87654321', 'Jorge', 'Pérez', '1981-06-12', NULL, 10, 'lucia.gutierrez@gmail.com', 10),
('45678901', 'Lucía', 'Gutiérrez', '1995-03-28', 1, NULL, 'usuario10@gmail.com', 11),
('78901234', 'Diego', 'Hernández', '1979-07-07', 2, NULL, 'usuario12@gmail.com', 12),
('23456790', 'Martín', 'Martínez', '1980-08-15', 3, NULL, 'martin.martinez@gmail.com', NULL),
('98765432', 'Marcela', 'López', '1992-10-20', NULL, 10, 'marcela.lopez@gmail.com', NULL),
('45612378', 'Julia', 'Gómez', '1985-03-10', 4, NULL, 'julia.gomez@gmail.com', NULL),
('13579246', 'Carlos', 'Rodríguez', '1977-12-05', NULL, 8, 'carlos.rodriguez@gmail.com', NULL),
('78965412', 'Laura', 'Fernández', '1991-06-25', 5, NULL, 'laura.fernandez@gmail.com', NULL),
('11223344', 'Federico', 'Rodríguez', '1984-09-15', 6, NULL, 'federico.rodriguez@gmail.com', NULL),
('22334455', 'Andrea', 'García', '1989-11-30', 7, NULL, 'andrea.garcia@gmail.com', NULL),
('33445566', 'Lucas', 'Martín', '1986-07-18', 8, NULL, 'lucas.martin@gmail.com', NULL),
('44556677', 'Valeria', 'Pérez', '1990-03-25', 9, NULL, 'valeria.perez@gmail.com', NULL);



-- Tabla Empleados
INSERT INTO empleados
(legajo_empleado, dni, id_funcion)
VALUES
('MD-34823344', '34823344', 1), -- Médico
('LI-34823324', '34823324', 2), -- Limpieza
('MD-34823224', '34823224', 1), -- Médico
('AD-24822224', '24822224', 3), -- Administración
('RE-14523988', '14523988', 5), -- Recepción
('CO-53782931', '53782931', 6), -- Cocina
('EN-98762451', '98762451', 7), -- Enfermería
('LI-65478932', '65478932', 2), -- Limpieza
('AD-23456789', '23456789', 3), -- Administración
('RE-87654321', '87654321', 5), -- Recepción
('MD-45678901', '45678901', 1), -- Médico
('EN-78901234', '78901234', 6), -- Enfermería
('LI-23456790', '23456790', 2), -- Limpieza (sin usuario de sistema)
('RE-98765432', '98765432', 5), -- Recepción (sin usuario de sistema)
('CO-45612378', '45612378', 6), -- Cocina (sin usuario de sistema)
('AD-13579246', '13579246', 3), -- Administración (sin usuario de sistema)
('MD-78965412', '78965412', 1); -- Médico (sin usuario de sistema)


-- Tabla medicos
INSERT INTO medicos
(legajo_medico, dni, id_especialidad)
VALUES
('MD-34823344', '34823344', 1),     -- Guillermo Guar - Cardiología
('MD-34823224', '34823224', 1),     -- Juan Gomez - Cardiología
('MD-65478932', '65478932', 1),     -- Roberto Sánchez - Cardiología
('MD-45678901', '45678901', 1),     -- Lucía Gutiérrez - Cardiología
('MD-11223344', '11223344', 2),     -- Federico Rodríguez - Dermatología
('MD-33445566', '33445566', 2);     -- Lucas Martín - Dermatología


-- Tabla de Pacientes
INSERT INTO pacientes
(legajo_paciente, dni)
VALUES
('PC-23456790', '23456790'),  -- Martín Martínez
('PC-98765432', '98765432'),  -- Marcela López
('PC-45612378', '45612378'),  -- Julia Gómez
('PC-13579246', '13579246'),  -- Carlos Rodríguez
('PC-78965412', '78965412');  -- Laura Fernández

