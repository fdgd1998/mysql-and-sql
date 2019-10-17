drop procedure if exists info_piezas_cazadas;

delimiter $$
create procedure info_piezas_cazadas ()
	begin
    select CAZADORES.nombre, CAZADORES.apellidos, PIEZAS.raza, PIEZAS.especie, PIEZAS.altura, PIEZAS.peso, CAZA.zona, CAZA.fecha, ARMAS.nombre
    from CAZADORES inner join ARMAS on CAZADORES.codarma = ARMAS.codarma
				   inner join CAZA on ARMAS.codarma = CAZA.codarma
                   inner join PIEZAS on CAZA.codpieza = PIEZAS.codpieza;
end; $$