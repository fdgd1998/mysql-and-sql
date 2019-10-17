drop procedure if exists existePadre;
delimiter $$
create procedure existePadre (dni int, nombre char, apellidos char)
begin
	declare duplicate_key int default 0;
    declare continue handler for 1062 set duplicate_key=1;
	insert into PADRES values (dni, nombre, apellidos);
    if duplicate_key=1 then select 'Clave primaria duplicada' as 'Error';
	else select * from PADRES;
	end if;
end; $$