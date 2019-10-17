delimiter $$
drop procedure if exists sumaNmultiplos5;
create procedure sumaNmultiplos5 ()
begin
	declare n int default 5;
    declare suma int default 0;
    declare cont int default 1;
    while n < 99 do
		if mod(n, 5) = 0 then
			set n = 5 * cont;
			set suma = suma + n;
			set cont = cont + 1;
        end if;
    end while;
    select suma;
end; $$

call sumaNmultiplos5 ();