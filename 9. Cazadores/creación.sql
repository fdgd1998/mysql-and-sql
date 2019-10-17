CREATE DATABASE cazadores;
USE cazadores;

CREATE TABLE CLUB (
	codclub int(3),
    nombre varchar(10) not null,
	primary key (codclub));
    
CREATE TABLE CAZADOR (
	codcaz int(3),
    nombre varchar(15) not null,
    edad int(3),
    sexo varchar(1),
    tlf int(9),
    cuota float(5) not null,
    codclub int(3) references CLUB,
    primary key (codcaz));
    
CREATE TABLE ARMAS (
	codarma int(4),
    tipo varchar(10) not null,
	primary key (codarma));
    
CREATE TABLE POSEE (
	codsuj int(4),
    codcaz int(3) references CAZADOR,
    codarma int(4) references ARMA,
	primary key (codsuj));
    
CREATE TABLE PIEZAS (
	codpie int(6),
    raza varchar(8) not null,
    especie varchar(8)not null,
    zona varchar(6),
	primary key (codpie));
    
CREATE TABLE CACERIA (
	nºref int(6),
    codsuj int(4) references POSEE,
    codpie int(6) references PIEZAS,
    fecha date,
    altura float(6),
    peso float(6),
    sexo varchar(6),
    primary key(nºref, codsuj, codpie));
    
    
    