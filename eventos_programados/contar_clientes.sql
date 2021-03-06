CREATE DEFINER = 'root'@'localhost' EVENT `contar_clientes`
  ON SCHEDULE EVERY 5 MINUTE STARTS '2020-02-03 21:53:38'
  ON COMPLETION PRESERVE
  ENABLE
  COMMENT ''  DO
BEGIN
	declare total int(3) default 0;
	set total = (select COUNT(id) from clientes);
	insert into log (usuario, notas, hora) values (current_user(), CONCAT("Total de clientes: ", total),now());
END;