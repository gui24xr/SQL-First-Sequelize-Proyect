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
(funcion,abreviatura_funcion)
VALUES
('medico','MED'),
('limpieza','LPZ'),
('administracion','ADM'),
('mantenimiento','MAN'),
('recepcion','REC'),
('cocina','COC'),
('enfermeria','ENF');


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
