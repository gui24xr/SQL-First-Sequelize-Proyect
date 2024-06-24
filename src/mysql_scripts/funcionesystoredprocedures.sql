
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

CREATE PROCEDURE actualizar_fecha_contadores()
BEGIN
    -- Fecha en la que estoy dando contadores.
    DECLARE fecha_reciente DATE;

    SELECT MAX(fecha) INTO fecha_reciente
    FROM contadores;

    -- Si fecha es anterior entonces creo nuevo registro con contadores a cero.
    IF fecha_reciente < CURDATE() THEN
        INSERT INTO contadores
        (fecha,turnos_otorgados,visitas_pacientes,ocupaciones_consultorios,registros_historias_clinicas)
        VALUES
        (CURRENT_TIMESTAMP,1,1,1,1);
    END IF;
END //

DELIMITER ;



DELIMITER //

CREATE FUNCTION get_turno() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE turno_actual INT;
    -- Actualizo la tabla contadores.
    CALL actualizar_fecha_contadores();
    -- Busco el registro que lleva el conteo de hoy.
    SELECT turnos_otorgados INTO turno_actual
    FROM contadores
    WHERE fecha = CURDATE();
    -- Ahora actualizo el contador de turnos.
    UPDATE contadores
    SET turnos_otorgados = turno_actual + 1
    WHERE fecha = CURDATE();
    -- Devuelvo el turno obtenido.
    RETURN turno_actual;
END //

DELIMITER ;





SELECT get_turno() as Turno;



DELIMITER //

CREATE PROCEDURE crear_datos_personales_vacios(dni_persona VARCHAR(30))
BEGIN
    DECLARE personas_con_dni INT;

    /* Verifico si el dni existe en datos personales */
    SELECT COUNT(*) INTO personas_con_dni
    FROM datos_personales
    WHERE dni = dni_persona;

    /* Si no hay personas con ese dni, ingreso ese nuevo dni a datos personales y quedara listo para completar */
    IF personas_con_dni = 0 THEN
        INSERT INTO datos_personales (dni, nombre1, apellido)
        VALUES (dni_persona, 'S/Nombre', 'S/Apellido');
    END IF;
END //

DELIMITER ;
