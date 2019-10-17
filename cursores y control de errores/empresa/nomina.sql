delimiter $$
drop function if exists NOMINA;
create function NOMINA (categoria char, sb int, hijos int)
	returns float
	begin
        declare sueldo_neto float;
        declare retencion float;
        declare bonus int;
		if categoria = 'A' then set retencion = 0.2;
			else if categoria = 'B' then set retencion = 0.15;
				else if categoria = 'C' then set retencion = 0.1;
                end if;
			end if;
		end if;
        set bonus = 500 * hijos;
        set sueldo_neto = sb - (sb * retencion) + bonus;
        return sueldo_neto;
end; $$