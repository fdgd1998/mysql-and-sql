/*Barco*/
DROP PROCEDURE IF EXISTS insbarco;
DELIMITER $$
CREATE PROCEDURE insbarco(mat int(10), nombre varchar(25), fechabot date, peso int(6))
	BEGIN
		DECLARE CONTINUE HANDLER FOR 1062 SELECT 'Clave principal duplicada' AS 'ERROR';
        INSERT INTO barco VALUES (mat, nombre, fechabot, peso);
	END $$
DELIMITER ;

/*Marinero*/
DROP PROCEDURE IF EXISTS insmarinero;
DELIMITER $$
CREATE PROCEDURE insmarinero(DNI VARCHAR(9), NOMBRE VARCHAR(25),
							APELLIDOS VARCHAR(35), SEXO VARCHAR(1), EDAD INT(3), 
                            DIRECCION VARCHAR(40), CP INT(5))
	BEGIN
		DECLARE CONTINUE HANDLER FOR 1062 SELECT 'Clave principal duplicada' AS 'ERROR';
        INSERT INTO marinero VALUES (dni, nombre, apellidos, sexo, edad, direccion, cp);
	END $$
DELIMITER ;

/*Tripulación*/
DROP PROCEDURE IF EXISTS instripu;
DELIMITER $$
CREATE PROCEDURE instripu(MAT INT(10), DNI VARCHAR(9), FECHA DATE, SUELDO INT(5), 
						  ESTADO VARCHAR(1))
	BEGIN
		DECLARE CONTINUE HANDLER FOR 1062 SELECT 'Clave principal duplicada' AS 'ERROR';
        INSERT INTO tripulacion VALUES (mat, dni, fecha, sueldo, estado);
	END $$
DELIMITER ;