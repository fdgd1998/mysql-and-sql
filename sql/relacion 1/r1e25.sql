delimiter $$
drop procedure if exists precio_descuento;
create procedure precio_descuento (precio int)
begin
	declare total int;
    declare unidades int default 1;
    repeat
		if (unidades between 1 and 14) then
			set total = precio * unidades;
            insert into precios values (unidades, total);
            set unidades = unidades + 1;
		else if (unidades between 15 and 29) then
				set total = (precio - (precio * 0.1)) * unidades;
				insert into precios values (unidades, total);
				set unidades = unidades + 1;
				else if (unidades between 30 and 49) then
					set total = (precio - (precio * 0.15)) * unidades;
					insert into precios values (unidades, total);
					set unidades = unidades + 1;
					else if (unidades between 50 and 100) then
						set total = (precio - (precio * 0.15)) * unidades;
						insert into precios values (unidades, total);
						set unidades = unidades + 1;
					end if;
				end if;
			end if;
        end if;
    until unidades > 100 end repeat;
    select * from precios;
end; $$

drop table precios;
create table precios (cantidad int primary key, precio int);
call precio_descuento (100);