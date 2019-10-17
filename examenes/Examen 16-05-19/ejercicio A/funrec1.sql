drop function FUNREC1;
delimiter $$
create function FUNREC1 (a int, b int, c int, R2 int, R1 int)
	returns float
    begin
		declare resultado float;
        set resultado = sqrt((3*(b*b)+c)/FUNREC2(a, c, R2))*R1;
        return resultado;
end; $$