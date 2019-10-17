drop database if exists PRIMOS;
create database PRIMOS;
use PRIMOS;

create table NUMERO (
	numero int(4)
);
create table RESULTPRI (
	numero int(4) references NUMERO,
    esprimo char(10)
);