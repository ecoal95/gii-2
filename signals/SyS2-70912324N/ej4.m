%
% La representaci�n del espectro est� en el archivo practica1ej3.m
%

% Indicar cu�l es el ancho de banda de la se�al en cada uno de los casos (T=1, 5 y
% 20 s)
% Hay que tener en cuenta que la frecuencia en las gr�ficas est� en rad/s

% B = 1 / tao Hz = 2 * pi / tao rad/s
% Para T = 1s:
%   �ste es el m�s dif�cil de ver: el pulso dos es el que se anula y ronda
%   los 12.5 rad/s
%   B = 1 / 0.5 = 2Hz = 4 * pi rad/s ~= 12.5 rad/s
% Para T = 5s y T = 20s:
%   Igual, al depender s�lo del ancho del tren de pulsos, que no var�a.

% Explicar qu� sucede al variar el valor de T. �Cu�l es la separaci�n en frecuencia
% entre dos arm�nicos consecutivos, para cada uno de los casos? �Cu�l es la
% relaci�n entre dicha separaci�n y el valor de T?
%
% La separaci�n en frecuencias disminuye seg�n se va aumentando el periodo.
% Para T = 1s se anula el arm�nico c2, ergo la separaci�n en frecuencia
% ser� 12.5 / 2 rad/s ~= 6.25 rad/s
% Para T = 5s se anula el arm�nico c10, por lo que la separaci�n en
% frecuencia ser�: 12.5 / 10 rad/s ~= 1.25 rad/s
% para t = 20s podemos deducir por tanto que se anular� el arm�nico c40,
% siendo la separaci�n en frecuencia: 12.5 / 40 ~= .325 rad
%
% Nota: Tras el razonamiento anterior y preguntar resulta que la separaci�n
% en frecuencia es 2 * pi / T rad/s (La frecuencia del arm�nico fundamental
% como tal (1/THz) pasada a radianes / s), lo cual encaja con mis c�lculos.

% Indicar si en alguno de los tres casos hay alg�n arm�nico que se anula.
% S�, como ya he dicho se anulan los arm�nicos c2, c10 y c40 por lo menos
% (respectivamente para T = 1, 5 y 20s)

% A la vista de los espectros obtenidos, �cu�l es el nivel de continua (arm�nico
% cero) de las se�ales temporales?
%
% Nivel de continua = V * tao = 5 * 0.5 = 2.5 V