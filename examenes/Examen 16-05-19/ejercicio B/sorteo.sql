drop procedure if exists SORTEO;
delimiter $$
create procedure SORTEO (n1 int, n2 int, nvuelta int)
	begin
		declare fin int default 0;
        declare var_n1 int;
        declare var_n2 int;
        declare var_nvuelta int;
        declare buscar cursor for
			select n1, n2, nvuelta
            from NUMEROS;
		declare continue handler for not found set fin = 1;
        open buscar;
			repeat
				fetch buscar into var_n1, var_n2, var_nvuelta;
                if (var_n1 = n1 or var_n2 = n2) then 
					insert into PREMIOS values (1000, var_n1, var_n2, var_nvuelta);
				else if (var_n1 = n1 and var_n2 = n2) then
					insert into PREMIOS values (2000, var_n1, var_n2, var_nvuelta);
				else if (var_vuelta = nvuelta) then
					insert into VUELTA values (var_n1, var_n2, var_nvuelta);
				else select "No has tenido suerte";
                end if;
                end if;
                end if;
            until fin = 1 end repeat;
        close buscar;
end; $$