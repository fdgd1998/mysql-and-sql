drop database if exists EMPRESA;
create database EMPRESA;
use EMPRESA;
create table APRENDICES (
	codigo int(5) primary key,
    nombre char(20) not null,
    apellidos char(30) not null,
    sexo char(1),
    edad int(3),
    cp int(5)
);
create table TRABAJADORES (
	codigo int(5) primary key,
    nombre char(30) not null,
    apellidos char(30) not null,
    sexo char(1),
    edad int(3),
    cp int(5),
    hijos int(2)
);
create table SUELDO (
	codigo int(5) references TRABAJADORES,
    sueldo_bruto int(6),
    categoria char(1)
);
create table NOMINA (
	codigo int(5) references TRABAJADOR,
    retencion float(3),
    bonus int(5),
    sueldo_neto float(8)
);
create table RESULTADOS (
	nombre_trabajador char(20) references TRABAJADOR,
    apellidos_trabajador char(30) references TRABAJADOR,
    sueldo_neto float(8) references NOMINA,
    nombre_aprendiz char(20) references APRENDIZ,
    apellidos_aprendiz char(30) references APRENDIZ
);