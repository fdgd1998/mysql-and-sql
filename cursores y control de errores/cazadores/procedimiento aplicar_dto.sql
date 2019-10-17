drop procedure if exists aplicar_dto;

delimiter $$
create procedure aplicar_dto ()
	begin
    declare fin bool default 0;
    declare var_cuota int;
    declare var_codcaz int;
    declare buscar_mujeres cursor for
		select cuota, codcaz
		from CAZADORES
        where sexo = 'Mujer';
	declare continue handler for not found set fin = 1;
    open buscar_mujeres;
		repeat
			fetch buscar_mujeres into var_cuota, var_codcaz;
            update CAZADORES set cuota = dto23(var_cuota) where codcaz = var_codcaz;
        until fin = 1 end repeat;
    close buscar_mujeres;
end; $$