delimiter $$
drop function if exists factorial;
create function factorial (numero int)
	returns double
	begin
		declare total double default 1;
        declare cont int default 1;
        repeat
			set total = total * cont;
            set cont =  cont + 1;
        until cont > numero end repeat;
        return total;
end; $$

select factorial(5);