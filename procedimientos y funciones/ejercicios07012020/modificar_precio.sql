CREATE DEFINER = 'root'@'localhost' PROCEDURE `modificar_precio`(
        IN `cod` INTEGER,
        IN `pre` INTEGER
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	update coches set precio = pre where codcoche = cod;
END;