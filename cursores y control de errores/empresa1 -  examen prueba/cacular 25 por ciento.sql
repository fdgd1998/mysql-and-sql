drop function if exists calcular25;
delimiter $$
create function calcular25 (sueldo int)
	returns float
	begin
		declare resultado float;
        set resultado = sueldo + (sueldo * 0.25);
		return resultado;
end; $$