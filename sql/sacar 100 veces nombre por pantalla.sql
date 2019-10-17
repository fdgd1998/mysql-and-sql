drop procedure if exists imprimirNombre;
delimiter $$
create procedure imprimirNombre ()
	begin
    declare nombre longtext default 'fran';
    declare contador1 int default 0;
    declare contador2 int default 0;
    declare contador3 int default 0;
    declare acumulador int default 0;
    repeat
		while contador2 < 10 do
			bucle:loop
				if contador1 > 10 then leave bucle;
                end if;
				select concat('Iteración ',acumulador,' : ',nombre);
                set contador1 = contador1 + 1;
                set acumulador = acumulador + 1;
			end loop;
			set contador1 = 1;
            set contador2 = contador2 + 1;
		end while;
        set contador2 = 1;
        set contador3 = contador3 + 1;
	until contador3 > 10 end repeat;
end;$$