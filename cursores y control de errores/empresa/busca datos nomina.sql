delimiter $$
drop function if exists buscarDatosNomina;
create procedure buscarDatosNomina (tcodigo int)
	begin
		declare fin bool default 0;
		declare TMPcat char;
		declare TMPsb int;
        declare TMPscodigo int;
        declare TMPhijos int;
        declare sn float;
        declare datos_nomina cursor for
			select sueldo_bruto, categoria, hijos
			from SUELDO inner join TRABAJADORES on SUELDO.codigo = TRABAJADORES.codigo
			where TRABAJADORES.codigo = SUELDO.codigo;
		declare continue handler for not found set fin = 1;
        open datos_nomina;
			fetch datos_nomina into TMPsb, TMPcat, TMPhijos;
			calcular:repeat
				set sn = nomina(TMPcat, TMPsb, TMPhijos);
                call insertarDatos(sn)
            until fin = 1 end repeat;
        close datos_nomina;
end; $$