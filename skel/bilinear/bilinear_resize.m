function R = bilinear_resize(I, p, q)
	% =========================================================================
	% Upscaling de imagine folosind algoritmul de interpolare biliniara
	% Transforma imaginea I alb-negru din dimensiune m x n in dimensiune p x q
	% =========================================================================
	
	[m n nr_colors] = size(I);

	% initializeaza matricea finala
	R = zeros(p, q);
	
	% cast I la double
	I = cast(I, 'double');

	% daca imaginea e alb negru, ignora
	if nr_colors > 1
		R = -1;
		return
	endif

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

			% afla punctele ce inconjoara punctul (xp, yp)
			[x1 y1 x2 y2] = surrounding_points(n, m, x_p, y_p);

			% calculeaza coeficientii de interpolare a
			a = bilinear_coef(I, x1, y1, x2, y2);

			% calculeaza valoarea interpolata a pixelului (x, y)
			R(y + 1, x + 1) = a(1) + a(2) * x_p + a(3) * y_p + a(4) * x_p * y_p;
		endfor
		
	endfor

	% transforma matricea rezultat in uint8 pentru a fi o imagine valida
	R = cast(R, 'uint8');
	
endfunction
