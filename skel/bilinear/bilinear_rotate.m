
function R = bilinear_rotate(I, rotation_angle)
	% =========================================================================
	% Roteste imaginea alb-negru I de dimensiune m x n cu unghiul
	% rotation_angle, aplicand interpolare biliniara.
	% rotation_angle este exprimat in radiani.
	% =========================================================================
	
	[m n nr_colors] = size(I);
	
	% cast I la double
	I = cast(I, 'double');

	% daca imaginea e alb negru, ignora
	if nr_colors > 1
		R = -1;
		return
	endif

	% calculeaza cos si sin de rotation_angle
	c = cos(rotation_angle);
	s = sin(rotation_angle);

	% initializeaza matricea finala
	R = zeros(m, n);

	% calculeaza matricea de transformare
	T_rot = [c -s; s c];

	% calculeaza inversa transformarii
	T_inv = inv(T_rot);

	% parcurge fiecare pixel din imagine
	% foloseste coordonate de la 0 la n - 1
	for y = 0 : m - 1
		for x = 0 : n - 1
			% aplica transformarea inversa asupra (x, y) si calculeaza
			% x_p si y_p din spatiul imaginii initiale
			[temp] = T_inv * [x; y];
			x_p = temp(1, 1);
			y_p = temp(2, 1);

			% trece (xp, yp) din sistemul de coordonate de la 0 la n - 1 in
			% sistemul de coordonate de la 1 la n pentru a aplica interpolarea
			y_p = y_p + 1;
			x_p = x_p + 1;

			% daca xp sau yp se afla in afara imaginii, pune un pixel
			% negru in imagine si treci mai departe
			if y_p > m || x_p > n || y_p < 1 || x_p < 1
				R(y + 1, x + 1) = 0;
				continue;
			endif

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
