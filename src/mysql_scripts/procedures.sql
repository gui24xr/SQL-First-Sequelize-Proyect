

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
    SELECT COUNT(*) INTO coincidencias
    FROM datos_personales
    WHERE dni = dni_buscado;
    
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
    SELECT COUNT(*) INTO coincidencias
    FROM empleados
    WHERE dni = dni_buscado;
    
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
    SELECT COUNT(*) INTO coincidencias
    FROM pacientes
    WHERE dni = dni_buscado;
    
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
    IN p_dni VARCHAR(30),
    IN p_nombre1 VARCHAR(255),
    IN p_nombre2 VARCHAR(255),
    IN p_apellido VARCHAR(255),
    IN p_fecha_nacimiento DATE,
    IN p_calle VARCHAR(255),  
    IN p_altura_calle INT,
    IN p_codigo_postal VARCHAR(20),
    IN p_localidad VARCHAR(100),
    IN p_provincia VARCHAR(100) ,
    IN p_pais VARCHAR(100),
    IN p_latitud DECIMAL(10, 8), 
    IN p_longitud DECIMAL(11, 8),
    IN p_email_contacto VARCHAR(254),
    IN p_telefono_celular VARCHAR(30),
    IN p_telefono_fijo VARCHAR(30),
    IN p_telefono_urgencia VARCHAR(30)
)
BEGIN
	/* VARIABLES */
	DECLARE id_datos_domicilio INT;
    DECLARE Id_datos_telefonicos INT;
    /* Si el dni ya existe en datos personales va a rechazar el ingreso por clave duplicada ya que dni es clave primaria...*/
    IF existe_persona(p_dni) = 0 THEN
		BEGIN
			/* Procedemos a crear el registro en datos_personales */
			/* Creamos y guardamos los registros de los datos de domicilio y telefono y los guardamos en variables para luego ingresar a datos_personales */
			INSERT INTO datos_domicilios 
			(calle,altura_calle,codigo_postal,localidad,provincia,pais,latitud,longitud)
			VALUES 
			(p_calle,p_altura_calle,p_codigo_postal,p_localidad,p_provincia,p_pais,p_latitud,p_longitud);
			/* Ya que el id_datos_domicilios es INT AUTO_INCREMENT se que es el ultimo */
			SET id_datos_domicilio = LAST_INSERT_ID();
			
			/* Ahora hacemos lo mismo con datos telefonicos */
			INSERT INTO datos_telefonicos
			(telefono_celular,telefono_fijo,telefono_urgencia)
			VALUES
			(p_telefono_celular,p_telefono_fijo,p_telefono_urgencia);
				/* Ya que el id_datos_telefonicos es INT AUTO_INCREMENT se que es el ultimo */
			SET id_datos_telefonicos = LAST_INSERT_ID();
			
			/* Tengo todo lo necesario,puedo insertar los dato en tabla datos_personales */
			INSERT INTO datos_personales
			  (dni,nombre1,nombre2,apellido,fecha_nacimiento,domicilio,telefonos, email_contacto)
			VALUES
			(p_dni,p_nombre1,p_nombre2,p_apellido,p_fecha_nacimiento,id_datos_domicilio,id_datos_telefonicos, p_email_contacto);
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
CREATE PROCEDURE crear_nuevo_paciente (
    IN p_legajo_paciente VARCHAR(30),
    IN p_dni VARCHAR(30),
    IN p_nombre1 VARCHAR(255),
    IN p_nombre2 VARCHAR(255),
    IN p_apellido VARCHAR(255),
    IN p_fecha_nacimiento DATE,
    IN p_calle VARCHAR(255),  
    IN p_altura_calle INT,
    IN p_codigo_postal VARCHAR(20),
    IN p_localidad VARCHAR(100),
    IN p_provincia VARCHAR(100) ,
    IN p_pais VARCHAR(100),
    IN p_latitud DECIMAL(10, 8), 
    IN p_longitud DECIMAL(11, 8),
    IN p_email_contacto VARCHAR(254),
    IN p_telefono_celular VARCHAR(30),
    IN p_telefono_fijo VARCHAR(30),
    IN p_telefono_urgencia VARCHAR(30)
)
BEGIN
    /*VARIABLES */
    DECLARE pacientes_mismo_legajo INT DEFAULT 0;

    /* Miramos que no exista un paciente con este legajo, debe ser 0, de lo contrario error.*/
    SELECT COUNT(*) INTO pacientes_mismo_legajo
    FROM pacientes
    WHERE legajo_paciente = p_legajo_paciente;

    IF pacientes_mismo_legajo > 0 THEN
       BEGIN
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'Ya existe un paciente con el mismo legajo en la BD...';
        END;
    ELSE 
        /* Ni existe paciente con tal legajo, podemos continuar */
        BEGIN
			IF existe_persona(p_dni) = 1 THEN /*eXiste la persona doy error y aviso que este metodo no se puede usar este metodo para este proposito.*/
                 BEGIN
                    SIGNAL SQLSTATE '45000' 
                    SET MESSAGE_TEXT = 'Ya hay registros a partir de este DNI, crear el paciente desde el stored procedure nuevo_paciente_desde_dni...';
                END;
            ELSE
                BEGIN
                    /* Registramos la persona */
                    CALL registrar_persona(p_dni, p_nombre1, p_nombre2, p_apellido, p_fecha_nacimiento, p_calle, p_altura_calle, p_codigo_postal, p_localidad,
                    p_provincia, p_pais, p_latitud, p_longitud, p_email_contacto, p_telefono_celular, p_telefono_fijo, p_telefono_urgencia);
                    /* Ingresamos a pacientes la persona nueva creada...*/
                    INSERT INTO pacientes
                    (legajo_paciente,dni)
                    VALUES
                    (p_legajo_paciente, p_dni);
                    /*Creamos usuario para la persona  y lo ligamos..*/
                END;
            END IF;
		END;
    END IF;
END;

