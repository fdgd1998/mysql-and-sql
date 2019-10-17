use FAMILIA;
/*
select * from PADRES;
select * from PADRES order by apellido asc;
select nombre from PADRES where sexo='M' and cp=29620;
select nombre, apellidos, edad from padres where codpadre=4
select nombre from PADRES where sexo='V' and sueldo<2000 
*/
select nombre,apellidos from PADRES where ((edad between 10 and 90) and (sueldo between 1000 and 2500)) or cp=29620 order by apellidos desc, nombre asc;