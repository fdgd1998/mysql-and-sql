create database EXAMEN;
use EXAMEN;
create table LIMPIADOR (
	codapre numeric(7) primary key,
    nombre char(15) not null,
    apellidos char(25) not null,
    direccion char(20),
    cp numeric(6)
);
create table CLIENTES (
	codcli numeric(7) primary key,
    nombre char(15) not null, 
    apellidos char(25) not null, 
    direccion char(20), 
    cp numeric(6)
);
create table CASAS (
	codcasa numeric(7) primary key,
    direccion char(15) not null,
    precio numeric(6), 
    cp numeric(6)
);
create table ALQUILER (
	numalq numeric(7) primary key,
    codcasa numeric(7) references CASA,
    codcli numeric(7) references CLIENTES,
    fecha date,
    precio numeric(6)
);