function [fprime] = ModelElektroRK (y, tt)
% t - czas, y- wartość wektoru w obecnym punkcie
% funckcja z modelem matematycznym dla układu elektrycznego

global C1 C2 R1 R2 L1 L2 u

% małe macierze
L = [   L1 0;                           % mała macierz L
        0, L2]; 
    
C = [ ((1/C1)+(1/C2)),    -(1/C2);      % mała macierz C
      -(1/C2),             (1/C2)];
    
R = [R1,    0;                          % mała macierz R
     0,     R2 ];

 
% duże macierze
A = [L,         zeros(2); 
     zeros(2),  eye(2)];                % macierz A złożona z macierzy L oraz zerowych i jednostkowych
 
B = [ R,        C; 
     -eye(2),   zeros(2)];              % macierz B złożona z macierzy R oraz C 
 
Q = [u;
     0];                                % Napięcie przyłożone do układu
 
U = [Q; 
     zeros(2,1)];                       % wektor siły U
 
fprime = A \ (U - B*y) ;  
end