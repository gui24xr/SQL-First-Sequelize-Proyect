/*
    Este trigger asegura que si vamos a ingresar un nuevo consultorio, exista una sede
    para dicho consultorio y asi no tenemos problemas de clave foranea.
    Ademas ,eventualmrnyr,un consultorio se puede llamar igual que otro estando en distintas sede, por 
    lo tanto necesitamos identificarlos de manera univoca.
*/
DELIMITER $$
CREATE TRIGGER before_insert_consultorios
BEFORE INSERT ON consultorios
FOR EACH ROW
BEGIN
    DECLARE sede_count INT;
    /* Verifico si la sede ya existe utilizando un conteo...*/
    SELECT COUNT(*) INTO sede_count
    FROM sedes_establecimiento
    WHERE id_sede_establecimiento = NEW.id_sede_establecimiento;
    /* SI la sede no existe lanzo un error y no dejo ingresar datos*/
    IF sede_count = 0 THEN
      SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede insertar el consultorio. La sede especificada no existe en la tabla sedes_establecimiento.';
    END IF;
END
$$ DELIMITER ;


/*
    
se asegura de cuidar la integridad referencial con la tabla datos personales y
de que no se ingresen empleados con roles no validos.
*/

DELIMITER $$
CREATE TRIGGER before_insert_empleados
BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
   DECLARE coincidencias INT;
    /* Cuido la integridad referencial creado registro en datos_personales*/
  CALL crear_datos_personales_vacios(NEW.dni);
   /*En caso de empleados tambien tienen que tener una funcion valida 
    o sea un id en la tabla roles empleados 
    Por lo cual vigilo que new.id_funcion exista en roles empleados */
    SELECT COUNT(*) INTO coincidencias
    FROM roles_empleados
    WHERE id_funcion = NEW.id_funcion;
    /* si hay coincidencias permito el ingreso, de lo contrario tiro error */
    IF coincidencias = 0 THEN
      SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede ingresar un empleado con una funcion que no existe...';
    END IF;

END
$$ DELIMITER ;



/*
 Se asegiura de cuidar la integridad referencial pacientes vs datos personales.
*/

DELIMITER $$
CREATE TRIGGER before_insert_pacientes
BEFORE INSERT ON pacientes
FOR EACH ROW
BEGIN
    /* Cuido la integridad referencial creado registro en datos_personales*/
    CALL crear_datos_personales_vacios(NEW.dni);
    END
$$ DELIMITER ;



/*
 Se asegiura de cuidar la integridad referencial en la tabla prestaciones medicas.
 1- Tiene que existir la especialidad.
 2- El empleado debe existir en la tabla empleados.

*/

DELIMITER $$
CREATE TRIGGER before_insert_prestaciones_medicas
BEFORE INSERT ON prestaciones_medicas
FOR EACH ROW
BEGIN
    DECLARE coincidencias INT;
    /* Busco que exista la especialidad medica*/
    SELECT COUNT(*) INTO coincidencias
    FROM especialidades_medicas
    WHERE id_especialidad = NEW.id_especialidad;
    /* si hay coincidencias permito el ingreso, de lo contrario tiro error */
    IF coincidencias = 0 THEN
      SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede ingresar una prestacion medica para una especialidad no registrada...';
    END IF;

    /* SI llego hasta aca ahora reviso que exista el medico/ empleado */
    SELECT COUNT(*) INTO coincidencias
    FROM empleados
    WHERE legajo_empleado = NEW.legajo_empleado;
    /* si hay coincidencias permito el ingreso, de lo contrario tiro error */
    IF coincidencias = 0 THEN
      SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'No se puede ingresar una prestacion medica para un empleado no registrado, ingresar primero el empleado...';
    
    
    END IF;
END
$$ DELIMITER ;