drop database if exists triangulo;
create database triangulo;
use triangulo;
create table incognitas (
	base int,
    altura int
);
create table resultados (
	base int references incognitas,
    altura int references incognitas,
    resultado float
);
