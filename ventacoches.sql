/* SQL Manager Lite for MySQL                              5.8.0.53447 */
/* ------------------------------------------------------------------- */
/* Host     : localhost                                                */
/* Port     : 3306                                                     */
/* Database : ventacoches                                              */


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES 'utf8mb4' */;

SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `ventacoches`;

CREATE DATABASE `ventacoches`
    CHARACTER SET 'utf8mb4'
    COLLATE 'utf8mb4_general_ci';

USE `ventacoches`;

/* Dropping database objects */

DROP TRIGGER IF EXISTS `coches_precio_ad`;
DROP TRIGGER IF EXISTS `coches_ad`;
DROP TRIGGER IF EXISTS `coches_precio_au`;
DROP TRIGGER IF EXISTS `coches_au`;
DROP TRIGGER IF EXISTS `coches_precio_ai`;
DROP TRIGGER IF EXISTS `coches_ai`;
DROP TRIGGER IF EXISTS `clientes_ad`;
DROP TRIGGER IF EXISTS `clientes_au`;
DROP TRIGGER IF EXISTS `clientes_ai`;
DROP EVENT IF EXISTS `recuento_coches`;
DROP EVENT IF EXISTS `contar_clientes`;
DROP EVENT IF EXISTS `borrar_log_1mes`;
DROP PROCEDURE IF EXISTS `new_proc1`;
DROP PROCEDURE IF EXISTS `nacional_extranjero`;
DROP PROCEDURE IF EXISTS `mostrar_coches_concesionario`;
DROP PROCEDURE IF EXISTS `hoy`;
DROP PROCEDURE IF EXISTS `diesel_gasolina_marca`;
DROP PROCEDURE IF EXISTS `diesel_gasolina`;
DROP PROCEDURE IF EXISTS `anadir_precio`;
DROP PROCEDURE IF EXISTS `2.insertar_cinco_madrid`;
DROP TABLE IF EXISTS `ventas`;
DROP TABLE IF EXISTS `marco`;
DROP TABLE IF EXISTS `marcas`;
DROP TABLE IF EXISTS `log`;
DROP TABLE IF EXISTS `distribucion`;
DROP TABLE IF EXISTS `concesionario`;
DROP TABLE IF EXISTS `coches`;
DROP TABLE IF EXISTS `clientes`;

/* Structure for the `clientes` table : */

