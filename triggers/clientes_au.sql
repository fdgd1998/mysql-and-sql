CREATE DEFINER = 'root'@'localhost' TRIGGER `clientes_au` AFTER UPDATE ON `clientes`
  FOR EACH ROW
BEGIN
	declare str VARCHAR(255) default '';
	if old.dni != new.dni then
    	set str = concat(old.dni, ' -> ', new.dni);
    end if;
    if old.nombre != new.nombre then
    	set str = concat(old.nombre, ' -> ', new.nombre);
    end if;
    if old.apellidos != new.apellidos then
    	set str = concat(old.apellidos, ' -> ', new.apellidos);
    end if;
    if old.ciudad != new.ciudad then
    	set str = concat(old.ciudad, ' -> ', new.ciudad);
    end if;
	insert into log(usuario, notas, hora) values (current_user(), concat('Cliente actualizado: ', str), now());
END;