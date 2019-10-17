create database cuentas;
use cuentas;

create table clientes (
	dni varchar(9),
    nombre varchar(20),
    apellidos varchar(20),
    edad int(2),
    telefono int(9),
    direccion varchar(30),
    primary key(dni)
);

create table cuentas (
	codcuenta int (5),
    debe int(9),
    haber int (9),
    saldo int (9),
    dnititular varchar(9) references clientes,
    primary key(codcuenta)
);

create table nrojos (
	dni varchar(9) primary key,
    saldo int(9)
);