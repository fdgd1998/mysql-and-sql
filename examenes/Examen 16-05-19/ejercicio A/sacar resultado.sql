select *
from RESULTADO
where cp = (select cp
			from CIENTIFICOS
            where nombre = 'Ana Pérez')
	 or cp in (29620, 29621, 29622, 29756)
order by nombre desc;