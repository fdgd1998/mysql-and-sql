/*1. Sacar el nombre y apellidos de los clientes cuya dirección sea distinta que la limpiadora Juana Montes o el código postal de
la carnicería llamada El Chuletón ordenados decendenmente por apellidos y adcendetemente por nombre.*/
select nombre, apellidos
from CLIENTES
where direccion != (select direccion
					from LIMPIADORAS
                    where nombre='Juana' and apellidos='Montes')
	  or cp = (select cp
			   from CARNICERIA
			   where nombre = 'El Chuletón')
order by apellidos desc, nombre;

/*2. Modificar el precio a 500 de todas las compras cuya localidad sea Fuengirola y cuyos clientes tengan una edad comprendida
entre los 20 y 30 años y cuya dirección sea la misma que la de las limpiadoras Luisa Torres o Manuela Gómez.*/
update COMPRAS
set precio = 500.00
where codcar in (select codcar
				 from CARNICERIA
				 where codloc = (select codloc
								 from LOCALIDAD
								 where nombre='Fuengirola'))
	  and codcli in (select codcli
					 from CLIENTES
                     where edad between 20 and 30
						   and direccion in (select direccion
											from LIMPIADORAS
                                            where nombre='Luisa' and apellidos='Torres'
												  or nombre='Manuela' and apellidos='Gómez'));

/*3. Sacar los códigos de cliente y el precio acumulado en las sucesivas ventas de aquellos cuya cantidad acumulada supere los 1200€
ordenados afabéticamente por nombre del cliente.*/
select CLIENTES.nombre, CLIENTES.codcli, sum(precio)
from CLIENTES inner join COMPRAS on CLIENTES.codcli = COMPRAS.codcli
group by CLIENTES.codcli
having sum(precio) > 1200.00
order by nombre asc;

/*4. Modificar el apellido de los clientes a Gómez de aquellos que compraron algo en el año 2010 en alguna carnicaería de Fuengirola
y tienen la misma dirección que la limpiadora llamada Ana Pérez y el codigo postal que las carnicerías La Lola, Chuleta o Martín.*/
alter table LIMPIADORAS add column apellidos char(25);
update CLIENTES
set apellidos='Gómez'
where codcli in (select codcli
				 from COMPRAS
                 where fecha between '2010-01-01'and '2010-12-31'
					   and codcar = (select codcar
									 from CARNICERIA
									 where codloc = (select codloc
													 from LOCALIDAD
                                                     where nombre = 'Fuengirola')))
	  and direccion = (select direccion
					   from LIMPIADORAS
                       where nombre='Ana' and apellidos='Perez')
	  and cp in (select cp
				 from CARNICERIA
                 where nombre in('La Lola','Chuetón','Martín'));

/*5. Sacar todos los nombres de los clientes, acumulado del precio y veces que han comprado en carnicerías con código postal 29620 durante
la el periodo comprendido entre el 2000 y 2007 siempre que el acumulado del precio supere los 500€.*/
select CLIENTES.nombre, sum(precio), count(CLIENTES.codcli)
from CLIENTES inner join COMPRAS on CLIENTES.codcli = COMPRAS.codcli
			  inner join CARNICERIA on COMPRAS.codcar = CARNICERIA.codcar
where CARNICERIA.cp = 29620
	  and fecha between '2000-01-10' and '2007-12-31'
group by CLIENTES.nombre
having sum(precio) > 500;

/*6. Sacar el nombre y apellidos de aquellos clientes cuyo apellido comienza por la letra H y su dirección coincide con la del cliente
Toni Melero y la edad esté comprendida entre los 50 y 60 años.*/
select nombre, apellidos
from CLIENTES
where apellidos like 'H%'
	  and direccion = (select direccion
					   from CLIENTES
                       where nombre = 'Toni' and apellidos = 'Melero')
	  and edad between 50 and 60;
      
/*7. Borrar la carnicería 78 o 99 o 103 o 231 (explicar).*/
/*No se puede realizar un borrado, pues no se puede borrar a un padre del que dependen hijos. Si se establece el borado en cascada a 
la hora de la creación de las tablas, sí se podría borrar.*/
delete from COMPRAS
where codcar in (78, 99, 103, 231);
delete from CARNICERIA
where codcar in (78,99,103,231);

/*8. Sacar todos los nombres de carnicerías, localidades y clientes de aquellas carnicerías cuyos clientes comienzan por P, tienen tres
E intercaladas y compraron entre los años 2011 y 2012, su código postal es el mismo que el de la limpiadora Ana Chulapa, la cual tiene el
mismo código postal que el cliente Pepe Porras.*/
select CARNICERIA.nombre as Carniceria, LOCALIDAD.nombre as Localidad, CLIENTES.nombre as Cliente
from LIMPIADORAS, LOCALIDAD inner join CARNICERIA on LOCALIDAD.codloc = CARNICERIA.codloc
							inner join COMPRAS on CARNICERIA.codcar = COMPRAS.codcar
							inner join CLIENTES on COMPRAS.codcli = CLIENTES.codcli
where CLIENTES.nombre like 'P*'
	  and CLIENTES.nombre like '%e%e%e%'
	  and fecha between '2011-01-01' and '2012-12-31'
      and CLIENTES.cp = (select cp
						 from LIMPIADORAS
                         where nombre = 'Ana' and apellidos = 'Chulapa');
                                         
/*9. Crear la vista VVISTA2 con los atributos precio, apellidos de aquellos clientes cuya dirección sea la misma que la de la carnicería
llamada La Butifarra y el mismo teléfono que las localidades de Torremolinos, Fuengirola o Benaoján.*/
/*drop view VVISTA2;*/
alter table CLIENTES add column tfno numeric(9);
create view VVISTA2 as
select precio, CLIENTES.apellidos
from CLIENTES inner join COMPRAS on CLIENTES.codcli = COMPRAS.codcli
where  CLIENTES.direccion in (select direccion
							 from CARNICERIA
                             where nombre = 'La Butifarra')
	   and CLIENTES.tfno in (select tfno
							from LOCALIDAD
							where nombre = 'Torremolinos'
								  or nombre = 'Fuengirola'
								  or nombre = 'Benaoján');

/*10. Sacar el cp, nombre de aquellas carnicerías en las que hayan realizado alguna compra los clientes que tengan la misma dirección que 
las limpiadoras Juana Torres o Antonia Pérez.*/
select CARNICERIA.cp, CARNICERIA.nombre
from CARNICERIA
where CARNICERIA.codcar in (select codcar
							from COMPRAS
                            where codcli in (select codcli
											 from CLIENTES
                                             where direccion in (select direccion
																from LIMPIADORAS
																where nombre = 'Ana' and apellidos = 'Torres'
																	  or nombre = 'Antonia' and apellidos = 'Pérez')));
select CARNICERIA.cp, CARNICERIA.nombre
from CARNICERIA inner join COMPRAS on CARNICERIA.codcar = COMPRAS.codcar
where codcli in (select codcli
				 from CLIENTES
                 where direccion = (select direccion
									 from LIMPIADORAS
                                     where nombre = 'Ana' and apellidos = 'Torres'
										   or nombre = 'Antonia' and apellidos = 'Pérez'));
