-- Basic Call with Minimum Parameters
CALL registrar_persona('12345678', 'Juan', '', 'Perez', '1990-05-15', 'Calle 123', 456, '1234', 'Ciudad', 'Provincia', 'Pais', -34.6037, -58.3816, 'juan@example.com', '1234567890', '', '987654321');

-- All Parameters Provided
CALL registrar_persona('87654321', 'Maria', 'Josefa', 'Gomez', '1985-12-25', 'Avenida Siempreverde', 789, '5678', 'Pueblo', 'Estado', 'Country', 40.7128, -74.006, 'maria@example.com', '9876543210', '123456789', '111222333');

-- Using NULL for Optional Parameters
CALL registrar_persona('99988877', 'Pedro', '', 'Sanchez', '1978-08-10', 'Calle Principal', 100, '56789', 'Ciudad Capital', 'Provincia Uno', 'Pais Uno', 38.8951, -77.0364, 'pedro@example.com', '5556667777', NULL, '999000111');

-- Empty Strings for Optional Parameters
CALL registrar_persona('44455566', 'Ana', '', 'Lopez', '1982-04-20', 'Calle Mayor', 200, '54321', 'Ciudad Principal', 'Provincia Principal', 'Pais Principal', 51.5074, -0.1278, 'ana@example.com', '1112223333', '', '');

-- Various Data Types and NULLs
CALL registrar_persona('33322244', 'Carlos', '', 'Martinez', '1995-07-01', 'Rua Principal', 300, '43210', 'Vila Nova', 'Estado Grande', 'Pais Grande', -22.9068, -43.1729, 'carlos@example.com', '9990001111', '888777666', '');

-- Special Characters in Data
CALL registrar_persona('555444333', 'José', '', 'González', '1980-03-08', 'Calle del Sol', 400, '67890', 'Ciudad Especial', 'Provincia Especial', 'Pais Especial', 45.4215, -75.6919, 'jose@example.com', '4445556666', '333222111', '555444333');

-- Long Names and Addresses
CALL registrar_persona('99988877', 'Veronica', '', 'Ramirez', '1993-11-11', 'Rua Longa do Norte, 1234', 500, '78901', 'Cidade Grande do Sul', 'Estado do Sul Grande', 'Pais do Sul Grande', -23.5505, -46.6333, 'veronica@example.com', '7778889999', '666777888', '999888777');

-- Mix of Numeric and String Data
CALL registrar_persona('987654321', 'David', '', 'Silva', '1987-06-30', '123 Main Street', 600, '90210', 'Hollywood', 'California', 'USA', 34.0522, -118.2437, 'david@example.com', '1234567890', '', '987654321');

-- Duplicate Data Values for Testing
CALL registrar_persona('123456789', 'Roberto', '', 'Alvarez', '1975-09-20', 'Rua do Teste', 700, '54321', 'Cidade Teste', 'Estado Teste', 'Pais Teste', -34.6037, -58.3816, 'roberto@example.com', '5554443333', '444555666', '111222333');

-- Edge Cases (Empty Date, Null Coordinates)
CALL registrar_persona('555444333', 'Laura', '', 'Fernandez', NULL, 'Avenida Principal', 800, '45678', 'Ciudad Nueva', 'Provincia Nueva', 'Pais Nueva', NULL, NULL, 'laura@example.com', '8889990000', '', '222333444');



/* TESTS REGISTROS PACIENTES  ------------------------------------------------------------------- */

-- Crear paciente y persona(con la creacion de usuario, domicilio, telefonos, etc, en simulataneo )
-- Edge Cases (Empty Date, Null Coordinates)
CALL registrar_nuevo_paciente('LEG001','DNI-LEG001', 'Nombre', '', 'Apellido', NULL, 'Avenida Principal', 800, '45678', 'Ciudad Nueva', 'Provincia Nueva', 'Pais Nueva', NULL, NULL, 'LEG001@example.com', '8889990000', '', '222333444');
CALL registrar_nuevo_paciente('LEG002','DNI-LEG002', 'Nombre', '', 'Apellido', NULL, 'Avenida Principal', 800, '45678', 'Ciudad Nueva', 'Provincia Nueva', 'Pais Nueva', NULL, NULL, 'LEG002@example.com', '8889990000', '', '222333444');
-- Este 3ero debe fallar x estar repetido el legajo  al margen que sea dni distinto
CALL registrar_nuevo_paciente('LEG002','DNI-LEG002', 'Nombre', '', 'Apellido', NULL, 'Avenida Principal', 800, '45678', 'Ciudad Nueva', 'Provincia Nueva', 'Pais Nueva', NULL, NULL, 'LEG002@example.com', '8889990000', '', '222333444');

-- Deberia agregar normal
CALL registrar_nuevo_paciente_desde_datos_personales('LEG003','87654321');
-- Deberia fallar por legajo repetido.
CALL registrar_nuevo_paciente_desde_datos_personales('LEG003','DNI-LEG004');
-- Deberia fallar por dni inexistente.
CALL registrar_nuevo_paciente_desde_datos_personales('LEG004','DNI-LEG004');
