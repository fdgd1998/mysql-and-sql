/*Sacar el nombre y apellidos ordenados de forma descendente por apellido
de todos aquellos marineros cuyo acumulado de sueldo sea mayor de 10000*/

SELECT MARINERO.nombre, MARINERO.apellidos, SUM(SUELDO) AS 'Sueldo total'
FROM MARINERO 
INNER JOIN TRIPULACION ON MARINERO.dni=TRIPULACION.dni
GROUP BY TRIPULACION.dni
HAVING SUM(SUELDO)>10000
ORDER BY MARINERO.apellidos DESC;

/*Crear la funcion aumenta el sueldo del marinero*/
DROP FUNCTION IF EXISTS premio;
DELIMITER $$
CREATE FUNCTION premio(s int)
	RETURNS INT
		BEGIN
			DECLARE total INT DEFAULT 0;
            SET total = s * 1.20;
            RETURN total;
		END $$
DELIMITER ;

/*Procedimiento para aumentar el sueldo*/
DROP PROCEDURE IF EXISTS aumentar;
DELIMITER $$
CREATE PROCEDURE aumentar()
	BEGIN
		DECLARE sueldo_i INT DEFAULT 0;
        DECLARE idmari VARCHAR(9);
        DECLARE matri INT DEFAULT 0;
        DECLARE salida INT DEFAULT 0;
        DECLARE cursormari CURSOR FOR
			SELECT TRIPULACION.dni, TRIPULACION.sueldo, TRIPULACION.mat
            FROM MARINERO
            INNER JOIN TRIPULACION ON TRIPULACION.dni=MARINERO.dni
            INNER JOIN BARCO ON TRIPULACION.mat=BARCO.mat
            WHERE MARINERO.sexo = 'H'
            AND MARINERO.cp = (	SELECT cp 
								FROM MARINERO
                                WHERE nombre = 'Ana'
                                AND apellidos = 'Mendiaz')
			OR TRIPULACION.mat = 24;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET salida = 1;
        OPEN cursormari;
			bucle: while salida = 0 do
					FETCH cursormari INTO idmari,sueldo_i,matri;
                    SET sueldo_i = premio(sueldo_i);
                    UPDATE tripulacion
                    SET sueldo = sueldo_i
                    WHERE dni = idmari
                    AND mat = matri;
			END WHILE bucle;
		CLOSE cursormari;
	END $$
DELIMITER ;

call aumentar();

/*Dar de baja a los tripulantes de los barcos mayores de 30 toneladas
 y que cobran entre 2000 y 4000*/ 
DROP PROCEDURE IF EXISTS dardebaja;
DELIMITER $$
CREATE PROCEDURE dardebaja()
	BEGIN
		DECLARE matri INT;
        DECLARE estado_i VARCHAR(1);
        DECLARE dni_i VARCHAR(9);
        DECLARE salida INT DEFAULT 0;
        DECLARE cursorbaja CURSOR FOR
			SELECT TRIPULACION.mat, TRIPULACION.dni, TRIPULACION.estado
			FROM TRIPULACION
            INNER JOIN BARCO ON TRIPULACION.mat=BARCO.mat
            WHERE BARCO.peso > 30000
            AND TRIPULACION.sueldo BETWEEN 2000 AND 4000;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET salida = 1;
        OPEN cursorbaja;
			bucle: while salida = 0 do
				FETCH cursorbaja INTO matri, dni_i, estado_i;
                SET estado_i = 'B';
                UPDATE TRIPULACION
                SET estado = estado_i
                WHERE TRIPULACION.mat = matri
                AND TRIPULACION.dni = dni_i;
			END WHILE bucle;
		CLOSE cursorbaja;
	END $$
DELIMITER ;

call dardebaja();