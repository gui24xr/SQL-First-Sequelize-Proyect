DELIMITER //
CREATE FUNCTION getSuma(numero INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN numero + 1;
END //DELIMITER ;


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
