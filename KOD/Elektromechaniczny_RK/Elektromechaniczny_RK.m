clear; clc; format shortg;
global R k m D al bl U Con L2
%dane 
R = 5; al = 500e-2; bl = 50e-2; 
k = 5; m = 0.5; D = 5; U = 20; Con = 0.3; L2 = 0.03;
t0 = 0; tf = 50; y0 = zeros(6,1);
emin = 1e-9; emax = 1e-8;
[t, yy] = AdaptiveRK(@ElectroMechan_model, y0, t0, tf, emin, emax);
% wyn = wyn';
Lx = @(u) al*u + bl;
%--sila pochodzenia elektrycznego
Fel = yy(1,:).*(0.5*al*Lx(yy(3,:)).* (yy(2,:)).^2);
%--sily pochodzenia mechanicznego--
Fm = -k*yy(3,:) - D*yy(1,:);
Fw = Fel + Fm; 
%% rysunki
figure(1)
plot(t,yy(1,:))
title('predkosc'); xlabel('t [s]'); ylabel('m/s');grid on;
figure(2)
plot(t,yy(2,:))
title('prad'); xlabel('t [s]'); ylabel('A');grid on;
figure(3)
plot(t,yy(3,:))
title('przesuniecie'); xlabel('t [s]'); ylabel('m');grid on;
figure(5)
plot(t,Fel)
title('silapochodzeniaelektrycznego'); xlabel('t [s]'); ylabel('N');grid 
on;
figure(7)
plot(t, Fw); grid on; 
title('wypadkowa sila'); xlabel('t [s]'); ylabel('N');
figure(8)
plot(t, Fm); grid on; 
title('wypadkowa sil pochodzenia mechanicznego'); xlabel('t [s]'); 
ylabel('N');