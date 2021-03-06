CREATE TABLE `log` (
  `id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(20) COLLATE latin1_swedish_ci NOT NULL DEFAULT 'null',
  `notas` VARCHAR(20) COLLATE latin1_swedish_ci DEFAULT 'null',
  `hora` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY USING BTREE (`id`)
) ENGINE=InnoDB
AUTO_INCREMENT=1 ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

CREATE DEFINER = 'root'@'localhost' TRIGGER `clientes_au` AFTER UPDATE ON `log`
  FOR EACH ROW
BEGIN
	insert into log values (current_user(), "cliente actualizado", NOW());	
END;