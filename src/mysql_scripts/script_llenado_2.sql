
DELIMITER //

CREATE FUNCTION get_nuevo_legajo(dni VARCHAR(30),id_funcion_empleado INT) RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    DECLARE abreviatura_funcion_result VARCHAR(3);
    DECLARE result VARCHAR(30);
	SELECT abreviatura_funcion INTO abreviatura_funcion_result
    FROM roles_empleados
    WHERE id_funcion = id_funcion_empleado;
    SET result = CONCAT(abreviatura_funcion_result,'-',dni);
    RETURN result;
END //

DELIMITER ;

select get_nuevo_legajo('31823844',2) as 'Nuevo legajo';

INSERT INTO empleados
(legajo_empleado,dni,id_funcion)
VALUES
(get_nuevo_legajo('31823844',2),'31823844',2)


