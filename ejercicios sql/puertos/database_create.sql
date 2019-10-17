drop database PUERTOS;
CREATE DATABASE PUERTOS;
USE PUERTOS;

create table PUERTO (
	codpuerto int(6) primary key,
    nombre char(15),
    cp int(5),
    direccion char(20)
);

create table TALLER (
	codnum int(6) primary key,
    nombre char(15) NOT NULL,
    direccion char(20),
    cp int(5)
);

create table BARCO (
	codbarco int(5) primary key,
    nombre char(15) NOT NULL,
    codpuerto int(6) REFERENCES PUERTO,
    fechabotadura DATE,
    color char(10)
);

create table MARINERO (
	codmari int(7) primary key,
    nombre char(15) NOT NULL,
    apellidos char(25) NOT NULL,
    dirrecion char(20),
    cp int(5),
    edad int(3)
);

create table TRIPULACION (
	codtrip int(9) primary key,
    codbarco int(7) REFERENCES BARCO,
    codmari int(7) REFERENCES MARINERO,
    fechaalta DATE,
    fechabaja DATE,
    sueldo int(6)
);
