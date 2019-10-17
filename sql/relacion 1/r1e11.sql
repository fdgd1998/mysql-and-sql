delimiter $$
drop procedure if exists esImpar;
create procedure esImpar (num int)
begin
	if mod(num, 2) != 0 then select 'El número es impar' as "";
	else select 'El número es par' as "";
	end if;
end; $$

call esImpar(9);