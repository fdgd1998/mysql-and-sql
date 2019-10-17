delimiter $$
drop procedure if exists estaComprendido1y10;
create procedure estaComprendido1y10 (num int)
begin
	if num between 1 and 10 then select concat(num,' está comprendido entre 1 y 10.') as "";
    else select concat('ERROR: ',num,' no está dentro del rango.') as "";
	end if;
end; $$

call estaComprendido1y10 (11);
call estaComprendido1y10 (3);