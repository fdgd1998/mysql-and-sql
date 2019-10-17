drop database if exists EMPRESA;
create database EMPRESA;
use EMPRESA;

create table CLIENTES (
	cod int(3) primary key,
    nombre char(15) not null,
    apellidos char(20) not null,
    sexo char(1),
    sueldo int(5)
);
create table MUJERES (
	cod int(3) primary key references CLIENTES,
    nombre char(15) references CLIENTES,
    apellidos char(20) references CLIENTES,
    sueldo int(5) references CLIENTES
);
create table HOMBRES (
	cod int(3) primary key references CLIENTES,
    nombre char(15) references CLIENTES,
    apellidos char(20) references CLIENTES,
    sueldo int(5) references CLIENTES
);
create table HOMBRESMASTRESMIL (
	cod int(3) primary key references HOMBRES,
    nombre char(15) references HOMBRES,
    apellidos char(20) references HOMBRES,
    sueldo int(5) references HOMBRES
);