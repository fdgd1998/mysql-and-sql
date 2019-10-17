USE TIENDA_INFORMATICA;
#obtener nombres de productos.
SELECT Nombre FROM ARTICULOS;

#Obtener nombres y precios de productos.
SELECT Nombre, Precio FROM ARTICULOS;

#Obtener el nombre de los productos cuyo precio sea menor o igual a 200€.
SELECT Nombre FROM ARTICULOS WHERE NOT Precio>200;

#Obtener todos los datos de los artículos cuyo precio está entre 60 y 120, ambas incluidas.
SELECT * FROM ARTICULOS WHERE PRECIO BETWEEN 60 AND 120;

#Seleccionar nombre y precio en pesetas
SELECT Nombre, PRECIO * 166.386 FROM ARTICULOS;

#Seleccionar el precio medio de todos los productos
SELECT AVG(Precio) FROM ARTICULOS;

#Seleccionar el número de artúculos cuyo nombre sea mayor o igual a 180.alter
SELECT COUNT(*) FROM ARTICULOS WHERE Precio>=180;

#Obtener el nombre y prcio de los articulos cuyo precio sea mayor o igual a 180 y ordenados descendentemente por precio, y lego ascendentemente por nombre
SELECT Nombre, Precio FROM ARTICULOS WHERE Precio>=180 ORDER BY Nombre DESC, Precio;

#Obtener un listado completo de articulos, incluyendo por cada articulo los datos del articulo, su precio y su faricante
SELECT * FROM ARTICULOS INNER JOIN FABRICANTES ON ARTICULOS.Fabricante = FABRICANTES.Codigo;

#Obtener el percio medio de los productos de cada fabricante, mostrando solo los codigos de frabricante.
SELECT AVG(PRECIO), Fabricante FROM ARTICULOS GROUP BY Fabricante;

#Obtener el precio medio de los productos de cada fabricante, mostrando el nombre del fabricante.
SELECT AVG(PRECIO), FABRICANTES.Fabricante 
FROM FABRICANTES INNER JOIN ARTICULOS 
ON FABRICANTES.Codigo = ARTICULOS.Fabricante
GROUP BY FABRICANTES.Fabricante;

#Obtener los nombres de los fabricantes que ofrezcan productos cuyo precio medio sea mayor o igual a 150€
SELECT  AVG(Precio), FABRICANTES.Fabricante
FROM FABRICANTES INNER JOIN ARTICULOS
	ON FABRICANTES.Codigo = ARTICULOS.Fabricante
GROUP BY FABRICANTES.Fabricante
HAVING AVG(Precio)>=150;

#Obtener el nombre y precio del articulo mas barato.
SELECT Nombre, MIN(Precio)
FROM ARTICULOS;

#Obtener una lista con el nombre y precio de los articulos mas caros de cada proveedor (incluyendo su nombre)
SELECT Nombre, MAX(Precio) AS CARO, FABRICANTES.Fabricante
FROM ARTICULOS INNER JOIN FABRICANTES
ON ARTICULOS.Fabricante = FABRICANTES.Codigo
GROUP BY ARTICULOS.Fabricante
HAVING CARO;

#Añadir un nuevo producto: Altavoces 70@ (fabricante 2)
INSERT INTO ARTICULOS VALUES (80,2,'Altavoces',70)



