CREATE DEFINER = 'root'@'localhost' PROCEDURE `anadir_precio`()
    NOT DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	alter table coches add column precio int(9);
END;