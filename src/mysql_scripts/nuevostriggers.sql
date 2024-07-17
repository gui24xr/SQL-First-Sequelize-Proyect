
/* Luego de que se haga un insert into en pacientes construye un user con los permisos correspondientes. */
DELIMITER //

CREATE TRIGGER pacientes_after_insert
AFTER INSERT ON pacientes
FOR EACH ROW
BEGIN
	/* Se inserto satisfactoriamente un paciente, vamos a crearle un user */
    /* EL nuevo user inicia con status false ya que la persona lo debe activar antes de usarlo */
    /* Tendra como contraseña el usuario + dni user */
    /* EL tipo de usuario sera tipo de usuario paciente */
    DECLARE codigo_sistema_pacientes VARCHAR(10);
    SELECT codigo_tipo_usuario INTO codigo_sistema_pacientes FROM tipos_usuario_sistema WHERE codigo_tipo_usuario ='EMP';
    INSERT INTO usuarios_sistema (user_system_id, user_password,user_tipo) VALUES (NEW.dni,CONCAT('usuario',NEW.dni),codigo_sistema_pacientes);
    /* Ya creado el usuario lo ligamos a la ficha datos personales */
    
    UPDATE fichas_datos_personales SET user_system_id = NEW.dni WHERE dni = NEW.dni;
END //
DELIMITER ;



