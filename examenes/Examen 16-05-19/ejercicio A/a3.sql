select nombre, sum(costeinves)
from CIENTIFICOS inner join INVESTIGACION on CIENTIFICOS.dnicien = INVESTIGACION.dnicien
where sexo = 'H'
having sum(costeinves) > 1500;