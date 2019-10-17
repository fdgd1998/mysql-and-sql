drop procedure if exists borrado;
delimiter $$
create procedure borrado ()
begin
	declare var_cod int;
    declare var_nombre longtext;
    declare var_apellidos longtext;
    declare var_sueldo int;
    declare fin bool default 0;
    declare borrar cursor for
		select cod, nombre, apellidos, sueldo
        from HOMBRES
        where sueldo > 3000;
	declare continue handler for not found set fin = 1;
    open borrar;
		repeat
			fetch borrar into var_cod, var_nombre, var_apellidos, var_sueldo;
            insert into HOMBRESMASTRESMIL values (var_cod, var_nombre, var_apellidos, var_sueldo);
            delete from HOMBRES where cod = var_cod;
        until fin = 1 end repeat;
    close borrar;
end; $$