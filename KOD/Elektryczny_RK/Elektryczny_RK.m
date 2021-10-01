clear, clc, format shortg;
global C1 C2 R1 R2 L1 L2 u
%dane 
C1 = 0.1; C2 = 0.2; % pojemności
R1 = 1 ; R2 = 2; % R
L1 = 0.1 ; L2 = 0.2; % Indukcyjność
% wymuszenie napięcia (skokowe)
u = 10; % siła stała w chwili przyłożenia = t0
%parametry solvera:
t0 = 0; tf = 3; %czas początkowy - końcowy;
emin = 1e-9; emax = 1e-8;
y0 = zeros(4,1); % wektor początkowy (?)
[t, yy] = AdaptiveRK(@ModelElektroRK, y0, t0, tf, emin, emax);
figure(1)
plot(t, yy(1:2,:), t, (yy(1,:) - yy(2,:))); grid on;
legend('I1', 'I2', 'I3')
xlabel('czas [t]'); ylabel('Prąd [A]');
figure(2)
plot(t, yy(3:4,:)); grid on;
legend('C2', 'C1'); 
xlabel('czas'); ylabel('Ładunekelektryczny [Culomb]');