insert into CLIENTES values
	(1234567, 'Laura', 'Gonzalez', 'Andalucía, 8', 29622, 30),
	(0987654, 'Miguel', 'Gálvez', 'Costa del Sol, 10', 29624, 32),
	(1357901, 'Juan', 'Ruiz', 'San Juan, 2', 29621, 39),
	(7890456, 'Juan', 'Zapata', 'San Juan, 2', 29621, 25),
	(1234678, 'Andrea', 'Zapatero', 'San Juan, 2', 29621, 30),
	(2345678, 'Rocío', 'López', 'Álamos, 12', 29621, 36),
	(0864219, 'Fermín', 'Díaz', 'Álamos, 13', 29621, 33);
	
insert into ZAPATERIAS values
	(5, 'La Alpargata', 29621, 'Río, 24'),
	(6, 'Corazón de Piel', 29622, 'Camino de Málaga, 1'),
	(7, 'El Ruiseñor', 29622, 'Del Río, 9'),
	(8, 'El Candil', 29622, 'Costa del Sol, 10'),
	(9, 'Rocío', 29621, 'Nueva, 9');
	
insert into ZAPATOS values
	(34, 'Botas', 70, 'Si', 2, 5),
	(65, 'Tacones', 150, 'Si', 2, 6), 
	(56, 'Botines', 200, 'Si', 3, 8),
	(87, 'Zapatos de cuero', 200, 'Si', 3, 7),
	(99, 'Zapatos militares', 200, 'Si', 3, 7),
	(78, 'Zapatos', 50, 'No', 2, 9);
	
insert into TALLER values
	(1, 'Pepe Montes', 'Andalucía, 8', 29622),
	(2, 'Complementos', 'San Miguel, 3', 29624),
	(3, 'Talleres Juan', 'Nueva, 9', 29621);
	
insert into COLOR values
	(2, 'Rojo'),
	(3, 'Azul');

insert into VENTAS values
	(34, 1234567, '2006-10-02', 70, 0),
	(65, 1234567, '2005-10-02', 150, 0),
	(56, 0987654, '2007-10-05', 200, 20),
	(87, 0987654, '2006-12-12', 200, 20),
	(99, 0987654, '2005-10-25', 200, 20),
	(78, 0864219, '2006-12-22', 50, 0);
	
insert into FICHAZAPATO values
	(78, 'Deportivas', 'Caucho', '2006-09-23', 0);