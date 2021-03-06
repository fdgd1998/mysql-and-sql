CREATE DEFINER = 'root'@'localhost' TRIGGER `coches_precio_ai` AFTER INSERT ON `coches`
  FOR EACH ROW
BEGIN
	declare str varchar(255);
    declare total int(9);
    set total = (select sum(precio) from coches);
    set str = concat("Coche insertado (",new.nombre,", ", new.modelo,", ", new.precio, ")",", total: ", total);
	insert into log (usuario, notas, hora) values (CURRENT_USER(), str, now());
END;