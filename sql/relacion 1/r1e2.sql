delimiter $$
drop function esNegativo;
create function esNegativo (num int)
returns int
begin
	declare negativo bool;
	if num < 0 then set negativo = true;
	else set negativo = false;
	end if;
    if num = 0 then set negativo = false;
    end if;
	return negativo;
end; $$

/*Se devolverá '0' si el valor es negativo, 
y '1' si es positivo.*/
select esNegativo (7);
select esNegativo (-3);