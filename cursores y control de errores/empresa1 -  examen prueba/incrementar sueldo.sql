drop procedure if exists incrementarSueldo;
delimiter $$
create procedure incrementarSueldo ()
begin
	declare var_codigo int;
    declare var_sueldo int;
    declare fin bool default 0;
    declare incrementar cursor for
		select cod, sueldo
        from MUJERES
        where sueldo between 1500 and 2500;
	declare continue handler for not found set fin = 1;
    open incrementar;
		repeat
			fetch incrementar into var_codigo, var_sueldo;
			update MUJERES set sueldo = calcular25(var_sueldo) where cod = var_codigo;
		until fin = 1 end repeat;
    close incrementar;
end; $$