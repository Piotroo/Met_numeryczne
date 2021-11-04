%--skrypt do symulacji obliczenia pola potencjalu metoda roznic skonczonych
%-- rozwiazanie rownania Laplace'a
clear; clc; format shortg;

Nx = 30; Ny = 30;                       % rozmiar siatki
Lx = 1; Ly = 1;                         % wielkość (np. temperatura)
x = linspace(0, Lx, Nx);                % podział wielkości na ilośc kroków (rozmiar na rowne cześci) na x 
y = linspace(0, Ly, Ny);                % podział wielkości na ilośc kroków (rozmiar na rowne czesci) na y
dx = x(2) - x(1); dy = y(2) - y(1);     % policzenie wielkości różnic pomiędzy krokami w osi x oraz y
N = Nx*Ny; M = zeros(N,N);              % utworzenie macierzy o wymiarach Nx / Ny ;
B = zeros(N,1);                         % wektor
for i =2:Nx-1                           % pętla
for j =2 :Ny-1
n = i+(j-1)*Nx;                         %--indexij na liniowy
 M(n,n) = -4;                           % wpisanie w miejsce 4
 M(n,n-1) = 1;                          % wpisanie w sąsiada poprzedzającego 1
 M(n,n+1) = 1;                          % =/= następującego 1
 M(n, n-Nx) = 1;                        % =/= wiersz wyżej
 M(n, n+Nx) = 1;                        % =/= wiersz niżej
 B(n, 1) = 0;                           % tu nie potrzebne w przyp Poisona ??
end
end
%% Warunki brzegowe

%lewa krawędź phi=y
i = 1;
for j = 1:Ny
 n = i+(j-1)*Nx; 
 M(n,n) = 1;                    %- zastepuje -4 przez jeden tam gdzie jest war brzegowy
B(n,1) = y(j);                  % B(n,1) = 1;
end
% prawa phi = 1-y
i = Nx;
for j = 1:Ny
 n = i+(j-1)*Nx; 
 M(n,n) = 1; 
 B(n,1) = 1-y(j);
end
% gora phi = 1-x
j = Ny;
for i = 1:Nx
 n = i+(j-1)*Nx; 
M(n,n) = 1; 
 B(n,1) = 1-x(i);
end
% dol phi = 1-x
j = 1;
for i = 1:Nx
n = i+(j-1)*Nx; 
 M(n,n) = 1; 
 B(n,1) = x(i);
% B(n,1) = 1;
end
%%
phi_vec = M\B;
%%
phi = zeros(Nx,Ny);
for i =1:Nx
for j=1:Ny
n = i+(j-1)*Nx;
phi(i,j) = phi_vec(n);
end
end
%
surf(x,y,phi); xlabel('x'); ylabel('y');
title('Rozkladpotencjalu skalarnego');
%% obliczenie predkosci przeplywu
u = zeros(Nx, Ny); v = zeros(Nx, Ny);
for i = 2:Nx-1
for j = 2:Ny-1
u(i,j) = -(phi(i+1,j) - phi(i-1, j))/(2*dx);
 v(i,j) = - (phi(i, j+1) - phi(i,j-1))/(2*dy);
end
end
figure(2)
quiver(x,y,u',v'); xlabel('x'); ylabel('y'); title('gradient potencjalu')
xlabel('x'); ylabel('y');
