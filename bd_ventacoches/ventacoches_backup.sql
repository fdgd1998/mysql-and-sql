-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-02-2020 a las 00:40:50
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ventacoches`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `anadir_precio` ()  BEGIN
	alter table coches add column precio int(9);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `diesel_gasolina` ()  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `diesel_gasolina_marca` ()  BEGIN
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `nacional_extranjero` ()  BEGIN
	declare nombre char(20);
    declare apellidos char(10);
    declare ncoche char(20);
    declare marca char(20);
    declare modelo char(20);
    declare nacionalidad char(20);
    declare salir int default 0;
    declare cursor1 cursor for
    	select clientes.nombre, clientes.apellidos, marcas.nombre, coches.nombre, coches.modelo
        from clientes inner join ventas using(dni)
        inner join coches using(codcoche)
        inner join marco using(codcoche)
        inner join marcas using(cifm);
    declare exit handler for not found set salir = 1;
    open cursor1;
    	repeat
        	fetch cursor1 into nombre, apellidos, marca, ncoche, modelo;
            if marca in("SEAT", "RENAULT") then
            	set nacionalidad = "Nacional";
            else
            	set nacionalidad = "Extranjera";
            end if;
            select nombre, apellidos, marca, ncoche, modelo, nacionalidad;
        until salir = 1
        end repeat;
    close cursor1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `new_proc1` ()  BEGIN
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `dni` int(9) NOT NULL,
  `nombre` char(20) NOT NULL,
  `apellidos` char(30) NOT NULL,
  `ciudad` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`dni`, `nombre`, `apellidos`, `ciudad`) VALUES
(1, 'luis', 'garcia', 'madrid'),
(2, 'antonio', 'lopez', 'valencia'),
(3, 'juan', 'martin', 'madrid'),
(4, 'maria', 'garcia', 'madrid'),
(5, 'javier', 'gonzalez', 'barcelona'),
(6, 'ana', 'lopez', 'barcelona');

--
-- Disparadores `clientes`
--
DELIMITER $$
CREATE TRIGGER `clientes_ad` AFTER DELETE ON `clientes` FOR EACH ROW BEGIN
	insert into log(usuario, notas, hora) values (current_user(), concat("Cliente eliminado: dni ", old.dni,", Nombre: ", old.nombre, " ,Apellidos: ", old.apellidos), now());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `clientes_ai` AFTER INSERT ON `clientes` FOR EACH ROW BEGIN
	insert into log (usuario, notas, hora) values (current_user(), "Cliente insertado", now());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `clientes_au` AFTER UPDATE ON `clientes` FOR EACH ROW BEGIN
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
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `coches`
--

CREATE TABLE `coches` (
  `codcoche` int(9) NOT NULL,
  `nombre` char(20) NOT NULL,
  `modelo` char(20) NOT NULL,
  `precio` int(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `coches`
--

INSERT INTO `coches` (`codcoche`, `nombre`, `modelo`, `precio`) VALUES
(1, 'Ibiza', 'GLX', NULL),
(2, 'Ibiza', 'GTI', NULL),
(3, 'Ibiza', 'GTD', NULL),
(4, 'Toledo', 'GTD', NULL),
(5, 'Cordoba', 'GTI', NULL),
(6, 'Megane', '1.6', NULL),
(7, 'Megane', 'GTI', NULL),
(8, 'Laguna', 'GTD', NULL),
(9, 'Laguna', 'GTI', NULL),
(10, 'ZX', '16V', NULL),
(11, 'ZX', 'TD', NULL),
(12, 'Xantia', 'GTD', NULL),
(13, 'A4', '1.8', NULL),
(14, 'A4', '2.8', NULL),
(15, 'Astra', 'Caravan', NULL),
(16, 'Astra', 'GTI', NULL),
(17, 'Corsa', '1.5', NULL),
(18, '300', '316.l', NULL),
(19, '500', '525l', NULL);

--
-- Disparadores `coches`
--
DELIMITER $$
CREATE TRIGGER `coches_ad` AFTER DELETE ON `coches` FOR EACH ROW BEGIN
	insert into log(usuario, notas, hora) values (current_user(), "Coche eliminado", now());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `coches_ai` AFTER INSERT ON `coches` FOR EACH ROW BEGIN
	insert into log (usuario, notas, hora) values (current_user(), "Coche insertado", now());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `coches_au` AFTER UPDATE ON `coches` FOR EACH ROW BEGIN
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
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `coches_precio_ad` AFTER DELETE ON `coches` FOR EACH ROW BEGIN
	declare str varchar(255);
    declare total int(9);
    set total = (select sum(precio) from coches);
    set str = concat("Coche eliminado (",old.nombre,", ", old.modelo,", ", old.precio, ")",", total: ", total);
	insert into log (usuario, notas, hora) values (CURRENT_USER(), str, now());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `coches_precio_ai` AFTER INSERT ON `coches` FOR EACH ROW BEGIN
	declare str varchar(255);
    declare total int(9);
    set total = (select sum(precio) from coches);
    set str = concat("Coche insertado (",new.nombre,", ", new.modelo,", ", new.precio, ")",", total: ", total);
	insert into log (usuario, notas, hora) values (CURRENT_USER(), str, now());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `coches_precio_au` AFTER UPDATE ON `coches` FOR EACH ROW BEGIN
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
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `concesionario`
--

CREATE TABLE `concesionario` (
  `cifc` int(9) NOT NULL,
  `nombre` char(20) NOT NULL,
  `ciudad` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `concesionario`
--

INSERT INTO `concesionario` (`cifc`, `nombre`, `ciudad`) VALUES
(1, 'Acar', 'Madrid'),
(2, 'Bcar', 'Madrid'),
(3, 'Ccar', 'Barcelona'),
(4, 'Dcar', 'Valencia'),
(5, 'Ecar', 'Bilbao');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `distribucion`
--

CREATE TABLE `distribucion` (
  `cifc` int(9) NOT NULL,
  `codcoche` int(9) NOT NULL,
  `cantidad` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `distribucion`
--

INSERT INTO `distribucion` (`cifc`, `codcoche`, `cantidad`) VALUES
(1, 1, 3),
(1, 5, 7),
(1, 6, 7),
(2, 6, 5),
(2, 8, 10),
(2, 9, 10),
(3, 10, 5),
(3, 11, 3),
(3, 12, 5),
(4, 13, 10),
(4, 14, 5),
(5, 15, 10),
(5, 16, 20),
(5, 17, 8),
(6, 19, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log`
--

