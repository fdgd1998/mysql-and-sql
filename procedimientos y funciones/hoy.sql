CREATE DEFINER = 'root'@'localhost' PROCEDURE `hoy`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	set lc_time_names = "es_ES";
	select date_format(now(), "Hoy es %W, %d de %M de %Y");
END;