delimiter $$
drop procedure if exists esMayor;
create procedure esMayor (n1 int, n2 int, n3 int)
begin
	if (n1>n2 and n1>n3) then select concat('El número más grande es ',n1) as "";
		else if (n2>n3) then select concat('El número más grande es ',n2) as "";
		else select concat('El número más grande es ',n3) as "";
		end if;
    end if;
end; $$

call esMayor (8, 9, 10);