delimiter $$
drop procedure if exists CARGA;
create procedure CARGA()
begin
	insert into APRENDICES values
		(1, 'Ana', 'Gómez', 'M', 28, 29620),
        (2, 'Luisa', 'Rupérez', 'M', 75, 29620),
        (3, 'Andrés', 'Sánchez', 'V', 32, 29321),
        (4, 'Carmen', 'Sánchez', 'M', 91, 29382);
	insert into TRABAJADORES values
		(1, 'Ana', 'López', 'M', 30, 29620, 1),
        (2, 'Luisa', 'Carmona', 'M', 25, 29620, 2),
        (3, 'Carlos', 'Gómez', 'V', 52, 29620, 7),
        (4, 'Óscar', 'Rupérez', 'V', 22, 29621, 0),
        (5, 'Vicky', 'Montes', 'M', 20, 29630, 4);
	insert into SUELDO values
		(1, 70000, 'A'),
        (2, 120000, 'A');
end; $$