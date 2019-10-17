delimiter $$
/*Cálculo de los primeros 500 números impares, a partir del 1 (no incluido)*/
create procedure calcularImpares ()
begin
	declare impares int;
    declare cont int default 1;
    declare n int default 2;
    impares:loop
			set impares = 2*n - 1;
            insert into IMPARES values (impares);
            set cont = cont + 1;
            set n = n + 1;
            if cont > 7000 then leave impares;
            end if;
    end loop;
end; $$