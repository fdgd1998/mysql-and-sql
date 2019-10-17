drop procedure if exists borrado_piezas;

delimiter $$
create procedure borrado_piezas (var_codpieza int)
	begin
		declare unknown_key int default 0;
        declare continue handler for 1054 set unknown_key = 1;
        delete from PIEZAS where codpieza = var_codpieza;
        if unknown_key = 1 then select 'Clave primaria desconocida' as 'Error';
        else select * from PIEZAS;
        end if;
end; $$