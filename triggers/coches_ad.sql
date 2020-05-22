CREATE DEFINER = 'root'@'localhost' TRIGGER `coches_ad` AFTER DELETE ON `coches`
  FOR EACH ROW
BEGIN
	insert into log(usuario, notas, hora) values (current_user(), "Coche eliminado", now());
END;