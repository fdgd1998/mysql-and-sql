drop database FAMILIA;
create database FAMILIA;
use FAMILIA;

create table PADRES(
	DNI varchar(10),
	NOMBRE varchar(20),
	APELLIDOS varchar(30),
	TELEFONO int(9),
	DIRECCION varchar(50),
	primary key (DNI)
);

insert into PADRES values
('123456789S','ANA','GARCIA',600000000,'C\ Lagos, 34'),
('123456789O','MARIA','LOPEZ RUIZ',600000001, 'C\ Arroyo, 45');
    
