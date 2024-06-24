DELIMITER //

CREATE PROCEDURE insertar_empleado(
    IN p_dni VARCHAR(30), 
    IN p_nombre VARCHAR(30), 
    IN p_apellido VARCHAR(30), 
    IN p_id_funcion INT,
    IN p_fecha_nacimiento DATE
)
BEGIN
    DECLARE legajo_nuevo_empleado VARCHAR(30);

    -- Insertar en datos_personales 
    INSERT INTO datos_personales 
        (dni, nombre1, apellido,fecha_nacimiento) 
    VALUES 
        (p_dni, p_nombre, p_apellido,p_fecha_nacimiento);
    -- Obtener el legajo utilizando la función get_nuevo_legajo
    SET legajo_nuevo_empleado := get_nuevo_legajo_empleado(p_dni, p_id_funcion);

    -- Insertar en empleados
    INSERT INTO empleados 
        (legajo_empleado, dni, id_funcion)
    VALUES 
        (legajo_nuevo_empleado, p_dni, p_id_funcion);
END //
DELIMITER ;

CALL insertar_empleado('31823844','Guillermo','Guardia',2,'1985-12-24');
DELETE from datos_personales where dni = '31823844';



DELIMITER //

CREATE PROCEDURE insertar_paciente(
    IN p_dni VARCHAR(30), 
    IN p_nombre VARCHAR(30), 
    IN p_apellido VARCHAR(30), 
    IN p_fecha_nacimiento DATE
)
BEGIN
    DECLARE legajo_nuevo_paciente VARCHAR(30);

    -- Insertar en datos_personales 
    INSERT INTO datos_personales (dni, nombre1, apellido, fecha_nacimiento) 
    VALUES (p_dni, p_nombre, p_apellido, p_fecha_nacimiento);

    -- Obtener el legajo utilizando la función get_nuevo_legajo_paciente
    SET legajo_nuevo_paciente := get_nuevo_legajo_paciente(p_dni);

    -- Insertar en pacientes
    INSERT INTO pacientes (legajo_paciente, dni)
    VALUES (legajo_nuevo_paciente, p_dni);
END //

DELIMITER ;

CALL insertar_paciente('31823834','Gaaauillermo','Guardia','1985-12-24');
DELETE from datos_personales where dni = '31823844';
