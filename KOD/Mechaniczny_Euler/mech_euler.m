
%% Model Mechaniczny z wykorzystaniem metody Eulera
clear; clc; 
%dane 
k1 = 1; k2 = 2; k3 = 3; %sprężyny
D1 = 5; % tłumienie
m1 = 1 ; m2 = 2; m3 = 3; % masy

% wymuszenie napięcia (skokowe)
u = 10; % siła stała w chwili przyłożenia = t0
%% dziedzina czasu
t0 = 0; tf = 50; dt = 1e-4; t = t0:dt:tf;

%% tworzenie małych macierzy

% małe macierze
M = [   m1, 0, 0; ...
        0, m2, 0; ...               % mała macierz M
        0, 0, m3] ; 

K = [   k1+k2+k3, -k2, -k3 ; ...  
        -k2, k2, 0 ; ...            % mała macierz K
        -k3, 0, k3 ] ; 

D = [   0 , 0, 0; ...
        0 , D1, 0; ...              % mała macierz D
        0 , 0, 0] ;

    

    % duże macierze
A = [   M, zeros(3); zeros(3), eye(3)]; % macierz A złożona z macierzy m oraz 
                                        % zerowych i jednostkowych
                                        
B = [ D, K; -eye(3), zeros(3)];         %macierz B złożona z macierzy D oraz K 

Q = [u;0;0];                            % Siła przyłożona do układu
U = [Q; zeros(3,1)];                    % wektor siły U
                                        %--definicja warunkowpoczatkowychY0 = zeros(6,1);
                                        %-- alokacja pamieci--
wyn = zeros(6,max(size(t))); wyn(:,1) = Y0;
%% -- rozwiazanie met Eulera - wykazuje niestabilnosc
for k = 1:1:max(size(t))-1
wyn(:,k+1) = wyn(:,k) + A\(U - B*wyn(:,k))*dt;
end
subplot(211);
plot(t,wyn(1,:),'-blue',t,wyn(2,:),'-green',t,wyn(3,:),'-red')
xlabel ('czas [t]')
ylabel (' prędkość')
legend('V(M2)','V(M1)','V(M3)')
subplot(212);
plot(t,wyn(4,:),'-blue',t,wyn(5,:),'-green',t,wyn(6,:),'-red')
xlabel ('czas [t]')
ylabel (' Przesunięcie')
legend('X(M2)','X(M1)','X(M3)')
