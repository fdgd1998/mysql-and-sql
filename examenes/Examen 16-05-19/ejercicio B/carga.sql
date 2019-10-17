drop procedure if exists carga;
delimiter $$
create procedure carga ()
	begin
    declare a int;
    declare b int;
    declare vuelta int;
    declare contador int default 1;
    repeat
		set a = truncate(100*rand(), 2);
        set b = truncate(100*rand(), 2);
        set vuelta = truncate(10*rand(), 1);
        if (a between 1 and 15 and
			b between 1 and 15 and
            vuelta between 1 and 5)
		then insert into NUMEROS values(a, b, vuelta);
        set contador = contador + 1;
        end if;
	until contador > 1000 end repeat;
end; $$