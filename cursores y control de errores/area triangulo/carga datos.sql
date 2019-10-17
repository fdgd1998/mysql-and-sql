delimiter $$
create procedure CARGA ()
begin
	declare contador int default 0;
	insertarBD:loop
		insert into incognitas values (
			truncate (100*rand(),0),
            truncate (100*rand(),0)
		);
        set contador = contador + 1;
        if contador > 100 then leave insertarBD;
        end if;
    end loop;
end; $$