% Realizar una funci�n de MATLAB (utilizando la instrucci�n function) 
% que se identifique con la siguiente expresi�n, correspondiente a la
% integral de Fourier  de un pulso rectangular no peri�dico:
function [ y ] = fnej1( w )
    y = 5 * .5 * (sin(.5 * w / 2) ./ (.5 * w / 2));
end

