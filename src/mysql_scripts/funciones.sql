
DELIMITER //

CREATE FUNCTION get_nuevo_legajo_empleado(dni VARCHAR(30),id_funcion_empleado INT) RETURNS VARCHAR(30)
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


DELIMITER //
CREATE FUNCTION get_nuevo_legajo_paciente(dni VARCHAR(30)) RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    RETURN CONCAT('PACT','-',dni);
END //
DELIMITER ;

DELIMITER //
CREATE FUNCTION getEdad(fecha_nac DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
	-- Declaro variables que usare.
	DECLARE edad INT;
    DECLARE anio_actual INT;
    DECLARE anio_nac INT;
    DECLARE mes_actual INT;
    DECLARE mes_nac INT;
    DECLARE dia_actual INT;
    DECLARE dia_nac INT;
    -- Obtengo el año actual y el año de nacimiento
    SET anio_actual = YEAR(CURDATE());
    SET anio_nac = YEAR(fecha_nac);
    -- Calcular la edad usando los anios transcurridos desde nacimiento
    SET edad = anio_actual - anio_nac;
    -- Obtener el mes y el día actuales y de nacimiento
    SET mes_actual = MONTH(CURDATE());
    SET mes_nac = MONTH(fecha_nac);
    SET dia_actual = DAY(CURDATE());
    SET dia_nac = DAY(fecha_nac);
    -- Ajusto la edad si el cumpleaños no ha pasado este año
    IF (mes_actual < mes_nac) OR (mes_actual = mes_nac AND dia_actual < dia_nac) THEN
        SET edad = edad - 1;
    END IF;
    RETURN edad;
END //DELIMITER ;


select get_nuevo_legajo_empleado('31823844',2) as 'Nuevo legajo';
select get_nuevo_legajo_paciente('31823844') as 'Nuevo legajo';
select getEdad('1985-12-24')



DELIMITER //

CREATE FUNCTION get_id_turno RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    declare id_for_turno VARCHAR(30)
    -- Transformo la fecha en Dia Giuliano

    -- Miro el contador el numero que hay y lo copio.ABORT

    --pongo en id for turno la combinacion anio,diajuliano y numero de turno en tabla + 1

    --actualizo el numero
    RETURN id_for_turno
END //

DELIMITER ;