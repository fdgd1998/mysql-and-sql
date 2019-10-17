delimiter $$
create function sumaMultiplos5 ()
	returns int
begin
	declare n int;
    declare cont int default 0;
    multiplos:while n < 100 do
		set cont = cont + 1;
        set n = n * cont;
    end while;
    return n;
end; $$