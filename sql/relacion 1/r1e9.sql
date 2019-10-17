delimiter $$
drop function suma1000primerospares;
create function suma1000primerospares ()
	returns int
begin
	declare n int;
    declare cont int default 0;
	declare suma int;
    while cont < 1000 do
		if mod(n, 2) = 0 then
			set n = 2 * n;
			set suma = suma + n;
            set cont = cont + 1;
        end if;
	end while;
    return suma;
end; $$

select suma1000primerospares();
