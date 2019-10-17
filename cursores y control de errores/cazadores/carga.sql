drop procedure if exists carga;

delimiter $$
create procedure carga ()
	begin
    insert into CLUB values
		(12, 'El Coto'),
        (34, 'Don Cazador');
    insert into PIEZAS values 
		(1, 'Antílope', 'Rayado',  1.85, 35.41, 'Hembra'),
        (2, 'Venado', 'Albino', 2.14, 78.45, 'Macho'),
        (3, 'Mono', 'Babuino', 1.35, 25.78, 'Macho');
	insert into CAZADORES values
		(1, 'Pepa', 'Ramírez', 34, 'Mujer', 2400, 23),
        (2, 'Antonio', 'Gómez', 34, 'Hombre', 2000, 45),
        (3, 'Claudia', 'Jiménez', 34, 'Mujer', 1980, 37),
        (4, 'Manuel', 'García', 12, 'Hombre', 1500, 56);
	insert into ARMAS values
		(23, 'Winchester x-24', 1),
        (45, 'Rifle 3a2', 2),
        (37, 'Franco 78', 3),
        (56, 'Escopeta doble cañón', 4);
	insert into CAZA values
		(23, 1, 'Oeste', '2019-03-25'),
        (45, 2, 'Sur', '2018-09-04'),
        (56, 3, 'Norte', '2017-12-12');
end; $$