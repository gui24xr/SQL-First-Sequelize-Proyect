
/*
/*------------------------------------------------------------------------------ */
 Creara un paciente nuevo, a partir de los datos, asignara un user sistem y lo vinculara...
 SI eventualmente el DNI existe en la BD lanzara error, porque para crear un paciente a partir 
 De datos ya registrados se debe utilizar el metodo crear_nuevo_paciente_datos_cargados...
/*-------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE registrar_nuevo_paciente (
    IN p_legajo_paciente VARCHAR(30),IN p_dni VARCHAR(30),IN p_nombre1 VARCHAR(255), IN p_nombre2 VARCHAR(255),
    IN p_apellido VARCHAR(255),IN p_fecha_nacimiento DATE,IN p_calle VARCHAR(255),IN p_altura_calle INT,IN p_codigo_postal VARCHAR(20),
    IN p_localidad VARCHAR(100),IN p_provincia VARCHAR(100), IN p_pais VARCHAR(100),IN p_latitud DECIMAL(10, 8),IN p_longitud DECIMAL(11, 8),
    IN p_email VARCHAR(254),IN p_telefono_celular VARCHAR(30),IN p_telefono_fijo VARCHAR(30),IN p_telefono_urgencia VARCHAR(30))
BEGIN
    /*VARIABLES */
    DECLARE pacientes_mismo_legajo INT DEFAULT 0;
    DECLARE id_usuario_sistema INT;
    DECLARE codigo_tipo_usuario_sistema VARCHAR(30);

    /* Miramos que no exista un paciente con este legajo, debe ser 0, de lo contrario error.*/
    SELECT COUNT(*) INTO pacientes_mismo_legajo FROM pacientes WHERE legajo_paciente = p_legajo_paciente;

    IF pacientes_mismo_legajo > 0 THEN
       BEGIN
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'Ya existe un paciente con el mismo legajo en la BD...';
        END;
    ELSE 
        /* Si no existe paciente con tal legajo, podemos continuar */
        BEGIN
			IF existe_persona(p_dni) = 1 THEN /*eXiste la persona doy error y aviso que este metodo no se puede usar este metodo para este proposito.*/
                 BEGIN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'Ya hay registros a partir de este DNI, crear el paciente desde el stored procedure registrar_paciente_desde_dni...';
                END;
            ELSE
                BEGIN
                    /* Registramos la persona */
                    CALL registrar_persona(p_dni, p_nombre1, p_nombre2, p_apellido, p_fecha_nacimiento, p_calle, p_altura_calle, p_codigo_postal, p_localidad,
                    p_provincia, p_pais, p_latitud, p_longitud, p_email, p_telefono_celular, p_telefono_fijo, p_telefono_urgencia);
                    /* Le damos privilegios de user */
                    SELECT codigo_tipo_usuario INTO codigo_tipo_usuario_sistema FROM tipos_usuario_sistema WHERE nombre_tipo_usuario = 'user_paciente';
                    UPDATE usuarios_sistema SET user_rol = codigo_tipo_usuario_sistema  WHERE user_id = p_dni;
                    /* La ingresamos finalmente a la tabla pacientes...*/
                    INSERT INTO pacientes(legajo_paciente,dni) VALUES(p_legajo_paciente,p_dni);
                END;
            END IF;
		END;
    END IF;
END;

//DELIMITER ;


/*------------------------------------------------------------------------------ */
 Creara un paciente nuevo, a partir de los datos de personas creados o sea un DNI, 
