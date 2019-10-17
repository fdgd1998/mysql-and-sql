delimiter $$
drop procedure if exists ejercicio1;
create procedure ejercicio1()
begin
	declare fin bool default 0;
	declare TMPcodigo int;
	declare buscar cursor for 
		select codigo
		from TRABAJADORES
        where cp = (select cp
					from APRENDICES
					where nombre = 'Ana' and apellidos = 'Gómez')
			  and sexo = 'M';
	declare continue handler for not found set fin = 1;
    open buscar;
		lectura:repeat
			fetch buscar into TMPcodigo;
            call buscarDatosNomina(TMPcodigo);
		until fin = 1 end repeat;
    close buscar;
end; $$