
function R = nn_resize(I, p, q)
	% =========================================================================
	% Upscaling de imagine folosind algoritmul de interpolare nearest-neighbour
	% Transforma imaginea I din dimensiune m x n in dimensiune p x q
	% =========================================================================
	[m n nr_colors] = size(I);

	% ignora imagini care nu sunt alb negru
	if nr_colors > 1
		R = -1;
		return
	endif
	
	% cast I la double
	I = cast(I, 'double');

	% initializeaza matricea finala
	R = zeros(p, q);

	% calculeaza factorii de scalare
	s_x = (q - 1) ./ (n - 1);
	s_y = (p - 1) ./ (m - 1);

	% defineste matricea de transformare pentru redimensionare
	T = [s_x 0; 0 s_y];

	% calculeaza inversa transformarii
	T_inv = inv(T);
	
	% parcurge fiecare pixel din imagine
	% foloseste coordonate de la 0 la n - 1
	for y = 0 : p - 1
		for x = 0 : q - 1
			% aplica transformarea inversa asupra (x, y) si calculeaza
			% x_p si y_p din spatiul imaginii initiale
			[temp] = T_inv * [x; y];
			x_p = temp(1, 1);
			y_p = temp(2, 1);

			% trece (xp, yp) din sistemul de coordonate de la 0 la n - 1 in
			% sistemul de coordonate de la 1 la n pentru a aplica interpolarea
			y_p = y_p + 1;
			x_p = x_p + 1;

			% calculeaza cel mai apropiat vecin
			y_p = round(y_p);
			x_p = round(x_p);

			% calculeaza valoarea pixelului din imaginea finala
			R(y + 1, x + 1) = I(y_p, x_p);
		endfor
	endfor

	% converteste matricea rezultat la uint8
	R = cast(R, 'uint8');

endfunction
