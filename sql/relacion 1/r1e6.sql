delimiter $$
drop procedure if exists impares;
create procedure impares ()
begin
	declare n int default 1;
    declare cont int default 1;
    while n < 199 do
		if mod(n, 2) != 0 then
			set n = 100 + ((2 * cont) - 1);
			insert into impares values (n);
			set cont = cont + 1;
        end if;
    end while;
    select * from impares;
end; $$

drop table impares;
create table impares (impares int);
call impares ();