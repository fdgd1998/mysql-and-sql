use ventacoches;

/*1. Obtener el DNI de los clientes que han comprado algún coche a un concesionario de Madrid.*/
select dni
from ventas
where cifc in(select cifc
			  from concesionario
              where ciudad = 'Madrid');

/*2. Obtener el codigo de coche de los coches vendidos por algun concesionarios de Madrid.*/
select codcoche
from ventas
where cifc in(select cifc
			  from concesionario
			  where ciudad = 'Madrid');

/*3. Obtener el nombre y el modelo de los coches vendidos por algun concesionario de Barcelona.*/
select nombre, modelo
from coches
where codcoche in(select codcoche
				  from ventas
				  where cifc in(select cifc
								from concesionario
								where ciudad = 'Barcelona'));
                            
/*4. Obtener el nombre y apellidos de los clientes cuyo DNI es menor que el de Juan Martin.*/
select nombre, apellidos
from clientes
where dni < (select dni
			 from clientes
			 where nombre = 'Juan' and apellidos = 'Martin');
             
/*5. Obtener el nombre y apellidos de los clientes cuyo DNI es menor que los de Barcelona.*/
select nombre, apellidos
from clientes
where dni < all (select dni
				 from clientes
                 where ciudad = 'Barcelona');
                 
/*6. Obtener el nombre y apellidos de los clientes cuyo DNI es mayor que el de alguno de los de Madrid, y cuyo nombre empieza por A.*/
select nombre, apellidos
from clientes
where dni > any (select dni
				 from clientes
                 where ciudad = 'Madrid')
	  and nombre like 'A%';

/*7. Obtener los DNI de los clientes que solo han comprado coches al concesionario 1.*/

select dni
from ventas as v1
where not exists (select dni
				  from ventas as v2
				  where cifc != 1
				  and v1.dni = v2.dni);

/*8. Obtener los DNI de los clientes que han comprado coches al concecionario 1 y a algun otro.*/
select dni
from ventas as v1
where cifc = 1
	  and exists (select dni
				  from ventas as v2
				  where cifc != 1
				  and v1.dni = v2.dni);