CREATE DEFINER = 'root'@'localhost' PROCEDURE `diesel_gasolina`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	declare vnombre char(20);
    declare vmodelo char(20);
    declare tipo char(20);
    declare cursor_tipo cursor for select nombre, modelo from coches;
    declare exit handler for not found
    begin
    end;
    open cursor_tipo;
    	bucle: loop
        	fetch cursor_tipo into vnombre, vmodelo;
        	if vmodelo in("GT", "GTD") then
            	set tipo = "Diesel";
            else
            	set tipo = "Gasolina";
            end if;
            select vnombre, vmodelo, tipo;
        end loop bucle;
    close cursor_tipo;
END;