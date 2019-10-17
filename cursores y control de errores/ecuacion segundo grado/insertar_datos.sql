/*Este procedimiento guarda en la tabla incognitas 100 valores enteros entre el 0 y 100.
Como RAND() genera valores entre 0 y 1, mulitplico por 100 y lo trunco para que no tenga decimales*/
delimiter $$
drop procedure if exists CARGA;
create procedure CARGA ()
begin
	declare cont int default 1;
	carga:loop
		insert into INCOGNITAS values(
			truncate(100*RAND(), 0),
			truncate(100*RAND(), 0),
			truncate(100*RAND(), 0)
		);
        set CONT = CONT + 1;
        if CONT >= 100 then leave carga;
        end if;
    end loop;
end;$$

