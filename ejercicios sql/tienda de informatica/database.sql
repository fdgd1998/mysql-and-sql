DROP DATABASE TIENDA_INFORMATICA;
CREATE DATABASE TIENDA_INFORMATICA;
USE TIENDA_INFORMATICA;

CREATE TABLE FABRICANTES (
	Codigo int(10) primary key,
    Fabricante nvarchar(100)
);

CREATE TABLE ARTICULOS (
	Codigo_Art int(10) primary key,
	Fabricante int(10) references FABRICANTES,
    Nombre varchar(20),
    Precio dec(5,2)
);
