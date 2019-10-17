drop procedure if exists PRIMO;

delimiter $$
create procedure PRIMO ()
	begin
    declare fin int default 0;
    declare var_numero int;
    declare divisor int default 2;
    declare buscar cursor for 
		select numero from NUMERO;
	declare continue handler for not found set fin = 1;
    open buscar;
		repeat
			fetch buscar into var_numero;
            while (mod(var_numero,divisor) != 0 and divisor < var_numero) do
				set divisor = divisor + 1;
			end while;
            if (divisor = var_numero) then insert into RESULTPRI values (var_numero, 'Es primo');
            else insert into RESULTPRI values (var_numero, 'No es primo');
            end if;
            set divisor = 2;
        until fin = 1 end repeat;
    close buscar;
end; $$