CREATE TABLE `log` (
  `id` int(3) NOT NULL,
  `usuario` char(20) DEFAULT NULL,
  `notas` varchar(255) DEFAULT NULL,
  `hora` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `log`
--

INSERT INTO `log` (`id`, `usuario`, `notas`, `hora`) VALUES
(2, 'root@localhost', 'Total de clientes: ', '2020-02-04 09:31:41'),
(3, 'root@localhost', 'Total de clientes: 6', '2020-02-04 09:32:27'),
(4, 'root@localhost', 'Total de clientes: 6', '2020-02-04 09:35:00'),
(5, 'root@localhost', 'Total de clientes: 6', '2020-02-04 09:40:00'),
(6, 'root@localhost', 'Total de clientes: 6', '2020-02-04 09:45:00'),
(7, 'root@localhost', 'Total de clientes: 6', '2020-02-04 09:50:00'),
(8, 'root@localhost', 'Total de clientes: 6', '2020-02-04 09:55:00'),
(9, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:00:00'),
(10, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:05:00'),
(11, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:10:00'),
(12, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:11:45'),
(13, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:11:50'),
(14, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:11:55'),
(15, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:12:00'),
(16, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:12:05'),
(17, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:12:10'),
(18, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:12:15'),
(19, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:12:20'),
(20, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:12:25'),
(21, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:12:30'),
(22, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:12:35'),
(23, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:12:40'),
(24, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:12:45'),
(25, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:12:50'),
(26, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:12:55'),
(27, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:13:00'),
(28, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:13:05'),
(29, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:13:10'),
(30, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:13:15'),
(31, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:13:20'),
(32, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:13:25'),
(33, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:13:30'),
(34, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:13:35'),
(35, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:13:40'),
(36, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:13:45'),
(37, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:13:50'),
(38, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:13:55'),
(39, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:14:00'),
(40, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:14:05'),
(41, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:14:10'),
(42, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:14:15'),
(43, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:14:20'),
(44, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:14:25'),
(45, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:14:30'),
(46, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:14:35'),
(47, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:14:40'),
(48, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:14:45'),
(49, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:14:50'),
(50, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:14:55'),
(51, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:15:00'),
(52, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:15:05'),
(53, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:15:10'),
(54, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:15:15'),
(55, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:15:20'),
(56, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:15:25'),
(57, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:15:30'),
(58, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:15:35'),
(59, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:15:40'),
(60, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:15:45'),
(61, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:15:50'),
(62, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:15:55'),
(63, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:16:00'),
(64, 'root@localhost', 'Total de clientes: 6', '2020-02-04 10:16:05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marcas`
--

CREATE TABLE `marcas` (
  `cifm` char(20) NOT NULL,
  `nombre` char(20) NOT NULL,
  `ciudad` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `marcas`
--

INSERT INTO `marcas` (`cifm`, `nombre`, `ciudad`) VALUES
('1', 'SEAT', 'MADRID'),
('2', 'RENAULT', 'BARCELONA'),
('3', 'CITROEN', 'BARCELONA'),
('4', 'AUDI', 'VALENCIA'),
('5', 'OPEL', 'BILBAO'),
('6', 'BMW', 'BARCELONA');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marco`
--

CREATE TABLE `marco` (
  `cifm` int(9) NOT NULL,
  `codcoche` int(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `marco`
--

INSERT INTO `marco` (`cifm`, `codcoche`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(3, 10),
(3, 11),
(3, 12),
(4, 13),
(4, 14),
(5, 15),
(5, 16),
(5, 17),
(6, 18),
(6, 19);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `cifc` int(9) NOT NULL,
  `dni` int(9) NOT NULL,
  `codcoche` int(9) NOT NULL,
  `color` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`cifc`, `dni`, `codcoche`, `color`) VALUES
(1, 1, 1, 'Blanco'),
(1, 2, 5, 'Rojo'),
(2, 1, 6, 'Rojo'),
(2, 3, 8, 'Blanco'),
(3, 4, 11, 'Rojo'),
(4, 5, 14, 'Verde');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`dni`);

--
-- Indices de la tabla `coches`
--
ALTER TABLE `coches`
  ADD PRIMARY KEY (`codcoche`);

--
-- Indices de la tabla `concesionario`
--
ALTER TABLE `concesionario`
  ADD PRIMARY KEY (`cifc`);

--
-- Indices de la tabla `distribucion`
--
ALTER TABLE `distribucion`
  ADD PRIMARY KEY (`cifc`,`codcoche`);

--
-- Indices de la tabla `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `marcas`
--
ALTER TABLE `marcas`
  ADD PRIMARY KEY (`cifm`);

--
-- Indices de la tabla `marco`
--
ALTER TABLE `marco`
  ADD PRIMARY KEY (`cifm`,`codcoche`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`cifc`,`dni`,`codcoche`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `log`
--
ALTER TABLE `log`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

DELIMITER $$
--
-- Eventos
--
CREATE DEFINER=`root`@`localhost` EVENT `borrar_log_1mes` ON SCHEDULE EVERY 1 DAY STARTS '2020-02-03 10:00:00' ON COMPLETION PRESERVE ENABLE DO BEGIN
	delete from log where id < date_sub(now(), interval 30 DAY);
END$$

CREATE DEFINER=`root`@`localhost` EVENT `contar_clientes` ON SCHEDULE EVERY 5 SECOND STARTS '2020-02-04 10:35:00' ON COMPLETION PRESERVE DISABLE DO BEGIN
	declare total int(9) default 0;
	set total = (select count(dni) from clientes);
	insert into log (usuario, notas, hora) values (current_user(), CONCAT("Total de clientes: ", total),now());
END$$

CREATE DEFINER=`root`@`localhost` EVENT `recuento_coches` ON SCHEDULE EVERY 1 MINUTE STARTS '2020-02-04 10:48:10' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
