CREATE DEFINER = 'root'@'localhost' PROCEDURE `hoy`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	declare hoy date default now();
    set lc_time_names = "es_ES";
    select concat("Hoy es ", dayname(hoy), " ", day(hoy), " de ", monthname(hoy), " de ", year(hoy), ".");
END;