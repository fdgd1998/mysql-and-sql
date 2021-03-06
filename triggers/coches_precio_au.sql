CREATE DEFINER = 'root'@'localhost' TRIGGER `coches_precio_au` AFTER UPDATE ON `coches`
  FOR EACH ROW
BEGIN
	declare str varchar(255) default "";
    declare total int(9);
    if old.codcoche != new.codcoche then
    	set str = concat(old.codcoche, ' -> ', new.codcoche);
    end if;
    if old.nombre != new.nombre then
    	set str = concat(old.nombre, ' -> ', new.nombre);
    end if;
    if old.modelo != new.modelo then
    	set str = concat(old.modelo, ' -> ', new.modelo);
    end if;
    if old.precio != new.precio then
    	set str = concat(old.precio, ' -> ', new.precio);
    end if;
    set total = (select sum(precio) from coches);
    set str = concat(str, "Coche actualizado (",str, ")",", total: ", total);
	insert into log (usuario, notas, hora) values (CURRENT_USER(), str, now());
END;