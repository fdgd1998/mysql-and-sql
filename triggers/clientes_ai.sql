CREATE DEFINER = 'root'@'localhost' TRIGGER `clientes_ai` AFTER INSERT ON `clientes`
  FOR EACH ROW
BEGIN
	insert into log (usuario, notas, hora) values (current_user(), "Cliente insertado", now());
END;