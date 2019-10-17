USE cazadores;

/*1)Datos de la pieza cazada, así como el arma que se utilizó y nombre del cazador.*/

SELECT CAZADOR.nombre, PIEZAS.raza, PIEZAS.especie, PIEZAS.zona, CACERIA.altura, CACERIA.peso, CACERIA.sexo, CACERIA.fecha,ARMAS.tipo
FROM CACERIA 
INNER JOIN PIEZAS on PIEZAS.codpie = CACERIA.codpie
INNER JOIN POSEE on POSEE.codsuj = CACERIA.codsuj
INNER JOIN ARMAS on ARMAS.codarma =  POSEE.codarma
INNER JOIN CAZADOR on CAZADOR.codcaz = POSEE.codcaz;

/*2)Realizar una función que realice un descuento del 23%, sólo a las cazadoras, sobre la cuota pagada al club por ser socia (aplicar procedimiento que llame a la función).*/

/*FUNCION 23% DTO.*/

DROP FUNCTION IF EXISTS descuento23;
DELIMITER $$

CREATE FUNCTION descuento23(cuota float)
RETURNS float
BEGIN
DECLARE dto float;
SET dto=cuota-(cuota*23/100);
RETURN dto;
END$$

DELIMITER ;

/*PROCEDIMIENTO*/

DROP PROCEDURE IF EXISTS caza_descuento;
DELIMITER $$

CREATE PROCEDURE caza_descuento()
BEGIN
	DECLARE var_cuota FLOAT(10);
    DECLARE var_codcaz INT(3);
	DECLARE fin INT DEFAULT 0;
	DECLARE cont INT DEFAULT 0;
	DECLARE cursor1 CURSOR FOR SELECT CAZADOR.cuota, CAZADOR.codcaz FROM CAZADOR WHERE CAZADOR.sexo='M';
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin=1; 
		OPEN cursor1;
		bucle: LOOP
        FETCH cursor1 INTO var_cuota,var_codcaz;
			IF fin=1 THEN LEAVE bucle;
			END IF;
				SET var_cuota=descuento23(var_cuota);
                UPDATE CAZADOR SET CAZADOR.cuota=var_cuota WHERE CAZADOR.codcaz=var_codcaz;
        END LOOP;
        CLOSE cursor1;
        SELECT * FROM CAZADOR;
END;$$

DELIMITER ;

CALL caza_descuento();


/*3)Realizar control de errores para la inserción de clubes, cazadores, piezas y armas.*/

/*PARA CLUB*/

DROP PROCEDURE IF EXISTS caz_club;
DELIMITER $$

CREATE PROCEDURE caz_club(codclub int(3),nombre varchar(20))
	BEGIN
		DECLARE duplicate_key INT DEFAULT 0;
        DECLARE CONTINUE HANDLER FOR 1062 SET duplicate_key=1;
		INSERT INTO CLUB values (codclub,nombre);
        IF duplicate_key=1 THEN
			SELECT 'variable duplicada' AS 'Error';
		ELSE 
			SELECT * FROM CLUB;
		END IF;
END; $$

DELIMITER ;

CALL caz_club(11,'Cazastor');

/*PARA CAZADOR*/

DROP PROCEDURE IF EXISTS caz_cazador;
DELIMITER $$

CREATE PROCEDURE caz_cazador(codcaz int(3), nombre varchar(20), edad int(3), sexo varchar(1), tlf int(9), cuota float(5), codclub int(3))
	BEGIN
		DECLARE duplicate_key INT DEFAULT 0;
        DECLARE CONTINUE HANDLER FOR 1062 SET duplicate_key=1;
		INSERT INTO CAZADOR values (codcaz,nombre,edad,sexo,tlf,cuota,codclub);
        IF duplicate_key=1 THEN
			SELECT 'variable duplicada' AS 'Error';
		ELSE 
			SELECT * FROM CAZADOR;
		END IF;
END; $$

DELIMITER ;

CALL caz_cazador(1,'Pepa Ramirez',31,'M',698747125,300,11);

/*PARA PIEZAS*/

DROP PROCEDURE IF EXISTS caz_piezas;
DELIMITER $$

CREATE PROCEDURE caz_piezas(codpie int(6),raza varchar(8),especie varchar(8),zona varchar(6))
	BEGIN
		DECLARE duplicate_key INT DEFAULT 0;
        DECLARE CONTINUE HANDLER FOR 1062 SET duplicate_key=1;
		INSERT INTO PIEZAS values (codpie,raza,especie,zona);
        IF duplicate_key=1 THEN
			SELECT 'variable duplicada' AS 'Error';
		ELSE 
			SELECT * FROM PIEZAS;
		END IF;
END; $$

DELIMITER ;

CALL caz_piezas(1,'Venado','Albino','Norte');

/*PARA ARMAS*/

DROP PROCEDURE IF EXISTS caz_armas;
DELIMITER $$

CREATE PROCEDURE caz_armas(codarma int(4),tipo varchar(20))
	BEGIN
		DECLARE duplicate_key INT DEFAULT 0;
        DECLARE CONTINUE HANDLER FOR 1062 SET duplicate_key=1;
		INSERT INTO ARMAS values (codarma,tipo);
        IF duplicate_key=1 THEN
			SELECT 'variable duplicada' AS 'Error';
		ELSE 
			SELECT * FROM ARMAS;
		END IF;
END; $$

DELIMITER ;

CALL caz_armas(1,'Rifle 3a2');


/*4)Controlar el error si intentamos borrar una ocurrencia de una pieza que no existe.*/

DROP PROCEDURE IF EXISTS borra_pieza;
DELIMITER $$

CREATE PROCEDURE borra_pieza (codpie int)
BEGIN
	DECLARE unknown_key INT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR 1054 SET unknown_key = 1;
	DELETE FROM PIEZAS;
	IF unknown_key = 1 THEN
		SELECT 'Clave desconocida' AS 'ERROR';
    ELSE
		SELECT * FROM PIEZAS;
	END IF;
END;$$











