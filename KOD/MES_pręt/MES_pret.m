%%% MES, drgania pręta aka sprężyna
%%
clear, clc, format shortg;
D1= 1e-2 ; % przekrój dolny
D2= 3e-3; % przekrój górny
L = 3e-1; % długość pręta
E = 2e5; % modelu younga materiału (stali)
F = 1e2; % siła na końcu pręta
Nel = 10; % ilość elementów na które dzielimy pręt
l = L/Nel; % długość jednego elementu 
% średnia zmiana grubości na element
delA = (D1-D2)/Nel;
%obliczenie średniej przekroju elementu
ElemA = zeros (1,Nel); ElemA(1) = D1-0.5*delA;
for k = 1:Nel-1
ElemA(k+1) = ElemA(k) - delA;
end
%wyznaczanie zastępczej spreżystnosci k dla każdego elementu
keq = (E/l)*ElemA;
% alokacja pamięci na macierz główną układu równań
A= zeros(Nel+1);
% wyznaczam macierze sztywnosci elementu i przeprowadzam asemblacje
fori = 1:max(size(keq))
k_el = [keq(i), -keq(i); -keq(i), keq(i)];
%asemblacja
 A(i:i+1,i:i+1) = A(i:i+1, i:i+1) + k_el;
end
% tworze wektro wyrazów wolnych (siły przylozone do ukladu)
b=zeros(max(size(A)),1);
%wprowadzam zerowy warunek Dirichlett'a na poczatek pręta ( umocowanie )
A(1,:) = 0; A (:,1)= 0 ; A(1,1)=1;
b(end) = F; % siła na koncu pręta
%obliczam przemieszczeniewęzłów
x=A\b;
% obliczam wartości naprezen na poszczegolnych elementach
sigma = zeros(1,Nel);
for k=1:Nel
sigma(k) = (E/l) * (x(k+1) - x(k)) ;
end
% obliczenie wydłuzenia
Eps= zeros(1,Nel-1);
for k = 1:Nel
Eps(k) = (x(k+1)-x(k))/l;
end
subplot(2,1,1);
plot (linspace(1,Nel+1,Nel+1),x);
subplot (2,1,2);
bar (sigma)
