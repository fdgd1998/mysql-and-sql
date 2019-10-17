drop procedure if exists control_cazadores;

delimiter $$
create procedure control_cazadores (codcaz int, nombre longtext, apellidos longtext, codclub int, sexo longtext, cuota float, codarma int)
	begin
		declare duplicated_key bool default 0;
        declare continue handler for 1062 set duplicated_key = 1;
        insert into CAZADORES values (codcaz, nombre, apellidos, codclub, sexo, cuota, codarma);
        if duplicated_key = 1 then select 'Clave duplicada' as 'Error';
        else select * from CAZADORES;
        end if;
end; $$