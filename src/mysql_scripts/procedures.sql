
/* Devuelve true o false segun la persona  este o no este registrado en en la BD... 
   Independientemente si es empleado o paciente...
*/
DELIMITER //
CREATE FUNCTION existe_persona(dni_buscado VARCHAR(30)) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    /* Declaro variable donde guardo los resultados encontrados... */
    DECLARE coincidencias INT DEFAULT 0;
    /* Consulto en la tabla datos personales si existe el DNI */
    SELECT COUNT(*) INTO coincidencias  FROM datos_personales WHERE dni = dni_buscado;
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
CREATE FUNCTION es_empleado(dni_buscado VARCHAR(30)) RETURNS INT
DETERMINISTIC
BEGIN
    /* Declaro variable donde guardo los resultados encontrados... */
    DECLARE coincidencias INT DEFAULT 0;
    /* Consulto en la tabla datos personales si existe el DNI */
    SELECT COUNT(*) INTO coincidencias FROM empleados WHERE dni = dni_buscado;
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
CREATE FUNCTION es_paciente(dni_buscado VARCHAR(30)) RETURNS INT
DETERMINISTIC
BEGIN
    /* Declaro variable donde guardo los resultados encontrados... */
    DECLARE coincidencias INT DEFAULT 0;
    /* Consulto en la tabla datos personales si existe el DNI */
    SELECT COUNT(*) INTO coincidencias FROM pacientes WHERE dni = dni_buscado;
    /* De acuerdo al resultado devuelvo 1 (verdadero) o 0 (falso)... */
    IF coincidencias > 0 THEN
        RETURN 1;
    ELSE
        RETURN 0;
    END IF;
END 
//DELIMITER ;


/*------------------------------------------------------------------------------ */
DELIMITER //
CREATE PROCEDURE registrar_persona (
    IN p_dni VARCHAR(30),IN p_nombre1 VARCHAR(255),IN p_nombre2 VARCHAR(255),IN p_apellido VARCHAR(255),IN p_fecha_nacimiento DATE,
    IN p_calle VARCHAR(255),IN p_altura_calle INT,IN p_codigo_postal VARCHAR(20),IN p_localidad VARCHAR(100),IN p_provincia VARCHAR(100) ,
    IN p_pais VARCHAR(100),IN p_latitud DECIMAL(10, 8), IN p_longitud DECIMAL(11, 8),IN p_email VARCHAR(254),IN p_telefono_celular VARCHAR(30),
    IN p_telefono_fijo VARCHAR(30), IN p_telefono_urgencia VARCHAR(30))
BEGIN
    DECLARE nuevo_id_datos_domicilio INT;
    DECLARE nuevo_id_datos_telefonicos INT;
    DECLARE nuevo_id_user_system INT;

    /* Si el dni ya existe en datos personales va a rechazar el ingreso por clave duplicada ya que dni es clave primaria...*/
    IF existe_persona(p_dni) = 0 THEN /*Falta agregar la condicion que no haya parametros null*/
		BEGIN
            DECLARE exit_handler BOOLEAN DEFAULT FALSE;
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET exit_handler = TRUE;

            INSERT INTO datos_personales (dni,nombre1,nombre2,apellido,fecha_nacimiento, email)
            VALUES (p_dni,p_nombre1,p_nombre2,p_apellido,p_fecha_nacimiento, p_email);

            INSERT INTO datos_domicilios (id_datos_domicilio,dni,calle,altura_calle,codigo_postal,localidad,provincia,pais,latitud,longitud)
            VALUES (p_dni,p_dni,p_calle,p_altura_calle,p_codigo_postal,p_localidad,p_provincia,p_pais,p_latitud,p_longitud);

            SELECT id_datos_domicilio INTO nuevo_id_datos_domicilio FROM datos_domicilios WHERE id_datos_domicilio = p_dni;
            UPDATE datos_personales SET id_datos_domicilio = nuevo_id_datos_domicilio  WHERE dni = p_dni;
                
            INSERT INTO datos_telefonicos(id_datos_telefonicos,dni,telefono_celular,telefono_fijo,telefono_urgencia)
            VALUES	(p_dni,p_dni,p_telefono_celular,p_telefono_fijo,p_telefono_urgencia);
                    
            SELECT id_datos_telefonicos INTO nuevo_id_datos_telefonicos FROM datos_telefonicos WHERE id_datos_telefonicos = p_dni;
            UPDATE datos_personales SET id_datos_telefonicos = nuevo_id_datos_telefonicos WHERE dni = p_dni;
                
            INSERT INTO usuarios_sistema (user_id,user_dni,user_email,user_password)
            VALUES (p_dni,p_dni,p_email,'123435466');
                
            SELECT user_id INTO nuevo_id_user_system FROM usuarios_sistema WHERE user_id = p_dni;
            UPDATE datos_personales SET id_user_system = nuevo_id_user_system WHERE dni = p_dni;
        END;
	ELSE 
		BEGIN
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'Ya existe una persona registrada con este dni en la base de datos...';
        END;
	END IF;
		
    /* Mas adelante seria necesario implementar que si por algun motivo algo falla, entonces hay que limpiar los registros
     que se  crearon de antemano en domicilios y telefonos. De todos modos, por mas que sea irrelevante , yo lo valido
     arriba con un IF no existe el dni. Pero eso ya pasaria por si solo cuando sql encuentre valores de dni duplicados.
     En este caso yo digo... si no existe el dni, el proceso se da normal, si existe,lanzo un error... */
END;

//DELIMITER;

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
    DECLARE id_user_rol_empleado INT;

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
                    SELECT id_user_rol INTO id_user_rol_empleado FROM roles_usuario_sistema WHERE rol = 'user_paciente';
                    UPDATE usuarios_sistema SET user_rol = id_user_rol_empleado  WHERE user_id = p_dni;
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
    IN p_funcion VARCHAR(30),IN p_legajo_empleado VARCHAR(30),IN p_dni VARCHAR(30),IN p_nombre1 VARCHAR(255),IN p_nombre2 VARCHAR(255),IN p_apellido VARCHAR(255),
    IN p_fecha_nacimiento DATE, IN p_calle VARCHAR(255),IN p_altura_calle INT,IN p_codigo_postal VARCHAR(20),IN p_localidad VARCHAR(100),IN p_provincia VARCHAR(100) ,
    IN p_pais VARCHAR(100),IN p_latitud DECIMAL(10, 8), IN p_longitud DECIMAL(11, 8),IN p_email_contacto VARCHAR(254),IN p_telefono_celular VARCHAR(30),
    IN p_telefono_fijo VARCHAR(30),IN p_telefono_urgencia VARCHAR(30))
BEGIN
    /*VARIABLES */
    DECLARE empleados_mismo_legajo INT DEFAULT 0;

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
                    SET MESSAGE_TEXT = 'Ya hay registros a partir de este DNI, crear el empleado desde el stored procedure registrar_nuevo_empleado_desde_dni...';
                END;
            ELSE
                BEGIN
                    /* Registramos la persona */
                    CALL registrar_persona(p_dni, p_nombre1, p_nombre2, p_apellido, p_fecha_nacimiento, p_calle, p_altura_calle, p_codigo_postal, p_localidad,
                    p_provincia, p_pais, p_latitud, p_longitud, p_email_contacto, p_telefono_celular, p_telefono_fijo, p_telefono_urgencia);
                    /* Ingresamos a empleados la persona nueva creada...*/
                    INSERT INTO empleados (p_legajo_empleado,p_dni,P_id_funcion)
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


