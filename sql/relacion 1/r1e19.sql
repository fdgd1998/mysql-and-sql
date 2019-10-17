delimiter $$
drop procedure if exists productoSumas;
create procedure productoSumas (factor1 int, factor2 int)
    begin
		declare resultado int;
        declare cont int default 0;
		while cont <= factor2 do
			set resultado = factor1 + factor1;
            set cont = cont + 1;
        end while;
        select factor1,' mutiplicado por ',factor2,' es ',resultado;
end; $$

call productoSumas (10, 34);