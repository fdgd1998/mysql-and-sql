/*Ejercicio 1*/
select CLIENTES.nombre, CLIENTES.apellidos, CASAS.direccion
from CASAS inner join ALQUILER on CASAS.codcasa = ALQUILER.codcasa
		   inner join CLIENTES on ALQUILER.codcli = CLIENTES.codcli
where CASAS.codcasa in (select codcasa
				  from ALQUILER
                  where codcli in (select codcli
								   from CLIENTES
                                   where apellidos like 'G*'))
	  and fecha between '2014-01-01' and '2015-12-31'
      or CLIENTES.cp = (select cp
						from LIMPIADOR
                        where nombre = 'Rosa' and apellidos = 'Torres');

/*Ejercicio 2*/
update CASAS
set precio = 5000
where codcasa in (select codcasa
				  from ALQUILER
                  where codcli in (select codcli
								   from CLIENTES
                                   where direccion = (select direccion
													  from CLIENTES
                                                      where nombre = 'Juan' and apellidos = 'López')
										 or cp = (select cp
												  from LIMPIADOR
                                                  where nombre = 'Rafael' and apellidos = 'Gutiérrez')));

/*Ejercicio 3*/
alter table CLIENTES add column sexo char(1);
alter table CLIENTES add column edad numeric(3);
select nombre, count(ALQUILER.codcli), sum(precio)
from CLIENTES inner join ALQUILER on CLIENTES.codcli = ALQUILER.codcli
where sexo = 'M'
	  and edad = 95
group by nombre
having sum(precio) > 675
order by nombre asc;

/*Ejercicio 4*/
select nombre, apellidos
from LIMPIADOR
where direccion != (select direccion
					from CASAS
                    where codcasa in (34, 56, 67, 108, 35))
order by apellidos desc, nombre asc;

/*Ejercicio 5*/
create view VCASA as
select CASAS.codcasa, numalq, codapre
from CASAS inner join ALQUILER on CASAS.codcasa = ALQUILER.codcasa,
		   LIMPIADOR;
           
/*Ejercicio 6*/
alter table CASAS add column color char(20);
delete from LIMPIADOR
where nombre like 'E*'
			 and cp in (select cp
					    from CLIENTES
                        where codcli in (select codcli
										 from ALQUILER
                                         where codcasa in (select codcasa
														   from CASAS
                                                           where color = 'amarillo')));

/*Ejercicio 7*/
/*No se puede borrar la tabla clientes, pues alquiler es un hijo que depende de la tabla padre clientes, por lo que
primero habria que borrar la tabla alquiler, ya que no se estableció el borrado en cascada durante a creación de las tablas*/
delete from ALQUILER
where codcli in (2,9);
delete from CLIENTES
where codcli in (2,9);

