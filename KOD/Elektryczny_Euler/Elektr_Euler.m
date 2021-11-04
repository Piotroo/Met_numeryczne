%% Model Elektryczny z wykorzystaniem metody Eulera
clear; clc; 

%dane
C1 = 0.1; C2 = 0.2;     % pojemności
R1 = 1 ; R2 = 2;        % Rezystancje
L1 = 0.1 ; L2 = 0.2;    % Indukcyjności

% wymuszenie napięcia (skokowe)
u = 10;                 % siła stała w chwili przyłożenia = t0
%% dziedzina czasu
t0 = 0; tf = 3; dt = 1e-4; t = t0:dt:tf;
%% tworzenie małych macierzy

% małe macierze
L = [   L1 0;                               % mała macierz L
        0, L2]; 
    
C = [ 1/C1+1/C2,    -1/C2;                  % mała macierz C
      -1/C2,        1/C2]; 
  
R = [   R1, 0;                              % mała macierz R
        0,  R2 ];   
    
% Duże macierze
A = [L,         zeros(2); 
     zeros(2),  eye(2)];                    % macierz A złożona z macierzy L oraz zerowych i jednostkowych

B = [ R,        C; 
     -eye(2),   zeros(2)];                  % macierz B złożona z macierzy R oraz C
 
Q = [u;
     0];                                    % Napięcie przyłożone do układu
 
U = [Q; 
     zeros(2,1)];                           % wektor siły U
 
 

Y0 = zeros(4,1);                            %definicja warunkow poczatkowych

wyn = zeros(4,max(size(t)));                % alokacja pamieci

wyn(:,1) = Y0;
%% -- rozwiazanie met Eulera - wykazuje niestabilnosc

for k = 1:1:max(size(t))-1
wyn(:,k+1) = wyn(:,k) + A\(U - B*wyn(:,k))*dt;
end

figure(1)
plot(t, wyn(1:2,:), t, (wyn(1,:) - wyn(2,:)));
grid on;
legend('I1', 'I2', 'I3')
xlabel('czas'); ylabel('Prąd [A]');

figure(2)
plot(t, wyn(3:4,:)); grid on;
legend('C2', 'C1'); 
xlabel('czas'); ylabel('Ładunek [Kulomb]');