/*1. Sacar los nombres de los zapatos, contar el código de zapato, el precio acumulado en las sucesivas ventas de aquellos zapatos cuya cantidad acumulada supere los 200€
y el color de los mismos sea rojo y fueron comprados por aquellos clientes que tienen la misma dirección que el taller de nombre "Pepe Montes" o los clientes tengan el mismo
código postal que las zapaterías llamadas "La Alpargata" o "Corazón de Piel", ordenados ascendentemente por nombre de zapato.*/
select CLIENTES.nombre, ZAPATOS.nombre, count(ZAPATOS.codzapato), sum(VENTAS.precio)
from COLOR inner join ZAPATOS on COLOR.codcolor = ZAPATOS.codcolor
		   inner join VENTAS on ZAPATOS.codzapato = VENTAS.codzapato
           inner join CLIENTES on VENTAS.dni =  CLIENTES.dni,
	 TALLER
where ZAPATOS.codcolor = 2 /*Código del color rojo*/
	  and CLIENTES.direcc = (select direcc
							 from TALLER
							 where nombre = 'Pepe Montes')
		or CLIENTES.cp in (select cp
						   from ZAPATERIAS
						   where nombre in ('La Alpargata', 'Corazón de Piel'))
group by CLIENTES.nombre
having sum(VENTAS.precio) > 200
order by ZAPATOS.nombre asc;

/*2. Modificar el nomre del taller a "Talleres La Chancla" de aquellos cuyo código postal sea distinto de los de la zapatería de nombre "El Ruiseñor" o el código postal de 
los clientes con edad entre 30 y 40 años y además clientes con la misma dirección que la zapatería llamada "El candil"*/
alter table TALLER modify nombre char(30);
update TALLER
set nombre = 'Talleres La Chancla'
where cp != (select cp
			 from ZAPATERIAS
             where nombre = 'El Ruiseñor')
	  or cp in (select cp
				from CLIENTES
				where edad between 30 and 40
					  and direcc = (select direcc
									from ZAPATERIAS
									where nombre = 'El Candil'));
		
/*3. Sacar el nombre y apellidos de aquellos clientes cuyo apellido comienza por la letra Z y su dirección coincide con la del cliente Juan Ruiz y la edad esté comprendida
entre los 20 y 40 años.*/
select nombre, apellidos
from CLIENTES
where apellidos like 'Z%'
	  and direcc = (select direcc
					from CLIENTES
                    where nombre = 'Juan' and apellidos = 'Ruiz')
	  and edad between 20 and 40;

/*4. Crear la vista VCHANCLES con los atributos precio de venta, apellidos del cliente de quellos clientes cuyo código postla sea el mismo que el del taller cuya dirección es
la misma que la zapatería que tine el mismo nombre que el cliente con DNI 2345678.*/
alter table ZAPATOS modify precio int(6);
create view VCHANCLAS as
select VENTAS.Precio as Precio, CLIENTES.apellidos as Clientes
from VENTAS inner join CLIENTES on VENTAS.dni = CLIENTES.dni
where CLIENTES.cp = (select cp
					 from TALLER
                     where direcc = (select direcc
									 from ZAPATERIAS
                                     where nombre = (select nombre
													 from CLIENTES
                                                     where dni = 2345678)));
                                     
/*5. Sacar todos los nombres de los clientes, acumulado de ventas y veces que se han comprado zapatos que estén disponibles en color azul y con descuento de 20 euros en el
periodo comprendido entre 2005 y 200, siempre que el acumulado de venta supere los 500€, ordenador descendentemente por nomre y ascendentemente por acumulador de ventas.*/
select CLIENTES.nombre, sum(VENTAS.precio), count(ZAPATOS.codzapato)
from COLOR inner join ZAPATOS on COLOR.codcolor = ZAPATOS.codcolor
		   inner join VENTAS on ZAPATOS.codzapato = VENTAS.codzapato
           inner join CLIENTES on VENTAS.dni = CLIENTES.dni
where COLOR.codcolor = 3 /*Código del color azul*/
	  and ZAPATOS.disponible = 'Si'
	  and VENTAS.descuento = 20
      and fechaventa between '2005-01-01' and '2007-12-31'
group by CLIENTES.dni
having sum(VENTAS.precio) > 500
order by CLIENTES.nombre desc, sum(VENTAS.precio) asc;

/*6. Borrar todas las fichas de zapatos cuyo tipo sean deportivas y el matierla sea cuero, plástico, goma, cacuho, cartón o piel y la fecha de fabricación este comprendida
entre el 2005 y 2007 o cuyo código de zapato coincida con algunos o ambos de los DNI de los clientes Antonio López o JUan Ruperez*/
delete from FICHAZAPATO
where  tipo = 'Deportivas'
	   and material in('cuero', 'goma', 'plástico', 'caucho', 'cartón', 'piel')
       and fechafab between '2005-01-01' and '2007-12-31'
       or codzapato in (select dni
						from CLIENTES
                        where nombre = 'Antonio' and apellidos = 'Lopez'
							  or nombre = 'Juan' and apellidos = 'Ruperez');