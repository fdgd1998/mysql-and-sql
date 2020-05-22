start transaction;
insert into clientes values (8, "Pepe", "Villalobos", "Torremolinos");
insert into concesionario values (7, "Dcar", "Torremolinos");
insert into ventas values (7, 8, 8, "Naranja butano");
commit;