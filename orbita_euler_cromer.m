close all
clc;

%Orbita de Merc�rio
%A trajet�ria ser� em 2D
global Gms

Gms=4*(pi)^2;                                                              %Produto da Constante universal grav�tica e da massa do sol

h = 0.001;                                                                 %Espa�amento entre os pontos,'velocidade'
t = 0:h:0.3;

%Vetor posi��o:
x = zeros(1,numel(t));                                                     %Componente x
y = x;                                                                     %Componente y

%Vetor velocidade
vx = zeros(1,numel(t));                                                    %Componente x
vy = vx;                                                                   %Componente y

vy(1) = 8.2;
x(1) = 0.47;

%Itera��o com o m�todo de Euler-Cromer
for i = 1:numel(t)-1
    %Anima��o:
    r = sqrt(x(i)^2+y(i)^2);                                               %Raio: M�dulo do vetor posi��o
    vx(i+1) = vx(i) - (Gms*x(i)/r^3)*h;
    x(i+1) = x(i) + vx(i+1)*h;
    vy(i+1) = vy(i) - (Gms*y(i)/r^3)*h;
    y(i+1) = y(i) + vy(i+1)*h;
    figure(1)
    subplot(2,1,1)
    plot(x(i),y(i),'.k')
    title('Simula��o: �rbita Merc�rio-M�todo de Euler-Cromer')
    xlabel('x(AU)'); ylabel('y(AU)');
    axis([-0.4 0.5 -0.5 0.5])
    pause(h)
%Trajet�ria descrita pelo planeta:
                                                                           %Redimensionar as matrizes
    subplot(2,1,2)
    x_x = x(1:i);
    y_y = y(1:i);
    hold on
    plot(x_x,y_y,'-b')
    title('�rbita Merc�rio-M�todo de Euler-Cromer')
    hold on
    text(0,0,'Sol')
    axis([-0.4 0.5 -0.5 0.5])
end

%Figura 2: 

figure(2)
subplot(2,1,1)
t=t(1:i); %Rediemnsionar t, de forma as matrizes coincidirem
vx = vx(1:i);
vy = vy(1:i);
vv=sqrt((vx).^2+(vy).^2);
Ec=(1/2)*((vv).^2)
plot(t,Ec,'.r')
title('Gr�fico Ec=f(t)')
ylabel('Ec/m'); xlabel('T (Tempo)');
hold on
subplot(2,1,2)
plot(x_x,y_y,'.y')
axis([-0.6 0.7 -0.6 0.7])
hold on
plot(0, 0.3840, 'r.', 'Markersize',30)
hold on
plot(0,-0.3840,'r.', 'Markersize',30)
hold on 
plot(-0.3137,0,'b.','Markersize',30)
hold on
plot(0.4700,0,'b.','Markersize',30)
hold on 

%Calculo do valor do afelio e do perielio:                                                                           
f = sqrt(x_x.^2+y_y.^2);
Afelio = max(f)
Perielio = min(f)
%Segundo o wikip�dia: af�lio: 0,466 697 e perielio: 0,307 499
af_tabelado=0.466697;
per_tabelado=0.307499;
%C�lculo do erro associado:
erro_af_ec=(abs(af_tabelado-Afelio)/af_tabelado)*100;
erro_perielio_ec=(abs(per_tabelado-Perielio)/per_tabelado)*100;

resultado_1= ['O af�lio � igual a ',num2str(Afelio),...
    '  UA, e o erro associado a este c�lculo �  ', num2str(erro_af),'%']
resultado_2= ['O peri�lio � igual a ',num2str(Perielio),...
    '  UA, e o erro associadoa este c�lculo �  ', num2str(erro_perielio),'%']
