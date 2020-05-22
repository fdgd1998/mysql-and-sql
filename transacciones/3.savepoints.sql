start transaction;
savepoint estado_previo;
insert into clientes values (7, "Pepe", "Villalobos", "Torremolinos");
insert into concesionario values (6, "Dcar", "Torremolinos");
insert into ventas values (6, 7, 8, "Naranja butano");
rollback to estado_previo;

commit;