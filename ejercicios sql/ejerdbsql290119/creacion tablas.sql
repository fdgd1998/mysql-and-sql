 <
CREATE DATABASE COCHES;
USE COCHES;

CREATE TABLE COLOR(
	codcolor numeric(6) primary key,
	tipocolor char(10)
);

CREATE TABLE PIEZAS (
	codpie numeric(6),
    nombrepie char(15) NOT NULL,
    unidades numeric(6)
);

CREATE TABLE TALLER (
	codtall numeric(6) primary key,
    nombretall char(15) NOT NULL,
    direcctall char(20)
);

CREATE TABLE LINEAPIEZAS (
	codlinepie numeric(6) primary key,
    codtall numeric(6) REFERENCES TALLER,
    codpie numeric(6) REFERENCES PIEZAS,
    cantpedido numeric(7),
    fecha DATE
);

CREATE TABLE MARCA (
	codmarca numeric(6) primary key,
    nommarca char(15)
);

CREATE TABLE CLIENTES (
	codcli numeric(7) primary key,
    nombre char(15) NOT NULL,
    apellidos char(25) NOT NULL,
    direccion char(20),
    cp numeric(5)
);

CREATE TABLE VEHICULO (
	codvehi numeric(7) primary key,
    nomveh char(15) NOT NULL,
	codmarca numeric(6) REFERENCES MARCA,
    codcolor numeric(6) REFERENCES COLOR,
    unidades numeric(7),
    precio numeric(7)
);

CREATE TABLE ALQUILER (
	numalq numeric(7) primary key,
    codvehi numeric(7) REFERENCES VEHICULO,
    codcli numeric(7) REFERENCES CLIENTES,
    fecha DATE,
    cantidad numeric(6)
);

CREATE TABLE APRENDIZ (
	codapre numeric(7) primary key,
    nombre char(15) NOT NULL,
    apellidos char(25) NOT NULL,
    direccion char(20),
    cp numeric(5)
);