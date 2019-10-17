drop function if exists dto23;
delimiter $$
create function dto23 (cuota float)
	returns float
    begin
		declare resultado float;
        declare dto float default 0.23;
        declare total_dto float;
        set total_dto = cuota * 0.23;
        set resultado = cuota - total_dto;
		return resultado;
end; $$