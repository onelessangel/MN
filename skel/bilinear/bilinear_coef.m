function a = bilinear_coef(f, x1, y1, x2, y2)
	% =========================================================================
	% Calculeaza coeficientii a pentru interpolarea biliniara intre punctele
	% (x1, y1), (x1, y2), (x2, y1) si (x2, y2)
	% =========================================================================
	
	% calculeaza matricea A
	A = [1 x1 y1 x1*y1; 1 x1 y2 x1*y2; 1 x2 y1 x2*y1; 1 x2 y2 x2*y2];

	% calculeaza vectorul b
	b = [f(y1, x1); f(y2, x1); f(y1, x2); f(y2, x2)];

	A_inv = inv(A);
	
	% calculeaza coeficientii
	a = A_inv * b;
endfunction
