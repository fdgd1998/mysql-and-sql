drop procedure if exists control_armas;

delimiter $$
create procedure control_armas (codarma int, nombre longtext, codcaz int)
	begin
		declare duplicated_key bool default 0;
        declare continue handler for 1062 set duplicated_key = 1;
        insert into ARMAS values (codarma, nombre, codcaz);
        if duplicated_key = 1 then select 'Clave duplicada' as 'Error';
        else select * from ARMAS;
        end if;
end; $$