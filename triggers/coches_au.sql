CREATE DEFINER = 'root'@'localhost' TRIGGER `coches_au` AFTER UPDATE ON `coches`
  FOR EACH ROW
BEGIN
	declare str VARCHAR(255) default '';
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
	insert into log(usuario, notas, hora) values (current_user(), concat('Coche actualizado: ', str), now());
END;