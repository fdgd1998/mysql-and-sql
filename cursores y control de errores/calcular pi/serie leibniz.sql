delimiter $$
create function leibnizPI (impar int, maximpar int)
	returns float
	begin
        declare suma float;
        while impar < maximpar do
			set suma = suma - (4/impar);
            set suma = suma + (4/impar);
            if impar > maximpar then leave pi;
            end if;
        end while;
        return suma;
end; $$