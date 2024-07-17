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

