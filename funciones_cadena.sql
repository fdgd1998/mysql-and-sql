select concat(apellidos, ", ", nombre) as apelnom, upper(left(ciudad, 3)) as CIUDAD
from clientes
order by apelnom;

select concat(lower(left(apellidos, 1)), upper(substr(apellidos, 2)), ", ",lower(left(nombre, 1)), upper(substr(nombre, 2))) as apelnom, upper(substr(ciudad, 1, 3)) as ciudad
from clientes;

/*Sacar los apellidos y nombre de los clientes, y cambiar los caracteres siguiendo la siguiente regla: a -> 4, e -> 3, i -> 1, o -> 0. Y decir si son palindromos.*/
select reverse(upper(concat(replace(replace(replace(replace(nombre, 'a', 4), 'e', 3), 'i', 1), 'o', 0))), ", ",
	   reverse(upper(replace(replace(replace(replace(apellidos, 'a', 4), 'e', 3), 'i', 1), 'o', 0)))) as nom_apel_hack,
	   nombre, if (replace(nombre,' ', '') = replace(lower(reverse(nombre))), "si", "no") as palindromo
from clientes;

update coches set precio = 10000+rand()*20000+1;

