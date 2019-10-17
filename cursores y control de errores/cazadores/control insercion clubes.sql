drop procedure if exists control_clubes;

delimiter $$
create procedure control_clubes (codclub int, nombre longtext)
	begin
		declare duplicated_key bool default 0;
        declare continue handler for 1062 set duplicated_key = 1;
        insert into CLUB values (codclub, nombre);
        if duplicated_key = 1 then select 'Clave duplicada' as 'Error';
        else select * from CLUB;
        end if;
end; $$