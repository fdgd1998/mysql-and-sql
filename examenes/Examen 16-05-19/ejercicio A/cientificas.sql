drop procedure if exists cientificas;

delimiter $$
create procedure cientificas ()
	begin
    declare fin int default 0;
    declare var_nombre longtext;
    declare var_r1 int;
    declare var_r2 int;
    declare var_a int;
    declare var_b int;
    declare var_c int;
    declare var_formula float;
    declare var_codinv int;
    declare var_cp int;
    declare var_costeinves float;
    declare buscar cursor for
		select CIENTIFICOS.nombre, CIENTIFICOS.cp, INVESTIGACION.codinv, VARIABLES1.a, VARIABLES1.b, VARIABLES1.c, INVESTIGACION.R1, INVESTIGACION.R2, INVESTIGACION.costeinves
        from CIENTIFICOS inner join INVESTIGACION on CIENTIFICOS.dnicien = INVESTIGACION.dnicien
						 inner join VARIABLES1 on INVESTIGACION.codvar = VARIABLES1.codvar
		where CIENTIFICOS.sexo = 'M';
	declare continue handler for not found set fin = 1;
    open buscar;
		repeat
			fetch buscar into var_nombre, var_cp, var_codinv, var_a, var_b, var_c, var_r1, var_r2, var_costeinves;
            if var_costeinves between 1000 and 2500 then 
				insert into RESULTADO values (var_codinv, var_nombre, var_cp, FORMULA(var_c, var_b, var_c, var_r1, var_r2), var_a, var_b, var_c, var_r1, var_r2);
			end if;
        until fin = 1 end repeat;
	close buscar;
end; $$