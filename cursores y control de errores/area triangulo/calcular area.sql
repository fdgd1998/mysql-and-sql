delimiter $$
create function areaTriangulo (b int, h int)
	returns float
    begin
		declare resultado float;
        set resultado = (b*h)/2;
        return resultado;
end; $$