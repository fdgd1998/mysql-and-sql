CREATE DEFINER = 'root'@'localhost' PROCEDURE `diesel_gasolina_marca`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	declare vnombre char(20);
    declare vmodelo char(20);
    declare tipo char(20);
    declare cursor_tipo cursor for select coches.nombre, modelo
								   from coches inner join marco using(codcoche)
                                   			   inner join marcas using(cifm)
                                   where vmarca = marcas.nombre;
    declare exit handler for not found
    begin
    end;
    open cursor_tipo;
    	loop
        fetch cursor_tipo into vnombre, vmodelo;
        	if vmodelo in("GT", "GTD") then
            	set tipo = "Diesel";
            else
            	set tipo = "Gasolina";
            end if;
            select vnombre, vmodelo, tipo;
        end loop;
    close cursor_tipo;
END;