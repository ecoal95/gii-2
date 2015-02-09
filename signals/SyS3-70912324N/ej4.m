t = -30:pi/100:30;
T = 100;
f = getFn(t, T, 2000);

% Obtenemos la funci�n F(w) a partir de f(t)
[w, F] = espectro(t, f, T);

% Obtenemos la salida para diversos anchos de banda
for w0 = [2, 2*pi, 100]
    G = F .* fnej3(w, w0);
    [t2, g] = inv_espectro(w, G, T);
    
    % Representaci�n de entrada y salida con respecto al tiempo
    % Se puede comprobar que el pulso sale distorsionado (m�s peque�o)
    figure(1);
    plot(t2, f);
    hold on
    plot(t2, g, '-r');
    hold off
    
    figure(2);
    plot(w, abs(F)); % Espectro en amplitud de f
    hold on
    plot(w, abs(G), '-r'); % Espectro en amplitud de g
    hold off
    pause
end

% Comentar la influencia del ancho de banda del sistema y de la se�al en
% los resultados obtenidos. �En qu� caso hay m�s distorsi�n de la se�al y 
% en cu�l la distorsi�n es menor? �A qu� crees que es debido?

% A mayor ancho de banda, menor distorsi�n
% Esto es debido a que al aplicar H(w) queda el m�dulo
% sqrt(1^2 + (w / w0)^2)
% Que es m�s cercano a uno cuanto m�s grande sea w0.
% Al ser m�s cercano a uno la relaci�n G/F, la distorsi�n es menor