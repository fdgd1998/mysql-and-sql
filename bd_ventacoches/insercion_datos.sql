use ventacoches;

insert into MARCAS values 
	(1, 'SEAT', 'MADRID'),
    (2, 'RENAULT', 'BARCELONA'),
    (3, 'CITROEN', 'BARCELONA'),
    (4, 'AUDI', 'VALENCIA'),
    (5, 'OPEL', 'BILBAO'),
    (6, 'BMW', 'BARCELONA');

insert into CLIENTES values
	(1, 'luis', 'garcia', 'madrid'),
    (2, 'antonio', 'lopez', 'valencia'),
    (3, 'juan', 'martin', 'madrid'),
    (4, 'maria', 'garcia', 'madrid'),
    (5, 'javier', 'gonzalez', 'barcelona'),
    (6, 'ana', 'lopez', 'barcelona');
    
insert into COCHES values
	(1, 'Ibiza', 'GLX'),
    (2, 'Ibiza', 'GTI'),
    (3, 'Ibiza', 'GTD'),
    (4, 'Toledo', 'GTD'),
    (5, 'Cordoba', 'GTI'),
    (6, 'Megane', '1.6'),
    (7, 'Megane', 'GTI'),
    (8, 'Laguna', 'GTD'),
    (9, 'Laguna', 'GTI'),
    (10, 'ZX', '16V'),
    (11, 'ZX', 'TD'),
    (12, 'Xantia', 'GTD'),
    (13, 'A4', '1.8'),
    (14, 'A4', '2.8'),
    (15, 'Astra', 'Caravan'),
    (16, 'Astra', 'GTI'),
    (17, 'Corsa', '1.5'),
    (18, '300', '316.l'),
    (19, '500', '525l');
    
insert into CONCESIONARIO values
	(1, 'Acar', 'Madrid'),
    (2, 'Bcar', 'Madrid'),
    (3, 'Ccar', 'Barcelona'),
    (4, 'Dcar', 'Valencia'),
    (5, 'Ecar', 'Bilbao');

insert into MARCO values
	(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
    (2, 6), (2, 7), (2, 8), (2, 9), (3, 10),
    (3, 11), (3, 12), (4, 13), (4, 14), (5, 15), 
    (5,  16), (5, 17), (6, 18), (6, 19);
    
insert into DISTRIBUCION values
	(1, 1, 3), (1, 5, 7), (1, 6, 7),
    (2, 6, 5), (2, 8, 10), (2, 9, 10),
    (3, 10, 5), (3, 11, 3), (3, 12, 5),
    (4, 13, 10), (4, 14, 5), (5, 15, 10),
    (5, 16, 20), (5, 17, 8), (6, 19, 3);
    
insert into VENTAS values
	(1, 1, 1, 'Blanco'),
    (1, 2, 5, 'Rojo'),
    (2, 3, 8, 'Blanco'),
    (2, 1, 6, 'Rojo'),
    (3, 4, 11, 'Rojo'),
    (4, 5, 14, 'Verde');