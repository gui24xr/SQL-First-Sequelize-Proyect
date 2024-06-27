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





/*
 Se asegiura de cuidar la integridad referencial en la tabla prestaciones_habilitadas_medicas.
 1- Tiene que existir la prestacion medica en la tabla prestaciones_medicas para poder ser agregada
 2- Tiene que existir la prestacion medica en la tabla prestaciones_medicas para poder ser agregada
 Si una de las 2 no existen entonces se lanza error y no se permite la insercion.
 Se tienen que dar las 2 condiciones

 Otra condicion importante para esta tabla es que no se repitan las tuplas
*/
DELIMITER $$
CREATE TRIGGER before_insert_prestaciones_habilitadas_medicos
BEFORE INSERT ON prestaciones_habilitadas_medicos
FOR EACH ROW
BEGIN
    DECLARE coincidencias_tabla1 INT;
    DECLARE coincidencias_tabla2 INT;
    DECLARE mensaje_error TEXT;
    DECLARE lanzar_error BOOLEAN DEFAULT false;
    DECLARE registros_duplicados INT DEFAULT 0;

    /* Busco que exista la prestacion medica en la tabla prestaciones_medicas */
    SELECT COUNT(*) INTO coincidencias_tabla1
    FROM prestaciones_medicas
    WHERE id_prestacion_medica = NEW.id_prestacion_medica;

    /* Busco que exista la prestacion de obra social en la tabla prestaciones_obras_sociales */
    SELECT COUNT(*) INTO coincidencias_tabla2
    FROM prestaciones_obras_sociales
    WHERE id_prestacion_obra_social = NEW.id_prestacion_obra_social;

    /* Si no hay coincidencias, no permito el ingreso, lanzo error */
    IF coincidencias_tabla1 = 0 THEN
        BEGIN
            SET mensaje_error = CONCAT('No existe la prestacion medica con ID ', NEW.id_prestacion_medica, ', es necesario registrarla previamente...');
            SET lanzar_error = true;
        END;
    END IF;

    /* Si no hay coincidencias, no permito el ingreso, lanzo error */
    IF coincidencias_tabla2 = 0 THEN
        BEGIN
            SET mensaje_error = CONCAT('No existe la prestacion de obra social con ID ', NEW.id_prestacion_obra_social, ', es necesario registrarla previamente...');
            SET lanzar_error = true;
        END;
    END IF;

    /* Si hay duplicados tampoco permito el ingreso */
    SELECT COUNT(*) INTO registros_duplicados
    FROM prestaciones_habilitadas_medicos
    GROUP BY id_prestacion_medica,id_prestacion_obra_social
    HAVING COUNT(*) > 1;
    
 
    IF registros_duplicados > 0 THEN 
        BEGIN
            SET mensaje_error = CONCAT('Para la prestacion medica con ID ', NEW.id_prestacion_medica, ' ya tiene ingresada la prestacion de obra social con ID ', NEW.id_prestacion_obra_social, '...');
            SET lanzar_error = true;
        END;
    END IF;

    -- Si hubo falla, lanzo el error
    IF lanzar_error THEN
    
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = mensaje_error;
    END IF;

END$$
DELIMITER ;
