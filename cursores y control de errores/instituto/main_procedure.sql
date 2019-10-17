drop procedure if exists buscarhijos;
delimiter $$
create procedure buscarhijos ()
begin
    declare tmp_nombrepadre longtext;
    declare tmp_dnipadre int;
    declare tmp_nombrehijo longtext;
    declare tmp_edad int;
    declare fin bool default 0;
    declare buscar_hijos cursor for
		select PADRES.dni, PADRES.nombre, HIJOS.nombre, edad
        from PADRES inner join HIJOS on PADRES.dni = HIJOS.dni
        where PADRES.dni = HIJOS.dni;
	declare continue handler for not found set fin = 1;
    open buscar_hijos;
		delete from FAMILIA;
		while fin = 0 do
			fetch buscar_hijos into tmp_dnipadre, tmp_nombrepadre, tmp_nombrehijo, tmp_edad;
			insert into FAMILIA values (tmp_dnipadre, tmp_nombrepadre, tmp_nombrehijo, tmp_edad);
        end while;
    close buscar_hijos;
    select * from FAMILIA;
end; $$