delimiter $$
create procedure separarPorSexo ()
begin
	declare fin bool default 0;
	declare var_codigo int;
	declare var_nombre longtext;
    declare var_apellidos longtext;
    declare var_sueldo int;
    declare var_sexo char;
    declare separar cursor for
		select cod, nombre, apellidos, sueldo, sexo
        from CLIENTES;
	declare continue handler for not found set fin = 1;
    open separar;
		repeat
			fetch separar into var_codigo, var_nombre, var_apellidos, var_sueldo, var_sexo;
			if var_sexo = 'H' then insert into HOMBRES values (var_codigo, var_nombre, var_apellidos, var_sueldo);
			else insert into MUJERES values (var_codigo, var_nombre, var_apellidos, var_sueldo);
			end if;
        until fin = 1 end repeat;
    close separar;
end; $$