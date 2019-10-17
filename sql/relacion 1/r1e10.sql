/*Esta función calcula la suma de todos los números comprendidos
entre dos números introducidos por teclado, ambos inclusive*/
delimiter $$
drop function sumarTodos;
create function sumarTodos (minimo int, maximo int)
	returns int
	begin
		declare numero int default maximo;
        declare suma int default 0;
		while numero >= maximo do
			set suma = suma + numero;
            set numero = maximo - 1;
		end while;
        return suma;
end; $$

select sumarTodos(2,10);
