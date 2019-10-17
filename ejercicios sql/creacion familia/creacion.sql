drop database FAMILIA;
create database FAMILIA;
use FAMILIA;

create table PADRES (
	codpadre int(5) primary key,
	nombre varchar(20),
    apellidos varchar(20),
    edad int(3),
    sexo char(1),
    sueldo int(4),
    cp int(5)
);
