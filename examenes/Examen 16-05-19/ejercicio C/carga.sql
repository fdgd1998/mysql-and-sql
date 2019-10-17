drop procedure if exists carga;

delimiter $$
create procedure carga ()
	begin
    declare a int;
    declare contador int default 1;
    repeat
		set a = truncate(10000*rand(), 4);
        if (a between 1 and 5000)
			then insert into NUMERO values(a);
        set contador = contador + 1;
        end if;
	until contador > 5000 end repeat;
end; $$