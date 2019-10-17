delimiter $$
/*Cálculo del número PI con la serie de Leibniz*/
create procedure calcularPI ()
begin
    declare salto bool default 1;
    declare TMPimpar int;
    declare pi float default 4;
    declare pi_cursor cursor for select impar from IMPARES;
    open pi_cursor;
    calcular:loop
		fetch pi_cursor into TMPimpar;
        if salto = 1 then 
			set pi = pi - (4/TMPimpar);
            set salto = 0;
        else 
			set pi = pi + (4/TMPimpar);
            set salto = 1;
		end if;
        if TMPimpar = (select max(impar) from IMPARES) then 
			select pi;
			leave calcular;
        end if;
    end loop;
    close pi_cursor;
end; $$