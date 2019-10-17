drop database if exists FUTUROINVEST;
create database FUTUROINVEST;
use FUTUROINVEST;

create table CIENTIFICOS (
	dnicien int(9) primary key,
    nombre char(15) not null,
    sexo char(1),
    cp int(5)
);
create table VARIABLES1 (
	codvar int(5) primary key,
    a int(2),
    b int(2),
    c int(3)
);
create table INVESTIGACION (
	codinv int(5) primary key,
    R1 float(5),
    R2 float(5),
    costeinves float(6),
    codvar int(5) references VARIABLES1,
    dnicien int(9) references CIENTIFICOS
);
create table RESULTADO (
	codinv int(5) primary key,
    nombre char(15) references CIENTIFICOS,
    cp int(5) references CIENTIFICOS,
    formula float,
    a int references VARIABLES1,
    b int references VARIABLES1,
    c int references VARIABLES1,
    R1 int references INVESTIGACION,
    R2 int references INVESTIGACION
);
