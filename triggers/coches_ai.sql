CREATE DEFINER = 'root'@'localhost' TRIGGER `coches_ai` AFTER INSERT ON `coches`
  FOR EACH ROW
BEGIN
	insert into log (usuario, notas, hora) values (current_user(), "Coche insertado", now());
END;