delimiter $$
drop function exponente;
create function exponente (b int, e int)
	returns int
begin
	declare resultado int;
    declare aux int;
    declare cont int default 0;
	while cont < e do
		set cont = cont + 1;
        set resultado = b * cont;
    end while;
    return resultado;
end; $$

select exponente (2,2);