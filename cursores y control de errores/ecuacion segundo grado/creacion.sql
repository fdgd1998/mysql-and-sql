drop database if exists ECUACION;
create database ECUACION;
use ECUACION;
create table INCOGNITAS (
	a float,
    b float,
	c float
);
create table RES_REALES (
	a float references INCOGNITAS,
    b float references INCOGNITAS,
    c float references INCOGNITAS,
    x1 float,
    x2 float
);
create table RES_COMPLEJOS (
	a float references INCOGNITAS,
    b float references INCOGNITAS,
    c float references INCOGNITAS
);
create table SIN_SOLUCION (
	a float references INCOGNITAS,
    b float references INCOGNITAS,
    c float references INCOGNITAS
);

