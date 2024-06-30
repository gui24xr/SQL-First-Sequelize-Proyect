
/* EL objetivo es borrar todos los FK de datos personales, pero eso dependedera de si quiero que los datos se borren al borrar el user*/
DELIMITER //

CREATE TRIGGER eliminar_datos_relacionados_datos_personales
AFTER DELETE ON ficha_datos_personales
FOR EACH ROW
BEGIN
    -- Eliminar registro en datos_domicilios correspondiente al domicilio del usuario
    DELETE FROM datos_domicilios WHERE id_datos_domicilio = OLD.id_datos_domicilio;
    -- Eliminar registro en datos_telefonicos correspondiente a los teléfonos del usuario
    DELETE FROM datos_telefonicos WHERE id_datos_telefonicos = OLD.id_datos_telefonicos;
	-- Eliminar registro en usuarios_sistema correspondiente al user asociado.
    DELETE FROM usuarios_sistema WHERE user_system_id = OLD.user_system_id;
END //

DELIMITER ;
