delimiter $$
drop procedure if exists esMultiplo;
create procedure esMultiplo (numero1 int, numero2 int)
begin
	if numero2%numero1 = 0 then select concat(numero2,' es múltiplo de ',numero1) as "";
    else select concat(numero2,' no es múltiplo de ',numero1) as "";
    end if;
end; $$

call esMultiplo(2, 4);
call esMultiplo(4, 2);