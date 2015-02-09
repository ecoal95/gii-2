% Fijando el valor de T=1 s y el intervalo de tiempo desde -3 a 3 segundos,
% representar la serie para un n�mero de t�rminos (n�mero de arm�nicos) de 5,
% 15, 100 y 400, dado que no es posible sumar infinitos t�rminos. Para
% implementar el sumatorio infinito de la serie, se puede utilizar la sentencia for
% de MATLAB. Comentar los resultados obtenidos. NOTA: Para una mejor
% visualizaci�n de los resultados, utilizar aqu� un incremento en el vector de
% tiempos de pi/1000

t = [-3:pi/1000:3];

repej3(t, 1, 5)
pause
repej3(t, 1, 100)
pause
repej3(t, 1, 400)
pause

% Realizar ahora la representaci�n gr�fica para valores de T=1, 5 y 20 s, en el
% intervalo de�-50 a 50 segundos, utilizando 400 arm�nicos. Comprobar a partir
% de las gr�ficas que el periodo de la se�al en cada caso es el correcto. NOTA:
% Para una mejor visualizaci�n de los resultados, utilizar en este apartado un
% incremento en el vector de tiempos de pi/100.

t = [-50:pi/100:50];

for T = [1, 5, 20]
    y = repej3(t, T, 400);  
    pause
    [w, f] = espectro(t, y, T);
    plot(w, f, '-b')  
    pause
end


% �Cu�l es el ancho de los pulsos del tren de pulsos rectangulares en cada caso?
% Siempre es de 0.5s
% �C�mo se deber�a modificar la expresi�n matem�tica de f(t) para representar
% un tren de pulsos con ancho de pulso igual a 1? �Y para representar un tren de
% pulsos con altura igual a 10?
% Para que el ancho sea igual a uno:
%  * cambiando las ocurrencias de 0.5 por 1 (tao)
% Para que la altura sea igual a 10:
%  * cambiando las ocurrencias de 5 por 10 (v 10)


% A partir de la expresi�n matem�tica de la funci�n f(t) , �Cu�l es el valor de los
% coeficientes cn de la serie de Fourier? �Cu�l es el valor del coeficiente c0?
%  * Fuente: Tema 2 Parte 1 p. 16: F�rmula trigonom�trica del desarrollo de la
% serie de fourier (|cn| = cn ya que son reales)
%    5 * .5 * sin(.5 * w / 2) / (.5 * w / 2)