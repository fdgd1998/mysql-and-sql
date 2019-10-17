delimiter $$
drop procedure if exists ECUACIONGRADO2;
create procedure ECUACIONGRADO2 (a int, b int, c int)
begin
    declare discriminante float;
    declare x1 float;
    declare x2 float;
    /*Si el discriminante es menor que cero, el resultado es un número complejo, entonces los valores se almacenarán en la tabla NOVALIDO.
    Si el discriminante es mayor que cero, el resultado es un número real, entonces se almacenan en la tabla RESULTADO.*/
	set discriminante = b*b - 4*a*c;
    if a != 0 then
		if discriminante >= 0 then
			set x1 = truncate((-b + sqrt(b*b - 4*a*c)) / (2*a), 2);
			set x2 = truncate((-b - sqrt(b*b - 4*a*c)) / (2*a), 2);
			insert into RES_REALES values (a, b, c, x1, x2);
		else insert into RES_COMPLEJOS values (a, b, c);
		end if;
	else insert into SIN_SOLUCION values (a, b, c);
    end if;
end;$$