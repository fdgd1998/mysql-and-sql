*/Alumno: Fran Gálvez*/

CREATE DEFINER = 'root'@'localhost' PROCEDURE `sucesion`(
        IN `n` TINYINT
    )
    DETERMINISTIC
    CONTAINS SQL
    SQL SECURITY DEFINER
    COMMENT ''
BEGIN
	declare res float default 0.00;
    while n >= 1 do
        set res = res + 1/pow(2, n);
        set n = n-1;
    end while;
    select res;
END;