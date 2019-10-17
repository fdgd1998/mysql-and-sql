CREATE DATABASE PUERTO;
USE PUERTO;

/*Crear los usuarios*/
CREATE USER 'makina'@'localhost' IDENTIFIED BY 'makina';
CREATE USER 'pica'@'localhost' IDENTIFIED BY 'pica';

/*Crear todas las tablas*/
CREATE TABLE BARCO (
	MAT INT(10) PRIMARY KEY,
    NOMBRE VARCHAR(25),
    FECHABOT DATE,
    PESO INT(6))
    ENGINE=INNODB;
    
CREATE TABLE MARINERO (
	DNI VARCHAR(9) PRIMARY KEY,
    NOMBRE VARCHAR(25),
    APELLIDOS VARCHAR(35),
    SEXO VARCHAR(1),
    EDAD INT(3),
    DIRECCION VARCHAR(40),
    CP INT(5))
    ENGINE=INNODB;
    
CREATE TABLE TRIPULACION (
	MAT INT(10),
    DNI VARCHAR(9),
    FECHA DATE,
    SUELDO INT(5),
    ESTADO VARCHAR(1),
    CONSTRAINT FK_MAT FOREIGN KEY (MAT) REFERENCES BARCO(MAT),
    CONSTRAINT FK_DNI FOREIGN KEY (DNI) REFERENCES MARINERO(DNI),
    CONSTRAINT PRIMARY KEY(MAT,DNI,FECHA))
    ENGINE=INNODB;
    
/*Asignar los permisos correspondiente a cada usuario*/
GRANT select, insert ON PUERTO.BARCO TO 'pica'@'localhost';
GRANT select, insert ON PUERTO.marinero TO 'pica'@'localhost';
GRANT EXECUTE ON  PUERTO.* TO 'pica'@'localhost';
#Le he dado permisos de ejecución para hacer las inserciones desde un procedmiento
GRANT ALL ON PUERTO.* TO 'makina'@'localhost';

flush privileges; #Recargando los privilegios.