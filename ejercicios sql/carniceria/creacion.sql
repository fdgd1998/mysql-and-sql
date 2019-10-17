drop database NEGOCIO;
create database NEGOCIO;
use NEGOCIO;
create table LOCALIDAD (
	codloc numeric(5) primary key,
    nombre char(20),
    tfno numeric(9)
);
create table LIMPIADORAS (
	codlim numeric(6) primary key,
    nombre char(20) not null,
	direccion char(30),
    cp numeric(5),
    sueldo dec(6,2)
);
create table CARNICERIA (
	codcar numeric(7) primary key,
    codloc numeric(6) references LOCALIDAD,
    nombre char(15) not null,
    direccion char(30),
    cp numeric(5)
);
create table CLIENTES (
	codcli numeric(7),
    nombre char(15) not null,
    apellidos char(25) not null,
    direccion char(30),
    cp numeric(5),
    edad numeric(3)
);
create table COMPRAS (
	codcar numeric(7) references CARNICERIA, 
    codcli numeric(7) references CLIENTES,
    fecha date,
    precio dec(6,2),
    concepto char(20)
);
alter table LOCALIDAD add column cp numeric(5);

