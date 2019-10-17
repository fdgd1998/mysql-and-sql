delimiter $$
drop procedure if exists ordenar;
create procedure ordenar (n1 int, n2 int, n3 int)
begin
	case
		when (n1>n2 and n1>n3 and n2>n3) then select concat(n1,',',n2,',',n3) as 'ordenar';
		when (n1>n2 and n1>n3 and n3>n2) then select concat(n1,',',n3,',',n2) as 'ordenar';
		when (n2>n1 and n2>n3 and n1>n3) then select concat(n2,',',n1,',',n3) as 'ordenar';
        when (n2>n1 and n2>n3 and n3>n1) then select concat(n2,',',n3,',',n1) as 'ordenar';
        when (n3>n1 and n3>n2 and n1>n2) then select concat(n3,',',n1,',',n2) as 'ordenar';
        when (n3>n1 and n3>n2 and n2>n1) then select concat(n3,',',n2,',',n1) as 'ordenar';
		else select 'error';
        end case;
end; $$

call ordenar (8, 9, 1);