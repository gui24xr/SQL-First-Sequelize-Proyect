-- Llamada 1: Crear nueva ficha de datos personales
CALL crear_ficha_datos_personales('123456789', 'Juan', 'Pablo', 'González', '1990-05-15', 'juan.gonzalez@example.com',
                                  'Calle Principal', 123, '12345', 'Ciudad A', 'Provincia X', 'Pais Y',
                                  40.12345678, -74.12345678, '+54115556666', '+54115557777', '+54115558888');

-- Llamada 2: Intentar crear una ficha con el mismo DNI
CALL crear_ficha_datos_personales('123456789', 'María', 'Elena', 'López', '1985-03-20', 'maria.lopez@example.com',
                                  'Avenida Central', 456, '54321', 'Ciudad B', 'Provincia Y', 'Pais Z',
                                  38.87654321, -72.98765432, '+54114443333', '+54114444444', '+54114445555');

-- Llamada 3: Crear nueva ficha de datos personales
CALL crear_ficha_datos_personales('987654321', 'Pedro', '', 'Martínez', '1988-08-10', 'pedro.martinez@example.com',
                                  'Av. Libertador', 789, '67890', 'Ciudad C', 'Provincia Z', 'Pais X',
                                  35.67890123, -68.98765432, '+54116667777', '+54116668888', '+54116669999');

-- Llamada 4: Intentar crear una ficha con un DNI nuevo pero con datos incompletos
CALL crear_ficha_datos_personales('111111111', 'Luis', '', 'Gómez', '1980-01-01', 'luis.gomez@example.com',
                                  '', 0, '', '', '', '',
                                  0.0, 0.0, '', '', '');

-- Llamada 5: Crear nueva ficha con todos los datos completos
CALL crear_ficha_datos_personales('222222222', 'Ana', 'María', 'Pérez', '1982-12-30', 'ana.perez@example.com',
                                  'Rue de Paris', 456, '75001', 'Paris', 'Île-de-France', 'Francia',
                                  48.856614, 2.3522219, '+33123456789', '', '+33123456789');

-- Llamada 6: Intentar crear una ficha con un DNI nuevo pero sin datos de contacto
CALL crear_ficha_datos_personales('333333333', 'Carlos', 'Alberto', 'Ramírez', '1975-06-25', '',
                                  'Rua do Porto', 789, '10000-000', 'Rio de Janeiro', 'Rio de Janeiro', 'Brasil',
                                  -22.9068, -43.1729, '', '', '');

-- Llamada 7: Intentar crear una ficha con un DNI nuevo pero sin fecha de nacimiento
CALL crear_ficha_datos_personales('444444444', 'Laura', 'Elena', 'Silva', NULL, 'laura.silva@example.com',
                                  'Calle Mayor', 567, '28001', 'Madrid', 'Madrid', 'España',
                                  40.4165, -3.7026, '+34987654321', '', '+34987654321');

-- Llamada 8: Crear nueva ficha con teléfono celular y fijo, pero sin urgencia
CALL crear_ficha_datos_personales('555555555', 'Jorge', '', 'Fernández', '1995-11-05', 'jorge.fernandez@example.com',
                                  'Hauptstrasse', 789, '10115', 'Berlín', 'Berlín', 'Alemania',
                                  52.5200, 13.4050, '+49123456789', '+49301234567', '');

