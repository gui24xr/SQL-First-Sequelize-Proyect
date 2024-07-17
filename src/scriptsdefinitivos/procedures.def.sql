DELIMITER // 
CREATE PROCEDURE crear_ficha_datos_personales (
    IN p_dni VARCHAR(30),IN p_nombre1 VARCHAR(255),IN p_nombre2 VARCHAR(255),IN p_apellido VARCHAR(255),IN p_fecha_nacimiento DATE,IN p_email VARCHAR(254),
    IN p_calle VARCHAR(255),IN p_altura_calle INT,IN p_codigo_postal VARCHAR(20),IN p_localidad VARCHAR(100),IN p_provincia VARCHAR(100) ,
    IN p_pais VARCHAR(100),IN p_latitud DECIMAL(10, 8), IN p_longitud DECIMAL(11, 8),IN p_telefono_movil VARCHAR(30),
    IN p_telefono_fijo VARCHAR(30), IN p_telefono_urgencia VARCHAR(30))
BEGIN
            INSERT INTO fichas_datos_personales (dni,nombre1,nombre2,apellido,fecha_nacimiento, email)
            VALUES (p_dni,p_nombre1,p_nombre2,p_apellido,p_fecha_nacimiento, p_email);
            
            INSERT INTO datos_domicilios (dni,calle,altura_calle,codigo_postal,localidad,provincia,pais,latitud,longitud)
            VALUES (p_dni,p_calle,p_altura_calle,p_codigo_postal,p_localidad,p_provincia,p_pais,p_latitud,p_longitud);
                
            INSERT INTO datos_telefonicos(dni,telefono_movil,telefono_fijo,telefono_urgencia)
            VALUES	(p_dni,p_telefono_movil,p_telefono_fijo,p_telefono_urgencia);
END;
//DELIMITER ;

DELIMITER //
/* Crea un usuario para el sistema para el dni ingresado y con el permiso de usuario elegido */
CREATE PROCEDURE crear_usuario_sistema(IN p_dni VARCHAR(30), IN p_codigo_tipo_permiso VARCHAR(30),IN p_password VARCHAR(30))
BEGIN
	/* Creamos un usuario a partir del dni, ya que nuestra politica es un usuario por dni en sistema si dni no existe entonces lo rechaza */
    INSERT INTO usuarios_sistema (user_system_id, dni, user_password) VALUES (p_dni,p_dni,p_password);
    /* Con el user ya creado podemos crear el registro en la tabla que guarda los permisos para cada user */
    INSERT INTO permisos_usuarios_sistema(dni,codigo_tipo_permiso) VALUES (p_dni,p_codigo_tipo_permiso);
    /* POr definicion de tablas ya queda todo ligado y si el codigo de permiso no existiese lo rechazaria */
END;

//DELIMITER ;

DELIMITER //
/* Crea un usuario para el sistema para el dni ingresado y con el permiso de usuario elegido */
CREATE PROCEDURE crear_prestacion_medica(IN p_legajo_empleado VARCHAR(30), IN p_nombre_especialidad_medica VARCHAR(30),IN p_id_sede VARCHAR(30))
BEGIN
	/* Creamos una prestacion medica a partir del un medico existente en tabla medicos */
    /* A partir de los parametros buscamos los valores */
    DECLARE id_medico_buscado INT;
    DECLARE id_especialidad_medica_buscada INT;
    
    SELECT id_medico INTO id_medico_buscado FROM medicos WHERE legajo_empleado = p_legajo_empleado;
    SELECT id_especialidad_medica INTO id_especialidad_medica_buscada FROM especialidades_medicas WHERE nombre_especialidad_medica = p_nombre_especialidad_medica;
    INSERT INTO prestaciones_medicas (id_especialidad_medica, id_medico, id_sede_establecimiento ) VALUES (id_especialidad_medica_buscada,id_medico_buscado,p_id_sede);
   
END;

//DELIMITER ;