/*-------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE registrar_nuevo_paciente_desde_datos_personales(IN p_legajo_paciente VARCHAR(30), IN p_dni VARCHAR(30))
BEGIN
    /*VARIABLES */
    DECLARE pacientes_mismo_legajo INT DEFAULT 0;
    DECLARE empleados_mismo_dni INT DEFAULT 0;
    DECLARE id_user_rol_empleado INT;

    /* Miramos que no exista un paciente con este legajo, debe ser 0, de lo contrario error.*/
    SELECT COUNT(*) INTO pacientes_mismo_legajo FROM pacientes WHERE legajo_paciente = p_legajo_paciente;

    IF pacientes_mismo_legajo > 0 THEN
       BEGIN
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'Ya existe un paciente con el mismo legajo en la BD...';
        END;
    ELSE 
        BEGIN
			IF existe_persona(p_dni) = 1 THEN 
                /* Si existe la persona puede ser por 2 motivos: 
                    1- Es empleado y se necesita dar de alta tambien como paciente, Ya tiene user y es de mayores privilegios, por lo cual no es necesario cambiar privilegios.
                    2- Ya estan cargados sus datos pero no es ni paciente ni empleado. Le damos user_paciente
                */
                SELECT COUNT(*) INTO empleados_mismo_dni FROM empleados WHERE dni = p_dni;
                IF empleados_mismo_dni > 0 THEN INSERT INTO pacientes(legajo_paciente,dni) VALUES(p_legajo_paciente,p_dni);
                  /*Es empleado registrado solo necesita legajo de paciente, si estuviese este dni en pacientes, fallaria xq dni en pacientes es UNIQUE*/  
                ELSE
                    BEGIN
                         /* Estan su datos en la BD pero no es paciente ni empleado, lo ingresamos a pacientes y le ponemos permisos de user a su usuario. */
                        INSERT INTO pacientes (legajo_paciente,dni) VALUES (p_legajo_paciente,p_dni);
                         /* Le damos privilegios de user */
                        SELECT id_user_rol INTO id_user_rol_empleado FROM roles_usuario_sistema WHERE rol = 'user_paciente';
                        UPDATE usuarios_sistema SET user_rol = id_user_rol_empleado  WHERE user_id = p_dni;
                    END;
                END IF;
            ELSE
                BEGIN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'No existen datos para este DNI en la BD, use el metodo crear_nuevo_paciente...';
                END;
            END IF;
		END;
    END IF;
END;
// DELIMITER;



/*------------------------------------------------------------------------------ */
 Creara un paciente nuevo, a partir de los datos, asignara un user sistem y lo vinculara...
 SI eventualmente el DNI existe en la BD lanzara error, porque para crear un paciente a partir 
 De datos ya registrados se debe utilizar el metodo crear_nuevo_paciente_datos_cargados...
/*-------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE registrar_nuevo_empleado (
    IN p_legajo_empleado VARCHAR(30),IN p_codigo_funcion VARCHAR(30),IN p_dni VARCHAR(30),IN p_nombre1 VARCHAR(255),IN p_nombre2 VARCHAR(255),IN p_apellido VARCHAR(255),
    IN p_fecha_nacimiento DATE, IN p_calle VARCHAR(255),IN p_altura_calle INT,IN p_codigo_postal VARCHAR(20),IN p_localidad VARCHAR(100),IN p_provincia VARCHAR(100) ,
    IN p_pais VARCHAR(100),IN p_latitud DECIMAL(10, 8), IN p_longitud DECIMAL(11, 8),IN p_email VARCHAR(254),IN p_telefono_celular VARCHAR(30),
    IN p_telefono_fijo VARCHAR(30),IN p_telefono_urgencia VARCHAR(30))
BEGIN
    /*VARIABLES */
    DECLARE empleados_mismo_legajo INT DEFAULT 0;
    DECLARE id_funcion_empleado VARCHAR(30) DEFAULT 0; 

    /* Miramos que no exista un empleados con este legajo, debe ser 0, de lo contrario error.*/
    SELECT COUNT(*) INTO empleados_mismo_legajo FROM empleados WHERE legajo_empleado = p_legajo_empleado;
    IF empleados_mismo_legajo > 0 THEN
       BEGIN
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'Ya existe un empleados con el mismo legajo en la BD...';
        END;
    ELSE    /* No existe empleados con tal legajo, podemos continuar */
        BEGIN
			IF existe_persona(p_dni) = 1 THEN /*eXiste la persona doy error y aviso que este metodo no se puede usar este metodo para este proposito.*/
                 BEGIN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'Ya hay personas registradas con este DNI, crear el empleado desde el stored procedure registrar_nuevo_empleado_desde_dni...';
                END;
            ELSE
                BEGIN
                    /* Primero que nada buscaremos el ID de la funcion de empleado que le corresponde teniendo en cuenta el codigo_funcion que ingresaron como parametro para el empleado ya que
                       si la funcion no existe o no coincide no tendremos ID y estariamos creando registro de manera innecesaria
                    */
                    INSERT id_user_system_role INTO id_funcion_empleado FROM roles_empleados WHERE codigo_funcion = p_codigo_funcion;
                    IF id_user_rol < 0 THEN

                    

                    /* Registramos la persona */
                    CALL registrar_persona(p_dni, p_nombre1, p_nombre2, p_apellido, p_fecha_nacimiento, p_calle, p_altura_calle, p_codigo_postal, p_localidad,
                    p_provincia, p_pais, p_latitud, p_longitud, p_email_contacto, p_telefono_celular, p_telefono_fijo, p_telefono_urgencia);
                    /* Ingresamos la persona nueva creada a la tabla de empleados con su legajo y funcion...*/


                    INSERT INTO empleados (legajo_empleado,dni,id_funcion) VALUES (p_legajo_empleado,p_dni,id_user_role)
                    SELECT p_legajo_empleado, p_dni,id_funcion FROM roles_empleados WHERE funcion = p_funcion;
                    /*Creamos usuario para la persona  y lo ligamos..*/
                END;
            END IF;
		END;
    END IF;
