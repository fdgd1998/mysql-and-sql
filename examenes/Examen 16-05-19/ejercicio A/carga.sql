drop procedure if exists CARGA;
delimiter $$
create procedure CARGA ()
	begin
	insert into VARIABLES1 values
		(1, 23, 56, 34),
		(2, 56, 7, 2),
		(3, 6, 2, 45),
		(4, 45, 7, 8),
		(5, 45, 23, 8);
    insert into CIENTIFICOS values
		(123456789, 'Manuel Gómez', 'H', 29620),
        (908765432, 'Ana Pérez', 'M', 29620),
        (387235098, 'Paula García', 'M', 29620),
        (423469756, 'Antonio', 'H', 29622),
        (598237547, 'Javier', 'H', 29620);
	insert into INVESTIGACION values
		(12345, 12, 2, 1500, 1, 387235098),
        (45677, 1, 34, 5000, 2, 123456789),
        (56783, 3, 4, 5560, 3, 423469756),
        (87345, 5, 20, 2500, 4, 598237547),
        (45666, 5, 5, 3550, 5, 908765432);
end; $$
