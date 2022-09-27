function [Ix, Iy, Ixy] = precalc_d(I)
	% =========================================================================
	% Prealculeaza matricile Ix, Iy si Ixy ce contin derivatele dx, dy, dxy ale 
	% imaginii I pentru fiecare pixel al acesteia
	% =========================================================================
	
	% obtine dimensiunile imaginii
	[m n nr_colors] = size(I);
	
	% cast I la double
	I = cast(I, 'double');

	Ix = zeros(m, n);
	Iy = zeros(m, n);
	Ixy = zeros(m, n);

	Ix = cast(Ix, 'double');
	Iy = cast(Iy, 'double');
	Ixy = cast(Ixy, 'double');

	% calculeaza matricea cu derivate fata de x Ix, fata de y Iy si fata de xy Ixy
	for y = 1 : m
		for x = 1 : n
			if x == 1 || x == n
				Ix(y, x) = 0;
			else
				Ix(y, x) = fy(I, y, x);
			end

			if y == 1 || y == m
				Iy(y, x) = 0;
			else
				Iy(y, x)=fx(I, y, x);
			end

			if y == 1 || y == m || x == 1 || x == n
				Ixy(y, x) = 0;
			else
				Ixy(y, x)=fxy(I, y, x);
			end
		end
	end

endfunction
