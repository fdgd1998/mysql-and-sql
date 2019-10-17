delimiter $$
drop procedure if exists OPERAR;
create procedure OPERAR()
begin
	declare FIN bool default 0;
    declare TMPa float;
    declare TMPb float;
    declare TMPc float;
    declare CURSOR_EC cursor for select a, b, c from INCOGNITAS;
    declare continue handler for not found set FIN = 1;
    open CURSOR_EC;
    calculo:loop
		fetch CURSOR_EC into TMPa, TMPb, TMPc;
        call ECUACIONGRADO2(TMPa, TMPb, TMPc);
        if FIN = 1 then leave calculo;
        end if;
    end loop;
    close CURSOR_EC;
end;$$
