drop database ZAPATERIA;
create database ZAPATERIA;
use ZAPATERIA;
create table ZAPATERIAS (
	codza int(6) primary key,
    nombre char(15),
    cp int(5),
    direcc char(20)
);
create table COLOR (
	codcolor int(5) primary key,
    color char(20)
);
create table ZAPATOS (
	codzapato int(6) primary key,
    nombre char(15),
    precio char(20),
    disponible char(2),
    codcolor int(5) references COLOR,
    codza int(6) references ZAPATERIAS
);
create table FICHAZAPATO (
	codzapato int(6) primary key references ZAPATOS,
    tipo char(10),
    material char(10),
    fechafab date,
    descuento int(3)
);
create table CLIENTES (
	dni int(7) primary key,
    nombre char(15) not null,
    apellidos char(15) not null,
    direcc char(20),
    cp int(5),
    edad int(3)
);
create table VENTAS (
	codzapato int(6) primary key references ZAPATOS,
    dni int(7) references CLIENTES,
    fechaventa date,
    precio int(6),
    descuento int(4)
);
create table TALLER (
	codtaller int(7) primary key,
    nombre char(15) not null,
    direcc char(20),
    cp int(5)
);
		