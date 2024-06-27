DELIMITER //

CREATE TRIGGER eliminar_datos_relacionados_datos_personales
AFTER DELETE ON datos_personales
FOR EACH ROW
BEGIN
    -- Eliminar registro en datos_domicilios correspondiente al domicilio del usuario
    DELETE FROM datos_domicilios WHERE id_datos_domicilio = OLD.domicilio;
    -- Eliminar registro en datos_telefonicos correspondiente a los teléfonos del usuario
    DELETE FROM datos_telefonicos WHERE id_datos_telefonicos = OLD.telefonos;
END //

DELIMITER ;
