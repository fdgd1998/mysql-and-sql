/*Ejercicio 1*/
alter table concesionario
change column ciudad dciudad char(20);
alter table concesionario
change column nombre dnombre char(20);

/*Ejercicio 2*/
create view coches1 as select * from coches where modelo='modelo' with check option;
create view coches2 as select * from coches where nombre='ibiza' with check option;
/*La union es posible porque las vistas son tablas virtuales, que no contienen informacion. 
La información está almacenada en las tablas referencidas.*/

/*Ejericicio 3*/
select * from coches1
union
select * from coches2;

/*Ejercicio 4 interseccion*/
select distinct coches1.*
from coches1 inner join coches2 using(codcoche);

/*Ejercicio 5*/
select distinct coches1.*
from coches1 left join coches2 using(codcoche)
where coches2.codcoche is null;
# Coge todo lo que esta en la tabla de la izquierde que no lo está en la de la derecha.
# Coge todo lo que esta en la tabla de la derecha que no tenga correspondencia con lo que haya en la derecha.

/*Ejercicio 6*/
# Dos tablas cualesquiera son compatibles respecto al producto.

/*Ejercicio 7*/
create view nmarca as select nombre from marcas;
create view nconcesion as select nombre from concesionarios;
select *
from nmarca, nconcesion;

/*Ejercicio 8*/
select *
from marcas
where ciudad = 'Barcelona';

/*Ejercicio 9*/
select *
from distribucion
where cantidad>15;

/*Ejercicio 10*/
select *
from clientes
where apellidos = 'Garcia' and ciudad = 'Madrid';
 
 /*Ejercicio 11*/
select *
from clientes
where apellidos = 'Garcia' or ciudad = 'Madrid';

/*Ejercicio 12*/
select *
from clientes
where ciudad != 'Madrid';

/* EJercicio 13*/
select apellidos
from clientes;

/*Ejercicio 14*/
select apellidos, ciudad
from clientes;

/*Ejercicio 15*/
select apellidos, ciudad
from clientes
where ciudad = 'Madrid';

/*Ejercicio 16*/
select *
from marcas inner join clientes using(ciudad);

/*Ejercicios 17*/
select *
from marcas inner join clientes on marcas.ciudad > clientes.ciudad;

/*Ejercicio 19*/
alter table distribucion add column CANTIDAD int(5);
update distribucion set CANTIDAD=2*precio;

/*Ejercicio 20*/
alter table distribucion add column CANTIDAD int(5);
update distribucion set CANTIDAD=2*precio;
select CANTIDAD from distribucion where CANTIDAD < 10;

/*Ejercicio 21*/
select sum(CANTIDAD) from distribucion;

/*Ejercicio 22*/
select cifc, sum(CANTIDAD) from distribucion;

/*Ejercicio 23*/


/*Ejercicio 24*/
select nombre
from marcas
where modelo = 'GTD';

/*Ejercicio 25*/
select nombre
from marcas inner join ventas using(color)
where color = 'Rojo';

/*Ejercicio 26*/
create view scoches as
select modelo
from coches
where modelo in ('GTD', 'GTD');

select cifm
from marco
where ...;

/*Ejercicio 27*/
select nombre
from coches
where nombre = 'Cordoba';

/*Ejercicio 28*/

/*Ejercicio 29*/

/*Ejercicio 30*/
select * from concesionario;

/*Ejercicio 31*/
select *
from clientes
where dciudad = 'Madrid';

/*Ejercicio 32*/
select cifc
from distribucion
where CANTIDAD > 10;

/*Ejercicio 33*/
select cifc
from distribucion
where CANTIDAD between 10 and 18;

/*Ejercicio 34*/
select cifc
from distribucion
where CANTIDAD < 5 or CANTIDAD > 10;

/*Ejercicio 35*/
select marcas.cifm, ventas.dni
from marcas inner join marco using(cifm)
	 inner join ventas using(codcoche)
     inner join clientes using(dni)
where marcas.ciudad = clientes.ciudad;

/*Ejercicio 36*/
select marcas.cifm, ventas.dni
from marcas inner join marco using(cifm)
	 inner join ventas using(codcoche)
     inner join clientes using(dni)
where marcas.ciudad != clientes.ciudad;

/*Ejercicio 37*/
select codcoche
from distribucion inner join concesionario using(cifc)
where concesionario.ciudad = 'Barcelona';

/*Ejercicio 38*/
select codcoche
from ventas inner join clientes using(dni)
where clientes.ciudad = 'Madrid';

/*Ejercicio 39*/
select codcoche
from ventas inner join clientes using(dni)
where clientes.ciudad = 'Madrid'
	  and cifc in (select cifc
				  from concesionario
                  where ciudad = 'Madrid');

/*Ejercicio 40*/
