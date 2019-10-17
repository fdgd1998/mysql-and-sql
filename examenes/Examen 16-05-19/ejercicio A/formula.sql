drop function if exists FORMULA;
delimiter $$
create function FORMULA (a int, b int, c int, r1 int, r2 int)
	returns float
    begin
		declare n int default 1;
        declare resultado float default 0;
        repeat
			set resultado = resultado + ((a*b + 3*n)/2)*FUNREC1(a, b, c, r1, r2);
            set n = n + 1;
		until n > 10 end repeat;
        return resultado;
end; $$