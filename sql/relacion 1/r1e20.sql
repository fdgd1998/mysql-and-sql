delimiter $$
drop procedure if exists imprimirNumeros;
create procedure imprimirNumeros ()
begin
    declare cont int default 1;
    declare numero int;
	generar:loop
		set numero = cont;
        insert into numeros values (numero);
        set cont = cont + 1;
        if cont > 20 then leave generar;
        end if;
	end loop;
    set cont = 1;
	imprimir:loop
		select * from numeros;
        set cont = cont + 1;
        if cont > 5 then leave imprimir;
        end if;
    end loop;
end; $$

drop table numeros;
create table numeros (numeros int(2) primary key);
call imprimirNumeros();