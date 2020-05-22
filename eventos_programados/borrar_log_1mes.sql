CREATE DEFINER = 'root'@'localhost' EVENT `borrar_log_1mes`
  ON SCHEDULE EVERY 1 DAY STARTS '2020-02-03 10:00:00'
  ON COMPLETION PRESERVE
  ENABLE
  COMMENT ''  DO
BEGIN
	delete from log where id < date_sub(now(), interval 30 DAY);
END;