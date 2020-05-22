CREATE DEFINER = 'root'@'localhost' PROCEDURE `mostrar_coches_concesionario`(
        IN `concesionario` INTEGER
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	select count(cifc) from ventas where cifc = concesionario;
END;