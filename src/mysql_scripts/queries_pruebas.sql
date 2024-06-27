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