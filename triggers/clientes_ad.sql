CREATE DEFINER = 'root'@'localhost' TRIGGER `clientes_ad` AFTER DELETE ON `clientes`
  FOR EACH ROW
BEGIN
	insert into log(usuario, notas, hora) values (current_user(), concat("Cliente eliminado: dni ", old.dni,", Nombre: ", old.nombre, " ,Apellidos: ", old.apellidos), now());
END;