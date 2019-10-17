delimiter $$
drop procedure if exists notas;
create procedure notas (n float)
begin
    case
		when n > 0 and n < 5 then select concat('Insuficiente: ',n) as "";
        when n >= 5 and n < 6 then select concat('Bien: ',n) as "";
        when n >= 6 and n < 9 then select concat('Notable: ',n) as "";
        when n >= 9 and n < 10 then select concat('Sobresaliente: ',n) as "";
        else select 'Intoduce una nota entre 0 y 10';
	end case;
end;$$

call notas(5.0);
call notas(9.0);