END;

// DELIMITER; 


/*------------------------------------------------------------------------------ */
 Creara un empleado nuevo, a partir de los datos de personas creados o sea un DNI, 
 Le debe dar tambien una funcion valida que exista en la tabla roles empleados...
/*-------------------------------------------------------------------------------*/

DELIMITER //
CREATE PROCEDURE registrar_nuevo_empleado_desde_datos_personales (IN p_funcion VARCHAR(30),IN p_legajo_empleado VARCHAR(30), IN p_dni VARCHAR(30))
BEGIN
    /*VARIABLES */
    DECLARE empleados_mismo_legajo INT DEFAULT 0;
    DECLARE empleados_mismo_dni INT DEFAULT 0;

    /* Miramos que no exista un empleado con este legajo, debe ser 0, de lo contrario error.*/
    SELECT COUNT(*) INTO empleados_mismo_legajo
    FROM empleados
    WHERE legajo_empleado = p_legajo_empleado;

    IF empleados_mismo_legajo > 0 THEN
       BEGIN
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'Ya existe un empleado con el mismo legajo en la BD...';
        END;
    ELSE 
        BEGIN
			IF existe_persona(p_dni) = 1 THEN 
                /* Si existe la persona puede ser por 2 motivos: 
                    1- Es paciente y ahora sera empleado por lo cual hay que aumentarle los privilegios a su user.
                    2- Ya estan cargados sus datos pero no es ni paciente ni empleado. Le damos user_empleado segun su funcion.
                */
                SELECT COUNT(*) INTO empleados_mismo_dni
                FROM empleados
                WHERE dni = p_dni;

                IF empleados_mismo_dni > 0 THEN
                    BEGIN
                    /*Es paciente registrado solo necesita legajo de empleado y modificar user segun funcion... */
                         INSERT INTO empleados (legajo_empleado,dni,id_funcion)
						SELECT p_legajo_empleado, p_dni,id_funcion FROM roles_empleados WHERE funcion = p_funcion;

                        /* Buscamos el user y cambiamos sus privilegios */
                    END;
                ELSE
                    BEGIN
                         /* Estan su datos pero no es paciente ni empleado, lo ingresamos a paciente y le damos user de empleado segun funcion. */
                        INSERT INTO empleados (legajo_empleado,dni,id_funcion)
                        SELECT p_legajo_empleado, p_dni,id_funcion FROM roles_empleados WHERE funcion = p_funcion;
                        /* Le damos el user */
                    END;
                END IF;
            ELSE
                BEGIN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'No existen datos para este DNI en la BD, use el metodo crear_nuevo_empleado...';
                END;
            END IF;
		END;
    END IF;
END;


*/