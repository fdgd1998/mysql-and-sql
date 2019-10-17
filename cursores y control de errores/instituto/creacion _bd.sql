drop database if exists INSTITUTO;
create database INSTITUTO;
use INSTITUTO;

create table PADRES (
	DNI int(9) primary key,
    nombre varchar(15) not null,
    apellidos varchar(25) not null
);
create table HIJOS (
	MAT int(5) primary key,
    nombre varchar(15) not null,
    edad int(3),
    DNI int(9) references PADRES
);
create table FAMILIA (
	DNI int(9) references PADRES,
    nombre_padre varchar(15) references PADRES,
    nombre_hijo varchar(15) references HIJOS,
    edad int(3) references HIJOS
);