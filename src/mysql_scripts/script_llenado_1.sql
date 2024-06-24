
-- Tabla contadores
INSERT INTO contadores
(fecha,turnos_otorgados,recepciones_pacientes,ocupaciones_consultorios,registros_historias_clinicas)
VALUES
(CURRENT_TIMESTAMP,1,1,1,1);


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
INSERT INTO prestaciones_obras_sociales
(obra_social,plan,en_servicio)
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


-- Tabla sedes_establecimiento
INSERT INTO sedes_establecimiento
(nombre_sede,en_servicio)
VALUES
('Sede 1',true),
('Sede 2', true),
('Sede 3', false);

-- Tabla consultorios
INSERT INTO consultorios
(id_sede_establecimiento,nombre_consultorio, en_servicio)
VALUES
(1,101, true),
(1,102, true),
(1,103, true),
(1,104, true),
(1,201, false),
(1,202, true),
(2,203, false),
(2,101, true),
(2,102, true),
(2,103, true),
(2,104, true),
(2,201, false),
(2,202, true),
(2,203, true);


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