CREATE TABLE `clientes` (
  `dni` INTEGER(9) NOT NULL,
  `nombre` CHAR(20) COLLATE utf8mb4_general_ci NOT NULL,
  `apellidos` CHAR(30) COLLATE utf8mb4_general_ci NOT NULL,
  `ciudad` CHAR(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`dni`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci'
;

/* Structure for the `coches` table : */

CREATE TABLE `coches` (
  `codcoche` INTEGER(9) NOT NULL AUTO_INCREMENT,
  `nombre` CHAR(20) COLLATE utf8mb4_general_ci NOT NULL,
  `modelo` CHAR(20) COLLATE utf8mb4_general_ci NOT NULL,
  `precio` INTEGER(9) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`codcoche`)
) ENGINE=InnoDB
AUTO_INCREMENT=95 ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci'
;

/* Structure for the `concesionario` table : */

CREATE TABLE `concesionario` (
  `cifc` INTEGER(9) NOT NULL,
  `nombre` CHAR(20) COLLATE utf8mb4_general_ci NOT NULL,
  `ciudad` CHAR(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`cifc`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci'
;

/* Structure for the `distribucion` table : */

CREATE TABLE `distribucion` (
  `cifc` INTEGER(9) NOT NULL,
  `codcoche` INTEGER(9) NOT NULL,
  `cantidad` INTEGER(2) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`cifc`, `codcoche`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci'
;

/* Structure for the `log` table : */

CREATE TABLE `log` (
  `id` INTEGER(3) NOT NULL AUTO_INCREMENT,
  `usuario` CHAR(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `notas` VARCHAR(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `hora` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY USING BTREE (`id`)
) ENGINE=InnoDB
AUTO_INCREMENT=221 ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci'
;

/* Structure for the `marcas` table : */

CREATE TABLE `marcas` (
  `cifm` CHAR(20) COLLATE utf8mb4_general_ci NOT NULL,
  `nombre` CHAR(20) COLLATE utf8mb4_general_ci NOT NULL,
  `ciudad` CHAR(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`cifm`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci'
;

/* Structure for the `marco` table : */

CREATE TABLE `marco` (
  `cifm` INTEGER(9) NOT NULL,
  `codcoche` INTEGER(9) NOT NULL,
  PRIMARY KEY USING BTREE (`cifm`, `codcoche`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci'
;

/* Structure for the `ventas` table : */

CREATE TABLE `ventas` (
  `cifc` INTEGER(9) NOT NULL,
  `dni` INTEGER(9) NOT NULL,
  `codcoche` INTEGER(9) NOT NULL,
  `color` CHAR(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`cifc`, `dni`, `codcoche`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci'
;

/* Definition for the `2.insertar_cinco_madrid` procedure : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `2.insertar_cinco_madrid`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	declare vnombre char(20) default "";
    declare vmodelo char(20) default "";
    declare vprecio int(9) default 0;
    declare cont int(1) default 0;
    declare insertar cursor for
    	select coches.nombre, modelo, precio
        from coches inner join distribucion using(codcoche)
        		    inner join concesionario using(cifc)
        where concesionario.ciudad = "Madrid"
        limit 1;
    declare exit handler for not found
    begin
    end;
    open insertar;
    	bucle: loop
        	fetch insertar into vnombre, vmodelo, vprecio;
            while cont < 5 do
            	insert into coches(nombre, modelo, precio) values (vnombre, vmodelo, vprecio);
                set cont = cont + 1;
            end while;
            set cont = 0;
        end loop bucle;
    close insertar;
END$$

DELIMITER ;

/* Definition for the `anadir_precio` procedure : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `anadir_precio`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	alter table coches add column precio int(9);
END$$

DELIMITER ;

/* Definition for the `diesel_gasolina` procedure : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `diesel_gasolina`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	declare vnombre char(20);
    declare vmodelo char(20);
    declare tipo char(20);
    declare cursor_tipo cursor for select nombre, modelo from coches;
    declare exit handler for not found
    begin
    end;
    open cursor_tipo;
    	bucle: loop
        	fetch cursor_tipo into vnombre, vmodelo;
        	if vmodelo in("GT", "GTD") then
            	set tipo = "Diesel";
            else
            	set tipo = "Gasolina";
            end if;
            select vnombre, vmodelo, tipo;
        end loop bucle;
    close cursor_tipo;
END$$

DELIMITER ;

/* Definition for the `diesel_gasolina_marca` procedure : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `diesel_gasolina_marca`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	declare vnombre char(20);
    declare vmodelo char(20);
    declare tipo char(20);
    declare cursor_tipo cursor for select coches.nombre, modelo
								   from coches inner join marco using(codcoche)
                                   			   inner join marcas using(cifm)
                                   where vmarca = marcas.nombre;
    declare exit handler for not found
    begin
    end;
    open cursor_tipo;
    	loop
        fetch cursor_tipo into vnombre, vmodelo;
        	if vmodelo in("GT", "GTD") then
            	set tipo = "Diesel";
            else
            	set tipo = "Gasolina";
            end if;
            select vnombre, vmodelo, tipo;
        end loop;
    close cursor_tipo;
END$$

DELIMITER ;

/* Definition for the `hoy` procedure : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `hoy`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	set lc_time_names = "es_ES";
	select date_format(now(), "Hoy es %W, %d de %M de %Y");
END$$

DELIMITER ;

/* Definition for the `mostrar_coches_concesionario` procedure : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `mostrar_coches_concesionario`(
        IN `cod` INTEGER(9)
    )
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	select count(coches.codcoche)
    from coches inner join distribucion using(codcoche)
     		    inner join concesionario using(cifc)
    where cifc = cod;
END$$

DELIMITER ;

/* Definition for the `nacional_extranjero` procedure : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `nacional_extranjero`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	declare vmarca char(20);
	declare vnombre char(20);
    declare vapellidos char(30);
    declare vnombrec char(20);
    declare vmodelo char(20);
    declare nacionalidad char(20);
    declare nacional cursor for
    	select marcas.nombre, clientes.nombre, apellidos, coches.nombre, modelo
        from clientes inner join ventas using(dni)
    				  inner join coches using(codcoche)
                      inner join marco using(codcoche)
                      inner join marcas using(cifm);
    declare exit handler for not found
    begin
    end;
    open nacional;
    	loop
        	fetch nacional into vmarca, vnombre, vapellidos, vnombrec, vmodelo;
            if vmarca = "SEAT" then
            	set nacionalidad = "Nacional";
            else 
            	set nacionalidad = "Extranjero";
            end if;
            select concat("Nombre: ", vnombre, ", Apellidos: ",vapellidos, ", Nombre coche: ",vnombrec, ", modelo: ",vmodelo, ", nacionalidad: ",nacionalidad);
        end loop;
    close nacional;
END$$

DELIMITER ;

/* Definition for the `new_proc1` procedure : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' PROCEDURE `new_proc1`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	declare vcifc int(9) default 0;
    declare vconteo int(9) default 0;
    declare str varchar(100) default "";
    declare salir int default 0;
    declare contar cursor
    	for select cifc, sum(cantidad) from distribucion group by cifc;
    declare exit handler for not found set salir=1;
    open contar;
    loop
    	fetch contar into vcifc, vconteo;
        set str = concat(str, "El concesionario ", vcifc, " tiene ", vconteo, " coches. ");
    end loop;
    close contar;
    select str;
    insert into log (usuario, notas, hora) values (current_user(), str, now());
END$$

DELIMITER ;

/* Definition for the `borrar_log_1mes` event : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' EVENT `borrar_log_1mes`
  ON SCHEDULE EVERY 1 DAY STARTS '2020-02-03 10:00:00'
  ON COMPLETION PRESERVE
  ENABLE
  COMMENT ''  DO
BEGIN
	delete from log where id < date_sub(now(), interval 30 DAY);
END$$

DELIMITER ;

/* Definition for the `contar_clientes` event : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' EVENT `contar_clientes`
  ON SCHEDULE EVERY 5 SECOND STARTS '2020-02-04 10:35:00'
  ON COMPLETION PRESERVE
  DISABLE
  COMMENT ''  DO
BEGIN
	declare total int(9) default 0;
	set total = (select count(dni) from clientes);
	insert into log (usuario, notas, hora) values (current_user(), CONCAT("Total de clientes: ", total),now());
END$$

DELIMITER ;

/* Definition for the `recuento_coches` event : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' EVENT `recuento_coches`
  ON SCHEDULE EVERY 1 MINUTE STARTS '2020-02-04 10:48:10'
  ON COMPLETION NOT PRESERVE
  ENABLE
  COMMENT ''  DO
BEGIN
	declare vcifc int(9) default 0;
    declare vconteo int(9) default 0;
    declare str text default "";
    declare contar cursor for select cifc, sum(cantidad) from distribucion group by cifc;
    open contar;
    loop
    	fetch contar into vcifc, vconteo;
        set str = concat(str, "El concesionario ", vcifc, " tiene ", vconteo, " coches. ");
    end loop;
    close contar;
    insert into log (usuario, notas, hora) values (current_user(), str, now());
END$$

DELIMITER ;

/* Data for the `clientes` table  (LIMIT 0,500) */

INSERT INTO `clientes` (`dni`, `nombre`, `apellidos`, `ciudad`) VALUES
  (1,'luis','garcia','madrid'),
  (2,'antonio','lopez','valencia'),
  (3,'juan','martin','madrid'),
  (4,'maria','garcia','madrid'),
  (5,'javier','gonzalez','barcelona'),
  (6,'ana','lopez','barcelona'),
  (7,'Pepe','Villalobos','Torremolinos'),
  (8,'Pepe','Villalobos','Torremolinos');
COMMIT;

/* Data for the `coches` table  (LIMIT 0,500) */

INSERT INTO `coches` (`codcoche`, `nombre`, `modelo`, `precio`) VALUES
  (1,'Ibiza','GLX',12900),
  (2,'Ibiza','GTI',NULL),
  (3,'Ibiza','GTD',NULL),
  (4,'Toledo','GTD',NULL),
  (5,'Cordoba','GTI',NULL),
  (6,'Megane','1.6',NULL),
  (7,'Megane','GTI',NULL),
  (8,'Laguna','GTD',NULL),
  (9,'Laguna','GTI',NULL),
  (10,'ZX','16V',NULL),
  (11,'ZX','TD',NULL),
  (12,'Xantia','GTD',NULL),
  (13,'A4','1.8',NULL),
  (14,'A4','2.8',NULL),
  (15,'Astra','Caravan',NULL),
  (16,'Astra','GTI',NULL),
  (17,'Corsa','1.5',NULL),
  (18,'300','316.l',NULL),
  (19,'500','525l',NULL),
  (20,'Ibiza','GLX',NULL),
  (21,'Ibiza','GLX',NULL),
  (22,'Ibiza','GLX',NULL),
  (23,'Ibiza','GLX',NULL),
  (24,'Ibiza','GLX',NULL),
  (25,'Ibiza','GLX',NULL),
  (26,'Ibiza','GLX',NULL),
  (27,'Ibiza','GLX',NULL),
  (28,'Ibiza','GLX',NULL),
  (29,'Ibiza','GLX',NULL),
  (30,'Ibiza','GLX',NULL),
  (31,'Ibiza','GLX',NULL),
  (32,'Ibiza','GLX',NULL),
  (33,'Ibiza','GLX',NULL),
  (34,'Ibiza','GLX',NULL),
  (35,'Cordoba','GTI',NULL),
  (36,'Cordoba','GTI',NULL),
  (37,'Cordoba','GTI',NULL),
  (38,'Cordoba','GTI',NULL),
  (39,'Cordoba','GTI',NULL),
  (40,'Megane','1.6',NULL),
  (41,'Megane','1.6',NULL),
  (42,'Megane','1.6',NULL),
  (43,'Megane','1.6',NULL),
  (44,'Megane','1.6',NULL),
  (45,'Megane','1.6',NULL),
  (46,'Megane','1.6',NULL),
  (47,'Megane','1.6',NULL),
  (48,'Megane','1.6',NULL),
  (49,'Megane','1.6',NULL),
  (50,'Laguna','GTD',NULL),
  (51,'Laguna','GTD',NULL),
  (52,'Laguna','GTD',NULL),
  (53,'Laguna','GTD',NULL),
  (54,'Laguna','GTD',NULL),
  (55,'Laguna','GTI',NULL),
  (56,'Laguna','GTI',NULL),
  (57,'Laguna','GTI',NULL),
  (58,'Laguna','GTI',NULL),
  (59,'Laguna','GTI',NULL),
  (60,'Ibiza','GLX',NULL),
  (61,'Ibiza','GLX',NULL),
  (62,'Ibiza','GLX',NULL),
  (63,'Ibiza','GLX',NULL),
  (64,'Ibiza','GLX',NULL),
  (65,'Cordoba','GTI',NULL),
  (66,'Cordoba','GTI',NULL),
  (67,'Cordoba','GTI',NULL),
  (68,'Cordoba','GTI',NULL),
  (69,'Cordoba','GTI',NULL),
  (70,'Megane','1.6',NULL),
  (71,'Megane','1.6',NULL),
  (72,'Megane','1.6',NULL),
  (73,'Megane','1.6',NULL),
  (74,'Megane','1.6',NULL),
  (75,'Megane','1.6',NULL),
  (76,'Megane','1.6',NULL),
  (77,'Megane','1.6',NULL),
  (78,'Megane','1.6',NULL),
  (79,'Megane','1.6',NULL),
  (80,'Laguna','GTD',NULL),
  (81,'Laguna','GTD',NULL),
  (82,'Laguna','GTD',NULL),
  (83,'Laguna','GTD',NULL),
  (84,'Laguna','GTD',NULL),
  (85,'Laguna','GTI',NULL),
  (86,'Laguna','GTI',NULL),
  (87,'Laguna','GTI',NULL),
  (88,'Laguna','GTI',NULL),
  (89,'Laguna','GTI',NULL),
  (90,'Ibiza','GLX',NULL),
  (91,'Ibiza','GLX',NULL),
  (92,'Ibiza','GLX',NULL),
  (93,'Ibiza','GLX',NULL),
  (94,'Ibiza','GLX',NULL);
COMMIT;

/* Data for the `concesionario` table  (LIMIT 0,500) */

INSERT INTO `concesionario` (`cifc`, `nombre`, `ciudad`) VALUES
  (1,'Acar','Madrid'),
  (2,'Bcar','Madrid'),
  (3,'Ccar','Barcelona'),
  (4,'Dcar','Valencia'),
  (5,'Ecar','Bilbao'),
  (6,'Dcar','Torremolinos');
COMMIT;

/* Data for the `distribucion` table  (LIMIT 0,500) */

INSERT INTO `distribucion` (`cifc`, `codcoche`, `cantidad`) VALUES
  (1,1,3),
  (1,5,7),
  (1,6,7),
  (2,6,5),
  (2,8,10),
  (2,9,10),
  (3,10,5),
  (3,11,3),
  (3,12,5),
  (4,13,10),
  (4,14,5),
  (5,15,10),
  (5,16,20),
  (5,17,8),
  (6,19,3);
COMMIT;

/* Data for the `log` table  (LIMIT 0,500) */

INSERT INTO `log` (`id`, `usuario`, `notas`, `hora`) VALUES
  (2,'root@localhost','Total de clientes: ','2020-02-04 10:31:41'),
  (3,'root@localhost','Total de clientes: 6','2020-02-04 10:32:27'),
  (4,'root@localhost','Total de clientes: 6','2020-02-04 10:35:00'),
  (5,'root@localhost','Total de clientes: 6','2020-02-04 10:40:00'),
  (6,'root@localhost','Total de clientes: 6','2020-02-04 10:45:00'),
  (7,'root@localhost','Total de clientes: 6','2020-02-04 10:50:00'),
  (8,'root@localhost','Total de clientes: 6','2020-02-04 10:55:00'),
  (9,'root@localhost','Total de clientes: 6','2020-02-04 11:00:00'),
  (10,'root@localhost','Total de clientes: 6','2020-02-04 11:05:00'),
  (11,'root@localhost','Total de clientes: 6','2020-02-04 11:10:00'),
  (12,'root@localhost','Total de clientes: 6','2020-02-04 11:11:45'),
  (13,'root@localhost','Total de clientes: 6','2020-02-04 11:11:50'),
  (14,'root@localhost','Total de clientes: 6','2020-02-04 11:11:55'),
  (15,'root@localhost','Total de clientes: 6','2020-02-04 11:12:00'),
  (16,'root@localhost','Total de clientes: 6','2020-02-04 11:12:05'),
  (17,'root@localhost','Total de clientes: 6','2020-02-04 11:12:10'),
  (18,'root@localhost','Total de clientes: 6','2020-02-04 11:12:15'),
  (19,'root@localhost','Total de clientes: 6','2020-02-04 11:12:20'),
  (20,'root@localhost','Total de clientes: 6','2020-02-04 11:12:25'),
  (21,'root@localhost','Total de clientes: 6','2020-02-04 11:12:30'),
  (22,'root@localhost','Total de clientes: 6','2020-02-04 11:12:35'),
  (23,'root@localhost','Total de clientes: 6','2020-02-04 11:12:40'),
  (24,'root@localhost','Total de clientes: 6','2020-02-04 11:12:45'),
  (25,'root@localhost','Total de clientes: 6','2020-02-04 11:12:50'),
  (26,'root@localhost','Total de clientes: 6','2020-02-04 11:12:55'),
  (27,'root@localhost','Total de clientes: 6','2020-02-04 11:13:00'),
  (28,'root@localhost','Total de clientes: 6','2020-02-04 11:13:05'),
  (29,'root@localhost','Total de clientes: 6','2020-02-04 11:13:10'),
  (30,'root@localhost','Total de clientes: 6','2020-02-04 11:13:15'),
  (31,'root@localhost','Total de clientes: 6','2020-02-04 11:13:20'),
  (32,'root@localhost','Total de clientes: 6','2020-02-04 11:13:25'),
  (33,'root@localhost','Total de clientes: 6','2020-02-04 11:13:30'),
  (34,'root@localhost','Total de clientes: 6','2020-02-04 11:13:35'),
  (35,'root@localhost','Total de clientes: 6','2020-02-04 11:13:40'),
  (36,'root@localhost','Total de clientes: 6','2020-02-04 11:13:45'),
  (37,'root@localhost','Total de clientes: 6','2020-02-04 11:13:50'),
  (38,'root@localhost','Total de clientes: 6','2020-02-04 11:13:55'),
  (39,'root@localhost','Total de clientes: 6','2020-02-04 11:14:00'),
  (40,'root@localhost','Total de clientes: 6','2020-02-04 11:14:05'),
  (41,'root@localhost','Total de clientes: 6','2020-02-04 11:14:10'),
  (42,'root@localhost','Total de clientes: 6','2020-02-04 11:14:15'),
  (43,'root@localhost','Total de clientes: 6','2020-02-04 11:14:20'),
  (44,'root@localhost','Total de clientes: 6','2020-02-04 11:14:25'),
  (45,'root@localhost','Total de clientes: 6','2020-02-04 11:14:30'),
  (46,'root@localhost','Total de clientes: 6','2020-02-04 11:14:35'),
  (47,'root@localhost','Total de clientes: 6','2020-02-04 11:14:40'),
  (48,'root@localhost','Total de clientes: 6','2020-02-04 11:14:45'),
  (49,'root@localhost','Total de clientes: 6','2020-02-04 11:14:50'),
  (50,'root@localhost','Total de clientes: 6','2020-02-04 11:14:55'),
  (51,'root@localhost','Total de clientes: 6','2020-02-04 11:15:00'),
  (52,'root@localhost','Total de clientes: 6','2020-02-04 11:15:05'),
  (53,'root@localhost','Total de clientes: 6','2020-02-04 11:15:10'),
  (54,'root@localhost','Total de clientes: 6','2020-02-04 11:15:15'),
  (55,'root@localhost','Total de clientes: 6','2020-02-04 11:15:20'),
  (56,'root@localhost','Total de clientes: 6','2020-02-04 11:15:25'),
  (57,'root@localhost','Total de clientes: 6','2020-02-04 11:15:30'),
  (58,'root@localhost','Total de clientes: 6','2020-02-04 11:15:35'),
  (59,'root@localhost','Total de clientes: 6','2020-02-04 11:15:40'),
  (60,'root@localhost','Total de clientes: 6','2020-02-04 11:15:45'),
  (61,'root@localhost','Total de clientes: 6','2020-02-04 11:15:50'),
  (62,'root@localhost','Total de clientes: 6','2020-02-04 11:15:55'),
  (63,'root@localhost','Total de clientes: 6','2020-02-04 11:16:00'),
  (64,'root@localhost','Total de clientes: 6','2020-02-04 11:16:05'),
  (65,'root@localhost','Cliente insertado','2020-02-17 17:05:08'),
  (66,'root@localhost','Cliente insertado','2020-02-17 17:50:35'),
  (67,'root@localhost','Coche insertado','2020-02-17 18:14:29'),
  (68,'root@localhost',NULL,'2020-02-17 18:14:29'),
  (69,'root@localhost','Coche insertado','2020-02-17 18:14:29'),
  (70,'root@localhost',NULL,'2020-02-17 18:14:29'),
  (71,'root@localhost','Coche insertado','2020-02-17 18:14:29'),
  (72,'root@localhost',NULL,'2020-02-17 18:14:29'),
  (73,'root@localhost','Coche insertado','2020-02-17 18:14:29'),
  (74,'root@localhost',NULL,'2020-02-17 18:14:29'),
  (75,'root@localhost','Coche insertado','2020-02-17 18:14:29'),
  (76,'root@localhost',NULL,'2020-02-17 18:14:29'),
  (77,'root@localhost','Coche insertado','2020-02-17 18:14:55'),
  (78,'root@localhost',NULL,'2020-02-17 18:14:55'),
  (79,'root@localhost','Coche insertado','2020-02-17 18:14:55'),
  (80,'root@localhost',NULL,'2020-02-17 18:14:55'),
  (81,'root@localhost','Coche insertado','2020-02-17 18:14:55'),
  (82,'root@localhost',NULL,'2020-02-17 18:14:55'),
  (83,'root@localhost','Coche insertado','2020-02-17 18:14:55'),
  (84,'root@localhost',NULL,'2020-02-17 18:14:55'),
  (85,'root@localhost','Coche insertado','2020-02-17 18:14:55'),
  (86,'root@localhost',NULL,'2020-02-17 18:14:55'),
  (87,'root@localhost','Coche insertado','2020-02-17 18:16:06'),
  (88,'root@localhost',NULL,'2020-02-17 18:16:06'),
  (89,'root@localhost','Coche insertado','2020-02-17 18:16:06'),
  (90,'root@localhost',NULL,'2020-02-17 18:16:06'),
  (91,'root@localhost','Coche insertado','2020-02-17 18:16:06'),
  (92,'root@localhost',NULL,'2020-02-17 18:16:06'),
  (93,'root@localhost','Coche insertado','2020-02-17 18:16:06'),
  (94,'root@localhost',NULL,'2020-02-17 18:16:06'),
  (95,'root@localhost','Coche insertado','2020-02-17 18:16:06'),
  (96,'root@localhost',NULL,'2020-02-17 18:16:06'),
  (97,'root@localhost','Coche insertado','2020-02-17 18:16:06'),
  (98,'root@localhost',NULL,'2020-02-17 18:16:06'),
  (99,'root@localhost','Coche insertado','2020-02-17 18:16:06'),
  (100,'root@localhost',NULL,'2020-02-17 18:16:06'),
  (101,'root@localhost','Coche insertado','2020-02-17 18:16:06'),
  (102,'root@localhost',NULL,'2020-02-17 18:16:06'),
  (103,'root@localhost','Coche insertado','2020-02-17 18:16:06'),
  (104,'root@localhost',NULL,'2020-02-17 18:16:06'),
  (105,'root@localhost','Coche insertado','2020-02-17 18:16:06'),
  (106,'root@localhost',NULL,'2020-02-17 18:16:06'),
  (107,'root@localhost','Coche insertado','2020-02-17 18:16:06'),
  (108,'root@localhost',NULL,'2020-02-17 18:16:06'),
  (109,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (110,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (111,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (112,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (113,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (114,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (115,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (116,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (117,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (118,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (119,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (120,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (121,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (122,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (123,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (124,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (125,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (126,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (127,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (128,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (129,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (130,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (131,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (132,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (133,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (134,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (135,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (136,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (137,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (138,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (139,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (140,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (141,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (142,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (143,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (144,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (145,'root@localhost','Coche insertado','2020-02-17 18:16:07'),
  (146,'root@localhost',NULL,'2020-02-17 18:16:07'),
  (147,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (148,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (149,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (150,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (151,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (152,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (153,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (154,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (155,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (156,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (157,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (158,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (159,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (160,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (161,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (162,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (163,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (164,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (165,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (166,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (167,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (168,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (169,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (170,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (171,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (172,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (173,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (174,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (175,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (176,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (177,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (178,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (179,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (180,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (181,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (182,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (183,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (184,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (185,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (186,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (187,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (188,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (189,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (190,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (191,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (192,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (193,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (194,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (195,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (196,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (197,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (198,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (199,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (200,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (201,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (202,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (203,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (204,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (205,'root@localhost','Coche insertado','2020-02-17 18:16:28'),
  (206,'root@localhost',NULL,'2020-02-17 18:16:28'),
  (207,'root@localhost','Coche insertado','2020-02-17 18:18:23'),
  (208,'root@localhost',NULL,'2020-02-17 18:18:23'),
  (209,'root@localhost','Coche insertado','2020-02-17 18:18:23'),
  (210,'root@localhost',NULL,'2020-02-17 18:18:23'),
  (211,'root@localhost','Coche insertado','2020-02-17 18:18:23'),
  (212,'root@localhost',NULL,'2020-02-17 18:18:23'),
  (213,'root@localhost','Coche insertado','2020-02-17 18:18:23'),
  (214,'root@localhost',NULL,'2020-02-17 18:18:23'),
  (215,'root@localhost','Coche insertado','2020-02-17 18:18:23'),
  (216,'root@localhost',NULL,'2020-02-17 18:18:23'),
  (217,'root@localhost','Coche actualizado: ','2020-02-17 21:39:44'),
  (218,'root@localhost','Coche actualizado (), total: 15000','2020-02-17 21:39:44'),
  (219,'root@localhost','Coche actualizado: 15000 -> 12900','2020-02-17 21:41:12'),
  (220,'root@localhost','15000 -> 12900Coche actualizado (15000 -> 12900), total: 12900','2020-02-17 21:41:12');
COMMIT;

/* Data for the `marcas` table  (LIMIT 0,500) */

INSERT INTO `marcas` (`cifm`, `nombre`, `ciudad`) VALUES
  ('1','SEAT','MADRID'),
  ('2','RENAULT','BARCELONA'),
  ('3','CITROEN','BARCELONA'),
  ('4','AUDI','VALENCIA'),
  ('5','OPEL','BILBAO'),
  ('6','BMW','BARCELONA');
COMMIT;

/* Data for the `marco` table  (LIMIT 0,500) */

INSERT INTO `marco` (`cifm`, `codcoche`) VALUES
  (1,1),
  (1,2),
  (1,3),
  (1,4),
  (1,5),
  (2,6),
  (2,7),
  (2,8),
  (2,9),
  (3,10),
  (3,11),
  (3,12),
  (4,13),
  (4,14),
  (5,15),
  (5,16),
  (5,17),
  (6,18),
  (6,19);
COMMIT;

/* Data for the `ventas` table  (LIMIT 0,500) */

INSERT INTO `ventas` (`cifc`, `dni`, `codcoche`, `color`) VALUES
  (1,1,1,'Blanco'),
  (1,2,5,'Rojo'),
  (2,1,6,'Rojo'),
  (2,3,8,'Blanco'),
  (3,4,11,'Rojo'),
  (4,5,14,'Verde'),
  (6,7,8,'Naranja butano');
COMMIT;

/* Definition for the `clientes_ai` trigger : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' TRIGGER `clientes_ai` AFTER INSERT ON `clientes`
  FOR EACH ROW
BEGIN
	insert into log (usuario, notas, hora) values (current_user(), "Cliente insertado", now());
END$$

DELIMITER ;

/* Definition for the `clientes_au` trigger : */

DELIMITER $$

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
END$$

DELIMITER ;

/* Definition for the `clientes_ad` trigger : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' TRIGGER `clientes_ad` AFTER DELETE ON `clientes`
  FOR EACH ROW
BEGIN
	insert into log(usuario, notas, hora) values (current_user(), concat("Cliente eliminado: dni ", old.dni,", Nombre: ", old.nombre, " ,Apellidos: ", old.apellidos), now());
END$$

DELIMITER ;

/* Definition for the `coches_ai` trigger : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' TRIGGER `coches_ai` AFTER INSERT ON `coches`
  FOR EACH ROW
BEGIN
	insert into log (usuario, notas, hora) values (current_user(), "Coche insertado", now());
END$$

DELIMITER ;

/* Definition for the `coches_precio_ai` trigger : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' TRIGGER `coches_precio_ai` AFTER INSERT ON `coches`
  FOR EACH ROW
BEGIN
	declare str varchar(255);
    declare total int(9);
    set total = (select sum(precio) from coches);
    set str = concat("Coche insertado (",new.nombre,", ", new.modelo,", ", new.precio, ")",", total: ", total);
	insert into log (usuario, notas, hora) values (CURRENT_USER(), str, now());
END$$

DELIMITER ;

/* Definition for the `coches_au` trigger : */

DELIMITER $$

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
END$$

DELIMITER ;

/* Definition for the `coches_precio_au` trigger : */

DELIMITER $$

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
END$$

DELIMITER ;

/* Definition for the `coches_ad` trigger : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' TRIGGER `coches_ad` AFTER DELETE ON `coches`
  FOR EACH ROW
BEGIN
	insert into log(usuario, notas, hora) values (current_user(), "Coche eliminado", now());
END$$

DELIMITER ;

/* Definition for the `coches_precio_ad` trigger : */

DELIMITER $$

CREATE DEFINER = 'root'@'localhost' TRIGGER `coches_precio_ad` AFTER DELETE ON `coches`
  FOR EACH ROW
BEGIN
	declare str varchar(255);
    declare total int(9);
    set total = (select sum(precio) from coches);
    set str = concat("Coche eliminado (",old.nombre,", ", old.modelo,", ", old.precio, ")",", total: ", total);
	insert into log (usuario, notas, hora) values (CURRENT_USER(), str, now());
END$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;