drop database CACERIA;
create database CACERIA;
use CACERIA;

create table CLUB (
	id_club varchar(20) primary key,
    nombre_club varchar(20),
    telefono int(9),
    direccion varchar(30)
) ENGINE=InnoDB;

create table CAZADORES (
	dni varchar(9) primary key,
    nombre varchar(20),
    apellidos varchar(20),
    edad int(3),
    telefono int(9),
    cuota int(5),
    sexo char(2),
    id_club varchar(5),
    constraint foreign key (id_club) references CLUB(id_club)
) ENGINE=InnoDB;

create table ARMAS(
	id_arma int(5) primary key,
    descripcion varchar(5),
    precio int(6),
    dni varchar(9),
    constraint foreign key (dni) references CAZADORES (dni)
) ENGINE=InnoDB;

create table PIEZAS(
	id_pieza int(5),
    tipo_pieza varchar(20),
    fecha_captura date, /*INDICA QUE VALOR QUE ADMITIRA EL CAKPO SERA DE TIPO DATE. TAMBIEN PUEDE SER DE TIPO TIME PARA LA HORA.*/
    id_arma int (5),
    constraint foreign key (id_arma) references ARMAS (id_arma)
) ENGINE=InnoDB;
    