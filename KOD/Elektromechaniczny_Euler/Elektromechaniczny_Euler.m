clc, clear, format short
%dane wejściowe
R = 5; al = 500e-2; bl = 50e-2; 
k = 5; m = 0.5; D = 5; U = 20; Con = 0.3; L2 = 0.03;
y0 = zeros(6,1);
Lx = @(u) al*u + bl;
% Tworzenie macierzy
A = zeros(6); A(1,1) = m; A(3,3) = L2; ...
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
%% dziedzina czasu
t0 = 0; tf = 50; dt = 1e-4; t = t0:dt:tf;
Y0 = zeros(6,1);
%-- alokacja pamieci--
wyn = zeros(6,max(size(t))); wyn(:,1) = Y0;
f = zeros (1, max(size(t)))+30;
wyn (:,1) = Y0;
%% -- rozwiazanie met Eulera - wykazuje niestabilnosc
for k = 1:1:max(size(t))-1
A(2,2) = Lx(wyn(2,k));
wyn(:,k+1) = wyn(:,k) + A\(U - B*wyn(:,k))*dt;
end
Fel = wyn (1,:).*(0.5*al.*Lx(wyn(3,:)).*(wyn(2,:)).^2);
figure(1)
plot(t, (wyn(1,:))); grid on;
title('predkosc'); xlabel('t [s]'); ylabel('m/s');grid on;
figure(2)
plot(t, (wyn(2,:))); title ('Prąd'); grid on;
title('prad'); xlabel('t [s]'); ylabel('A');grid on;
figure(3)
plot(t, (wyn(3,:))); grid on;
title('przesuniecie'); xlabel('t [s]'); ylabel('m');grid on;
figure(4)
plot(t, (wyn(4,:))); grid on;
title('sila pochodzenia elektrycznego'); xlabel('t [s]'); 
ylabel('N');gridon;
figure(6)
plot(t, (wyn(6,:))); grid on;
title('wypadkowa sila'); xlabel('t [s]'); ylabel('N');
figure(7)
plot (t, Fel ); grid on
title('sila pochodzenia elektrycznego'); xlabel('t [s]'); 
ylabel('N');gridon;
