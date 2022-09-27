function out = nn_2x2(f, STEP = 0.1)
	% =========================================================================
	% Aplica interpolare nearest-neighbour pe imaginea 2x2 f cu puncte
	% intermediare echidistante.
	% f are valori cunoscute in punctele (1, 1), (1, 2), (2, 1) si (2, 2).
	% 
	% Parametrii:
	% - f = imaginea ce se doreste sa fie interpolata
	% - STEP = distanta dintre doua puncte succesive
	% =========================================================================
	
	% defineste coordonatele x si y ale punctelor intermediare
	x_int = 1 : STEP : 2;
	y_int = 1 : STEP : 2;

	% afla nr. de puncte
	n = length(x_int);

	% cele 4 puncte incadratoare vor fi aceleasi pentru toate punctele din
	% interior
	x1 = y1 = 1;
	x2 = y2 = 2;

	% initializeaza rezultatul cu o matrice n x n plina de zero
	out = zeros(n, n);

	% parcurge fiecare pixel din imaginea finala
	for i = 1 : n
		for j = 1 : n
			% afla cel mai apropiat pixel din imaginea initiala
			if y_int(j) - y1 < y2 - y_int(j)
				if x_int(i) - x1 < x2 - x_int(i)
					x = x1;
					y = y1;
				else
					x = x2;
					y = y1;
				endif
			else
				if x_int(i) - x1 < x2 - x_int(i)
					x = x1;
					y = y2;
				else
					x = x2;
					y = y2;
				endif
			endif

			% calculeaza pixelul din imaginea finala
			out(i, j) = f(x, y);
			
		endfor
	endfor

endfunction
