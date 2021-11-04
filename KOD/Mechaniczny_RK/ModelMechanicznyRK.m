function [fprime] = ModelMechanicznyRK (y, tt)  %funkcja [output] = nazwa (inputs);
% t - czas, y - wartość wektora w obecnym punkcie
% funkcja z modelem matematycznym dla układu ze sprężyną

global k1 k2 k3 D1 m1 m2 m3 f         % zmienne globalne

% małe macierze
M = [   m1, 0, 0; ...
        0, m2, 0; ...                 % mała macierz M
        0, 0, m3] ; 
  
K = [   k1+k2+k3, -k2, -k3 ; ...
        -k2, k2, 0 ; ...              % mała macierz K
        -k3, 0, k3 ] ; 
    
D = [   0 , 0, 0; ...
        0 , D1, 0; ...                 % mała macierz D
        0 , 0, 0] ;
    
    
% tworzenie dużych macierzy z wykorzystaniem małych
A = [M, zeros(3); zeros(3), eye(3)];    % macierz A złożona z macierzy m oraz zerowych i jednostkowych
B = [ D, K; -eye(3), zeros(3)];         % macierz B złożona z macierzy D oraz K 
Q = [0;
     f];                                % siła przyłożona do drugiej masy
F = [Q; zeros(4,1)];                    % wektor siły F
fprime = A \ (F - B*y) ; 
end