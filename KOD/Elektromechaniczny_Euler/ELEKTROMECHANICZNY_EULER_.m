%PROGRAM NAPISANY DLA CEWKI I KONDENSATORA Z LINIOWYMI CHARAKTERYSTYKAMI
%INDUKCYJNOSCI I POJEMNOSCI 

clear; clc;

% dane wejsciowe
R = 10; 
al = 500e-3; bl = 50e-3; 
ac = -100e-5; bc = 20e-5; 

Lx = @(u) al*u + bl;
Cx = @(u) ac*u + bc;

k = 10;
m = 0.02; 
D = 0.003;

% wyrazenie pomocnicze--
Fc = @(u) -0.5*ac*(1/(Cx(u))^2);

% macierze 
A = zeros(4); 
A(1,1) = m; 
A(3:end, 3:end) = eye(2);  

B1 = [D, 0; 
      0, (R+al)]; 
  
B2 = [k, 0; 
      0, 0];
  
B = [B1,        B2; 
    -eye(2), zeros(2)];             % uzuzpelnic B(2,4) = 1/Cx


C = [0, -0.5*al, 0, 0; 
     zeros(3,4)];                   %  C(1,4) Fc(x)

F = zeros(4,1);

% wymuszenie napieciowe
% F(2) = 1e2;

% parametry symulacji  met. Eulera 
dt = 1e-5;
tf = 0.2;
t0 = 0; 
t = t0:dt:tf;

% alokacja pamieci na wyniki obliczen
wyn = zeros(4, max(size(t))); 
f = zeros(1, max(size(t))) +100 ;
% warunki poczatkowe

y0 = zeros(4,1);
wyn(:,1) = y0;

%% rozwiazanie metoda Euler'a
for k = 1:1:max(size(t)) - 1
    
    A(2,2) = Lx(wyn(3, k));
    B(2,4) = 1/Cx(wyn(3,k));
    C(1,4) = Fc(wyn(3,k));
    F(2)  = f(k);
    
    wyn(:,k+1) = wyn(:, k) + A\(F - B*wyn(:,k) - C*(wyn(:,k)).^2)*dt;
    
end

%%  sila pochodzenia elektrycznego

Fel = wyn(1,:).* (0.5*al*Lx(wyn(3,:)).*(wyn(2,:)).^2);

% wykresy

figure(1)
plot(t, wyn(1,:)); grid on;
title('predkosc'); xlabel('t'); ylabel('m/s')

figure(2)
plot(t, wyn(2,:));grid on;
title('prad'); xlabel('t'); ylabel('A');

figure(3)
plot(t, Fel);grid on;
title('sila pochodzenia elektrycznego'); xlabel('t'); ylabel('N');

figure(4)
plot(t, wyn(3,:));grid on;
title('wychylenie x'); xlabel('t'); ylabel('m');