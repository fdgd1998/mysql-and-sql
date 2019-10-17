drop database if exists CAZA;
create database CAZA;
use CAZA;

create table CLUB (
	codclub int(3) primary key,
    nombre char(15) not null
);
create table CAZADORES (
	codcaz int(3) primary key,
    nombre char(15) not null,
    apellidos char(25) not null,
    codclub int(3) references CLUB,
    sexo char(10),
    cuota float(5),
    codarma int(3) references ARMAS
);
create table ARMAS (
	codarma int(3) primary key,
    nombre char(25) not null,
    codcaz int(3) references CAZADORES
);
create table PIEZAS (
	codpieza int(3) primary key,
    raza char(25) not null,
    especie char(15) not null,
    altura float(5),
    peso float(5),
    sexo char(10)
);
create table CAZA (
	codarma int(3),
    codpieza int(3),
    zona char(10),
    fecha date,
    primary key (codarma, codpieza, fecha)
);