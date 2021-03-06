CREATE DEFINER = 'root'@'localhost' PROCEDURE `nacional_extranjero`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	declare nombre char(20);
    declare apellidos char(10);
    declare ncoche char(20);
    declare marca char(20);
    declare modelo char(20);
    declare nacionalidad char(20);
    declare salir int default 0;
    declare cursor1 cursor for
    	select clientes.nombre, clientes.apellidos, marcas.nombre, coches.nombre, coches.modelo
        from clientes inner join ventas using(dni)
        inner join coches using(codcoche)
        inner join marco using(codcoche)
        inner join marcas using(cifm);
    declare exit handler for not found set salir = 1;
    open cursor1;
    	repeat
        	fetch cursor1 into nombre, apellidos, marca, ncoche, modelo;
            if marca in("SEAT", "RENAULT") then
            	set nacionalidad = "Nacional";
            else
            	set nacionalidad = "Extranjera";
            end if;
            select nombre, apellidos, marca, ncoche, modelo, nacionalidad;
        until salir = 1
        end repeat;
    close cursor1;
END;