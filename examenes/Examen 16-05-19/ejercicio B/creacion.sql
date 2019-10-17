drop database if exists SORTEO;
create database SORTEO;
use SORTEO;
create table NUMEROS (
	n1 int(2),
    n2 int(2),
    nvuelta int(1)
);
create table PREMIOS (
	premio int(5),
    n1 int(2) references NUMEROS,
    n2 int(2) references NUMEROS,
    nvuelta int(2) references NUMEROS
);
create table VUELTA (
	n1 int(2) references NUMEROS,
    n2 int(2) references NUMEROS,
    nvuelta int(2) references NUMEROS
);