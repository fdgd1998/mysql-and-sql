delimiter $$
drop procedure if exists multiplicar;
create procedure multiplicar (numero int)
	begin
    declare resultado int;
    declare aux int;
    declare cont int default 0;
    if numero < 1 or numero > 10 then select 'Introduce un número entre el 1 y el 10.';
    else
		repeat
			set resultado = numero * cont;
            insert into tablaMultiplicar values (resultado);
            set cont = cont + 1;
        until cont > 10 end repeat;
        select * from tablaMultiplicar;
	end if;
end; $$

drop table if exists tablaMultiplicar;
create table tablaMultiplicar (resultado char(10));
call multiplicar (5);