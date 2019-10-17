delimiter $$
drop procedure if exists repetirFrase;
create procedure repetirFrase (frase char(100), numero int)
begin
	declare cont int default 0;
	while cont < numero do
		select frase;
        set cont = cont + 1;
	end while;
end; $$

call repetirFrase ('hola', 2);