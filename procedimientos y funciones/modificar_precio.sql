CREATE DEFINER = 'root'@'localhost' PROCEDURE `modificar_precio`(
        IN `cod` CHAR(9),
        IN `nuevo_precio` INTEGER(9)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	update coches set precio = nuevo_precio where codcoche = cod;
END;