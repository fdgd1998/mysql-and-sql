/*drop database if exists ventacoches;*/
create database ventacoches;
use ventacoches;

create table MARCAS (
	cifm char(20) primary key,
    nombre char(20) not null,
    ciudad char(20)
);

create table CLIENTES (
	dni int(9) primary key,
    nombre char(20) not null,
    apellidos char(30) not null,
    ciudad char(20)
);

create table CONCESIONARIO (
	cifc int(9) primary key,
    nombre char(20) not null,
    ciudad char(20)
);

create table COCHES (
	codcoche int(9) primary key,
    nombre char(20) not null,
    modelo char(20) not null
);

create table VENTAS (
	cifc int(9) references CONCESIONARIO,
    dni int(9) references CLIENTES,
    codcoche int(9) references COCHES,
    color char(20),
    primary key (cifc, dni, codcoche)
);

create table DISTRIBUCION (
	cifc int(9) references CONCESIONARIO,
    codcoche int(9) references COCHES,
    cantidad int(2),
    primary key (cifc, codcoche)
);

create table MARCO (
	cifm int(9) references MARCAS,
    codcoche int(9) references COCHES,
    primary key (cifm, codcoche)
);