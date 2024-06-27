insert into consultorios
(id_sede_establecimiento,nombre_consultorio,en_servicio)
values
(1,'juanc',true);

select * from sedes_consultorios;
select * from consultorios;

insert into pacientes
(legajo_paciente,dni)
values
('2324434','31111222');

insert into empleados
(legajo_empleado,dni,id_funcion)
values
('2324431','31111222',3),
(23232345,'23232322',1);

insert into prestaciones_medicas
(id_especialidad,matricula_medico,legajo_empleado)
values
(3,'ssssss','23232345211');


select * from pacientes;
select * from datos_personales;
select * from empleados;

DROP TRIGGER IF EXISTS before_insert_empleados;
DROP TRIGGER IF EXISTS before_insert_prestaciones_habilitadas_medicos;

select * from prestaciones_medicas;
select * from prestaciones_obras_sociales;
select * from prestaciones_habilitadas_medicos;

insert into prestaciones_habilitadas_medicos
(id_prestacion_medica,id_prestacion_obra_social)
VALUES
(1,1),
(1,1),
(2,2),
(2,1),
(2,2);

select * from prestaciones_medicas;
select * from prestaciones_obras_sociales;
select * from prestaciones_habilitadas_medicos;



-- Llamada 1
CALL crear_nuevo_paciente('LEG001', '12345678A', 'Juan', '', 'Pérez', '1990-01-01',
    'Calle Principal', 100, '12345', 'Ciudad Capital', 'Provincia A', 'Argentina', 
    0.00000000, 0.00000000, 'juan.perez@example.com', '123456789', '987654321', '911');

-- Llamada 2
CALL crear_nuevo_paciente('LEG002', '23456789B', 'María', '', 'García', '1988-05-15',
    'Avenida Central', 200, '54321', 'Otra Ciudad', 'Provincia B', 'Argentina', 
    0.00000000, 0.00000000, 'maria.garcia@example.com', '234567890', '876543210', '922');

-- Llamada 3
CALL crear_nuevo_paciente('LEG003', '34567890C', 'Luis', '', 'Martínez', '1985-11-30',
    'Calle Secundaria', 300, '67890', 'Pueblo Chico', 'Provincia C', 'Argentina', 
    0.00000000, 0.00000000, 'luis.martinez@example.com', '345678901', '765432109', '933');

-- Llamada 4
CALL crear_nuevo_paciente('LEG004', '45678901D', 'Ana', '', 'López', '1987-08-20',
    'Calle Tranquila', 400, '98765', 'Villa Nueva', 'Provincia D', 'Argentina', 
    0.00000000, 0.00000000, 'ana.lopez@example.com', '456789012', '654321098', '944');

-- Llamada 5
CALL crear_nuevo_paciente('LEG005', '56789012E', 'Pedro', '', 'Sánchez', '1992-03-10',
    'Avenida Principal', 500, '45678', 'Gran Ciudad', 'Provincia E', 'Argentina', 
    0.00000000, 0.00000000, 'pedro.sanchez@example.com', '567890123', '543210987', '955');

-- Llamada 6
CALL crear_nuevo_paciente('LEG006', '67890123F', 'Carolina', '', 'Ruiz', '1983-12-25',
    'Calle Feliz', 600, '76543', 'Pequeño Pueblo', 'Provincia F', 'Argentina', 
    0.00000000, 0.00000000, 'carolina.ruiz@example.com', '678901234', '432109876', '966');

-- Llamada 7
CALL crear_nuevo_paciente('LEG007', '78901234G', 'Diego', '', 'Hernández', '1995-07-05',
    'Calle Alegre', 700, '54321', 'Villa Grande', 'Provincia G', 'Argentina', 
    0.00000000, 0.00000000, 'diego.hernandez@example.com', '789012345', '321098765', '977');

-- Llamada 8
CALL crear_nuevo_paciente('LEG008', '89012345H', 'Laura', '', 'Gómez', '1989-09-12',
    'Avenida Feliz', 800, '87654', 'Ciudad Nueva', 'Provincia H', 'Argentina', 
    0.00000000, 0.00000000, 'laura.gomez@example.com', '890123456', '210987654', '988');

-- Llamada 9
CALL crear_nuevo_paciente('LEG009', '90123456I', 'Gabriel', '', 'Torres', '1991-04-18',
    'Calle Tranquila', 900, '23456', 'Pequeña Ciudad', 'Provincia I', 'Argentina', 
    0.00000000, 0.00000000, 'gabriel.torres@example.com', '901234567', '109876543', '999');

-- Llamada 10
CALL crear_nuevo_paciente('LEG010', '01234567J', 'Valeria', '', 'Díaz', '1986-06-22',
    'Avenida Grande', 1000, '76543', 'Ciudad Principal', 'Provincia J', 'Argentina', 
    0.00000000, 0.00000000, 'valeria.diaz@example.com', '012345678', '098765432', '000');


select * from datos_domicilios;
select * from pacientes;

CALL crear_nuevo_paciente_desde_datos_personales('454545411111','1254329999');

-- Persona 1
CALL registrar_persona('11111111A', 'Carlos', '', 'González', '1992-08-15',
    'Avenida Libertador', 150, '1000', 'Buenos Aires', 'Buenos Aires', 'Argentina', 
    -34.603722, -58.381592, 'carlos.gonzalez@example.com', '1122334455', '', '911');

-- Persona 2
CALL registrar_persona('22222222B', 'María', '', 'López', '1985-05-20',
    'Calle Principal', 250, '2000', 'Córdoba', 'Córdoba', 'Argentina', 
    -31.420083, -64.188776, 'maria.lopez@example.com', '2233445566', '', '922');

-- Persona 3
CALL registrar_persona('33333333C', 'Luis', '', 'Martínez', '1990-11-10',
    'Avenida San Martín', 350, '3000', 'Rosario', 'Santa Fe', 'Argentina', 
    -32.944243, -60.650538, 'luis.martinez@example.com', '3344556677', '', '933');

-- Persona 4
CALL registrar_persona('44444444D', 'Ana', '', 'Rodríguez', '1987-03-25',
    'Calle 25 de Mayo', 450, '4000', 'Mendoza', 'Mendoza', 'Argentina', 
    -32.890183, -68.84405, 'ana.rodriguez@example.com', '4455667788', '', '944');

-- Persona 5
CALL registrar_persona('55555555E', 'Juan', '', 'Sánchez', '1995-09-30',
    'Boulevard Rivadavia', 550, '5000', 'Salta', 'Salta', 'Argentina', 
    -24.782127, -65.412476, 'juan.sanchez@example.com', '5566778899', '', '955');

-- Persona 6
CALL registrar_persona('66666666F', 'Carolina', '', 'Ramírez', '1983-12-01',
    'Calle 9 de Julio', 650, '6000', 'San Miguel de Tucumán', 'Tucumán', 'Argentina', 
    -26.808285, -65.21759, 'carolina.ramirez@example.com', '6677889900', '', '966');

CALL crear_nuevo_paciente_desde_datos_personales('hhhggg','66666666F');
select * from pacientes;
CALL crear_nuevo_empleado_desde_datos_personales('cocina','1a1a1a','66666666F');

-- Llamada 1
CALL crear_nuevo_empleado('medico','LEG001', 'gtrewq23', 'Juan', '', 'Pérez', '1990-01-01',
    'Calle Principal', 100, '12345', 'Ciudad Capital', 'Provincia A', 'Argentina', 
    0.00000000, 0.00000000, 'juan.perez@example.com', '123456789', '987654321', '911');
select * from empleados;