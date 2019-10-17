delimiter $$
drop procedure if exists insertarResultados;
create procedure insertarResultados (sn float)
begin
	declare TMPtnombre char;
    declare TMPtapellidos char;
    declare TMPanombre char;
    declare TMPaapellidos char;
    declare fin bool default 0;
    declare busqueda cursor for 
		select APRENDICES.nombre, APRENDICES.apellidos, TRABAJADORES.nombre, TRABAJADORES.apellidos
        from TRABAJADORES, APRENDICES
        where TRABAJADORES.cp = APRENDICES.cp;
	declare continue handler for not found set fin = 1;
    open busqueda;
		fetch busqueda into TMPtnombre, TMPtapellidos, TMPanombre, TMPaapellidos;
		insert into RESULTADOS values (TMPtnombre, TMPtapellidos, sn, TMPanombre, TMPaapellidos);
	close busqueda;
end; $$