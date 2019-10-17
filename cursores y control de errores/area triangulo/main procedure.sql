delimiter $$ 
drop procedure if exists calcularAreaTriangulo;
create procedure calcularAreaTriangulo ()
begin
	declare TMPb int; /*Base*/
    declare TMPh int; /*Altura*/
    declare TMPRes float; /*Resultado. es float porque el resultado de la división
							puede contener decimales.*/
	declare fin bool default 0;
    declare area cursor for
		select base, altura
        from incognitas;
	declare continue handler for not found set fin = 1;
    open area;
		calcular:repeat
			fetch area into TMPb, TMPh;
            set TMPRes = areaTriangulo (TMPb, TMPh);
            insert into resultados values (TMPb, TMPh, TMPRes); 
        until fin = 1 end repeat;
	 close area;
end; $$