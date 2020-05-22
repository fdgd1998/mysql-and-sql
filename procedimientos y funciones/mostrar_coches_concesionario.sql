CREATE DEFINER = 'root'@'localhost' PROCEDURE `mostrar_coches_concesionario`(
        IN `cod` INTEGER(9)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	select count(coches.codcoche)
    from coches inner join distribucion using(codcoche)
     		    inner join concesionario using(cifc)
    where cifc = cod;
END;