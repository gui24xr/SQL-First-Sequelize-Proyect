
/* Devuelve true o false segun la persona  este o no este registrado en en la BD... 
   Independientemente si es empleado o paciente...
*/
DELIMITER //
CREATE FUNCTION existe_persona(p_dni VARCHAR(30)) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    /* Declaro variable donde guardo los resultados encontrados... */
    DECLARE coincidencias INT DEFAULT 0;
    /* Consulto en la tabla datos personales si existe el DNI */
    SELECT COUNT(*) INTO coincidencias  FROM fichas_datos_personales WHERE dni = p_dni;
    /* De acuerdo al resultado devuelvo 1 (verdadero) o 0 (falso)... */
    IF coincidencias > 0 THEN
        RETURN true;
    ELSE
        RETURN false;
    END IF;
END //

DELIMITER ;

/*--------------------------------------------------------------------------------------*/

/* Devuelve true o false segun la persona sea empleado o no */
DELIMITER //
CREATE FUNCTION es_empleado(p_dni VARCHAR(30)) RETURNS INT
DETERMINISTIC
BEGIN
    /* Declaro variable donde guardo los resultados encontrados... */
    DECLARE coincidencias INT DEFAULT 0;
    /* Consulto en la tabla datos personales si existe el DNI */
    SELECT COUNT(*) INTO coincidencias FROM empleados WHERE dni = p_dni;
    /* De acuerdo al resultado devuelvo 1 (verdadero) o 0 (falso)... */
    IF coincidencias > 0 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END //
DELIMITER ;


/*--------------------------------------------------------------------------------------*/



/* Devuelve true o false segun la persona sea empleado o no */
DELIMITER //
CREATE FUNCTION es_paciente(p_dni VARCHAR(30)) RETURNS INT
DETERMINISTIC
BEGIN
    /* Declaro variable donde guardo los resultados encontrados... */
    DECLARE coincidencias INT DEFAULT 0;
    /* Consulto en la tabla datos personales si existe el DNI */
    SELECT COUNT(*) INTO coincidencias FROM pacientes WHERE p_dni;
    /* De acuerdo al resultado devuelvo 1 (verdadero) o 0 (falso)... */
    IF coincidencias > 0 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END 
//DELIMITER ;


/*------------------------------------------------------------------------------ */
/*Crea ficha de datos personales con null en user system, creando y llenando datos de domicilio y telefono*/
DELIMITER // 
CREATE PROCEDURE crear_ficha_datos_personales (
    IN p_dni VARCHAR(30),IN p_nombre1 VARCHAR(255),IN p_nombre2 VARCHAR(255),IN p_apellido VARCHAR(255),IN p_fecha_nacimiento DATE,IN p_email VARCHAR(254),
    IN p_calle VARCHAR(255),IN p_altura_calle INT,IN p_codigo_postal VARCHAR(20),IN p_localidad VARCHAR(100),IN p_provincia VARCHAR(100) ,
    IN p_pais VARCHAR(100),IN p_latitud DECIMAL(10, 8), IN p_longitud DECIMAL(11, 8),IN p_telefono_celular VARCHAR(30),
    IN p_telefono_fijo VARCHAR(30), IN p_telefono_urgencia VARCHAR(30))
BEGIN
    /*Condiciones necesarias para llevar a cabo el proceso:
        1- No existe la persona entre alas fichas de datos domicilios.
        2- Los parametros deben ser validados y correctos

        SI bien DNI es unique, seria ineficiente que se lleve a cabo el proceso y cuando inserte el registro
        la base de datos encuentre que el dni existia...
    */
    IF existe_persona(p_dni) = false THEN 
		BEGIN
            INSERT INTO fichas_datos_personales (dni,nombre1,nombre2,apellido,fecha_nacimiento, email)
            VALUES (p_dni,p_nombre1,p_nombre2,p_apellido,p_fecha_nacimiento, p_email);

            INSERT INTO datos_domicilios (dni,calle,altura_calle,codigo_postal,localidad,provincia,pais,latitud,longitud)
            VALUES (p_dni,p_calle,p_altura_calle,p_codigo_postal,p_localidad,p_provincia,p_pais,p_latitud,p_longitud);
                
            INSERT INTO datos_telefonicos(dni,telefono_celular,telefono_fijo,telefono_urgencia)
            VALUES	(p_dni,p_telefono_celular,p_telefono_fijo,p_telefono_urgencia);

            /* El campo id_user_system se crea en null por definicion de la tabla. */
        END;
	ELSE 
		BEGIN /*Lanzamos mensajes de error segun condicion de parametro que no se cumplio */
            IF existe_persona(p_dni) = true THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya existe una persona registrada con este dni en la base de datos...';
            ELSE SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya existe una persona registrada con este dni en la base de datos...';
			END IF;
		END;
    END IF;
END;





