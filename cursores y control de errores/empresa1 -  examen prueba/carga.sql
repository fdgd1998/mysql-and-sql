delimiter $$
create procedure carga ()
begin
	insert into CLIENTES values
		(1, 'Pepe', 'Moreno', 'H', 2800),
		(2, 'Ana', 'Ruíz', 'M', 2500),
		(3, 'Felipe', 'López', 'H', 3500),
		(4, 'Eva', 'Castaño', 'M', 1700),
		(5, 'Victoria', 'Díaz', 'M', 1800),
        (6, 'Manuel', 'Gómez', 'H', 2900);
end; $$