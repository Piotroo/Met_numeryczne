function [fprime] = ElectroMechan_model(y, tt)
%% funckja zawiera model matematyczny dla układu elektro-mechanicznego 1D 
2dof
global R k m D al blacbc U Con L2;
Lx = @(u) al*u + bl; % opisana zależność indukcji
Cx = @(u) ac*u + bc; % opisana zależność pojemności
% definicja wyrażenia pomoczniczego
Fc = @(u) -0.5*ac*(1/(Cx(u))^2);
% tworzenie macierzy modelu
A = zeros(6); A(1,1) = m; A(3,3) = L2; ...% uzupełnić A(2,2) = Lx
A(4:end, 4:end) = eye(3);
B1 = [D, 0, 0; ...
0, R, 0; ...
 0, 0, 0];
B2 = [k, 0, 0; ...
 0, 1/Con, -1/Con; ...
 0, -1/Con, 1/Con]; 
B = [B1, B2; -eye(3), zeros(3)]; 
C1 = [0, -al/2, 0; ...
 0, 0, 0; ...
 0, 0, 0 ];
C2 = [0, 0, 0; ...
 0, 0, 0; ...
 0, 0, 0];
C = [C1, C2; zeros(3), zeros(3)]; 
F = zeros(6,1);
% wartość wymuszenia (tu wymuszenie stałe)
F(3) = U;
% Uzupelnienie macierze modelu o zmienne zależności
A(2,2) = Lx(y(2));
fprime = (A \(F - B*y - C*y.^2));
end