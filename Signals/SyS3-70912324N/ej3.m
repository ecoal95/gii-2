% 3 - Se tiene el sistema lineal e invariante...
% Realizar una funci�n de MATLAB... -> fnej3

% Utilizando la funci�n creada, estudiar la respuesta en frecuencia de este
% sistema, por medio de la representaci�n gr�fica del m�dulo y de la fase de esta
% funci�n de transferencia, para los anchos de banda de ?0 =2, 2? y 100 rad/s.
% Presentar por separado las gr�ficas del m�dulo y la fase. 
% NOTA: Para las representaciones gr�ficas utilizar por ejemplo el vector 
% de frecuencias del ejercicio anterior, que se corresponde con un
% intervalo de frecuencias de -100 a 100 rad/s.
W = -100:pi/100:100;
for w0 =[2, 2*pi, 100]
    h = fnej3(W, w0);
    figure(1);
    plot(W, abs(h)); % m�dulo
    figure(2);
    plot(W, angle(h), '-r'); % fase
    pause
end

% Se puede comprobar que el ancho de banda (ca�da hasta el valor  0.707) es
% casi exactamente el valor de w0

% Partiendo de que H(w) = G(w) / F(w) (salida / entrada), queda un m�dulo:
%  sqrt(1^2 + (w / w0)^2)
%  - Para w = 0 no habr� distorsi�n nunca
%  - Cuanto mayor sea el ancho de banda, m�s se aproximar� el m�dulo a 1,
%  por lo que menos distorsi�n habr�
