delimiter $$
drop function if exists esPrimo;
create function esPrimo (numero int)
returns bool
begin
	declare primo bool default true;
    declare cont int default numero;
    declare aux int;
	siPrimo:loop
		set aux = mod(numero, cont);
        if aux = 0 and cont != numero and cont != 1 then set primo =  false;
        else set primo = true;
        end if;
        set cont = cont - 1;
        if cont = 1 then leave siPrimo;
        end if;
    end loop;
    return primo;
end; $$

/*Devuelve '0' si no es primo*/
select esPrimo (2);
select esPrimo (4);