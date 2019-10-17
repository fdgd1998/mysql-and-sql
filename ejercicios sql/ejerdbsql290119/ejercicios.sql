/*Ejercicio 3*/
use COCHES;
create view VPRIMERA as select ALQUILER.fecha, COLOR.tipocolor
from ALQUILER inner join VEHICULO on ALQUILER.codvehi = VEHICULO.codvehi 
			  inner join COLOR on VEHICULO.codcolor = COLOR.codcolor
              cross join CLIENTES on ALQUILER.codcli = CLIENTES.codcli
where precio > (select precio
				from VEHICULO
                where nomveh = 'Megane')
	  and unidades > 1
      and CLIENTES.cp = (select cp
						 from CLIENTES
                         where nombre='Pepe' and apellidos='García')
	  and CLIENTES.direccion = (select direccion
								from APRENDIZ
                                where nombre='Luis' and apellidos='Suárez');
         
/*Ejercicio 4*/
use COCHES;
select tipocolor, nommarca
from COLOR inner join VEHICULO on COLOR.codcolor = VEHICULO.codcolor
		   inner join MARCA on VEHICULO.codmarca = MARCA.codmarca
		   inner join ALQUILER on ALQUILER.codvehi = VEHICULO.codvehi
		   inner join CLIENTES on ALQUILER.codcli = CLIENTES.codcli
where CLIENTES.cp in (select cp
					 from CLIENTES
                     where nombre='Luis' and apellidos='Fernández'
					 or nombre='Antonio' and apellidos='Gómez');
      
/*Ejercicio 5*/
use COCHES;
select nomveh, count(numalq), sum(cantidad)
from VEHICULO inner join ALQUILER on VEHICULO.codvehi = ALQUILER.codvehi
group by nomveh
having sum(cantidad) > 1000
order by nomveh asc;

/*Ejercicio 6 - Pendiente de corregir*/
use COCHES;
update COLOR
set tipocolor='rojo'
where nommarca='SEAT'
	and codcli in (select codcli
				   from CLIENTES
                            where direccion = (select direccion
											   from CLIENTES
                                               where nombre='Antonio' and apellidos='Leon')
							and cp = (select cp 
									  from CLIENTES
                                      where apellidos in ('Suarez','Vera','Guzman','Tribujano')));
								 
/*Ejercicio 7*/
use COCHES;
select nombre, apellidos
from APRENDIZ
where direccion != (select direcctall
					from TALLER
                    where nombretall='EL PAJARITO');
                    
/*Ejercicio 8*/
use COCHES;
select nombre, apellidos
from APRENDIZ
where apellidos like 'A*'
	  and direccion = (select direccion
					   from APRENDIZ
                       where nombre='Jose' and apellidos='Perez');

/*Ejercicio 9*/
use COCHES;
select nommarca, count(numalq)
from MARCA inner join VEHICULO on MARCA.codmarca = VEHICULO.codmarca
		   inner join ALQUILER on VEHICULO.codvehi = ALQUILER.codvehi
where ALQUILER.fecha between '2000-01-01' and '2001-12-31';

/*Ejercicio 10*/
use COCHES;
create view VVISTA1 as select MARCA.codmarca, ALQUILER.codalq, PIEZAS.codpie, TALLER.codtall, APRENDIZ.codapre

/*EJERCICIO 11*/
select APRENDIZ.nombre, PIEZAS.nombrepie, CLIENTES.apellidos, TALLER.codtall
from APRENDIZ, PIEZAS inner join TALLER on 

/*Ejercicio 12*/
delete 
from MARCA
where nommarca like '*e*e*'
	  and COLOR.codcolor =(select codcolor
							  from COLOR
							  where tipocolor in('rojo','verde'))
	  and cantidad > 12000;
      
/*Ejercicio 13*/
select CLIENTES.*
from CLIENTES inner join ALQUILER on CLIENTES.codcli = ALQUILER.codcli
			  inner join VEHICULO on ALQUILER.codvehi = VEHICULO.codvehi
where codcolor = (select codcolor
				  from VEHICULO inner join ALQUILER on VEHICULO.codvehi = ALQUILER.codvehi
								inner join CLIENTES on ALQUILER.codcli = CLIENTES.codcli
				  where nombre='Antonio' and apellidos='Perez');

/*Ejercicio 14*/
select nomveh, sum(cantidad), tipocolor, CLIENTES.nombre
from MARCA inner join VEHICULO on MARCA.codmarca = VEHICULO.codmarca
		   inner join ALQUILER on ALQUILER.codvehi = VEHICULO.codvehi
           inner join CLIENTES on CLIENTES.codcli = ALQUILER.codcli
           cross join COLOR on COLOR.codcolor = VEHICULO.codcolor
where nommarca in('SEAT','CITROEN')
	  and VEHICULO.codcolor =(select codcolor
					 from COLOR
                     where tipocolor='amarillo')
	  and VEHICULO.codvehi between 1000 and 2000
      group by nomveh
      having sum(cantidad)>500;



