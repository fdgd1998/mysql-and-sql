CREATE DEFINER = 'root'@'localhost' EVENT `recuento_coches`
  ON SCHEDULE EVERY 1 MINUTE STARTS '2020-02-04 10:48:10'
  ON COMPLETION NOT PRESERVE
  ENABLE
  COMMENT ''  DO
BEGIN
	declare vcifc int(9) default 0;
    declare vconteo int(9) default 0;
    declare str text default "";
    declare contar cursor for select cifc, sum(cantidad) from distribucion group by cifc;
    open contar;
    loop
    	fetch contar into vcifc, vconteo;
        set str = concat(str, "El concesionario ", vcifc, " tiene ", vconteo, " coches. ");
    end loop;
    close contar;
    insert into log (usuario, notas, hora) values (current_user(), str, now());
END;