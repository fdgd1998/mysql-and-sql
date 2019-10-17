drop procedure if exists control_piezas;

delimiter $$
create procedure control_piezas (codpieza int, raza longtext, especie longtext, altura float, peso float, sexo longtext)
	begin
		declare duplicated_key bool default 0;
        declare continue handler for 1062 set duplicated_key = 1;
        insert into PIEZAS values (codpieza, raza, especie, altura, peso, sexo);
        if duplicated_key = 1 then select 'Clave duplicada' as 'Error';
        else select * from PIEZAS;
        end if;
end; $$