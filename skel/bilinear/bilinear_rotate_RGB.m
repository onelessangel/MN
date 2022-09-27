function out = bilinear_rotate_RGB(img, rotation_angle)
    % =========================================================================
    % Aplica interpolare bilineara pentru a roti o imagine RGB cu un unghi dat.
    % =========================================================================
    
    % extrage canalul rosu al imaginii
    red = img(:, :, 1);

    % extrage canalul verde al imaginii
    green = img(:, :, 2);

    % extrage canalul albastru al imaginii
    blue = img(:, :, 3);

    % aplică rotația pe fiecare canal al imaginii
    red = bilinear_rotate(red, rotation_angle);
	green = bilinear_rotate(green, rotation_angle);
	blue = bilinear_rotate(blue, rotation_angle);

    % econstruiește imaginea RGB finala (hint: cat)
    out = cat(3, red, green, blue);
    
endfunction