delimiter $$
drop procedure restaSucesivas;
create procedure restaSucesivas (dividendo int, divisor int)
    begin
		declare resto int;
        declare cociente int;
        declare aux int default dividendo;
        declare cont int default 0;
		while aux >= divisor do
			set aux = aux - divisor;
            set cont = cont + 1;
        end while;
        select 'El cociente es',cont, 'El resto es',aux;
end; $$

call restaSucesivas (20, 2);