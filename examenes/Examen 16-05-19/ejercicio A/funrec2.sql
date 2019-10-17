drop function if exists FUNREC2;
delimiter $$
create function FUNREC2 (a int, c int, R2 int)
	returns float
    begin
		declare resultado float;
        set resultado = 3*a*c + R2;
        return resultado;
end; $$