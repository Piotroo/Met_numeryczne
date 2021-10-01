clear, clc, format shortg;
global k1 k2 k3 D1 m1 m2 m3 f
%dane 
k1 = 1; k2 = 2; k3 = 3; %sprężyny
D1 = 5; % tłumienie
m1 = 1 ; m2 = 2; m3 = 3; % masy
% wymuszenie siły (skokowe)
f = 10; % siła stała w chwili przyłożenia = t0
%parametry solvera:
t0 = 0; tf = 40; %czas początkowy - końcowy;
emin = 1e-9; emax = 1e-8;
y0 = zeros(6,1); % wektor początkowy (?)
[t, yy] = AdaptiveRK(@ModelMechanicznyRK, y0, t0, tf, emin, emax);
%% Przesunięcia Prędkości
% cyan M1 niebieski M2
% różowy M2 czerwony M3
% czarny M3 Zielony M1
plot (t,yy(3,:), '-r', t, yy(1,:), '-g', t, yy(2,:), '-blue', ...
 t, yy(4,:),'-c', t, yy(5,:),'-m',t, yy(6,:), '-black'); grid on
xlabel ('czas [t]')
ylabel ('Prędkość oraz przesunięcie')
legend ('Prędkość bloku M3', 'Prędkość bloku M1', 'Prędkość bloku M2', ...
'Przesunięcie bloku M1', 'Przesunięcie bloku M2', 'Przesunięcie bloku M3')