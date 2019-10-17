delimiter $$
drop procedure sumapares;
create procedure sumapares (dividendo int, divisor int)
    begin
		declare resto int;
        declare cociente int;
        declare aux int default dividendo;
        declare cont int default 0;
        if divisor > dividendo then select "No se puede dividir" as "",dividendo as "","entre" as "",divisor as "";
        else
		while aux >= divisor do
			set aux = aux - divisor;
            set cont = cont + 1;
        end while;
        select dividendo as "dividendo", divisor as "divisor", cont as "cociente", aux as "resto";
		end if;
end; $$