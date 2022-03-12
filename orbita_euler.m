close all
clc;

global Gms
%Orbita de Mercúrio
%A trajetória em 2D
Gms = 4*(pi)^2;                                                            %Produto da Constante universal gravítica e da massa do sol
h=0.001;
                                                                           %Espaçamento entre os pontos,'velocidade'
t = 0:h:0.5;

%Vetor posição:
x = zeros(1,numel(t));                                                     %Componente x
y = x;                                                                     %Componente y

%Vetor velocidade
vx = zeros(1,numel(t));                                                    %Componente x
vy = vx;                                                                   %Componente y
vy(1) = 8.2;
x(1) = 0.47;

%Iteração com o método de Euler (1ª ordem)
%%
%Animação
for i = 1:numel(t)-1
    r = sqrt(x(i)^2+y(i)^2); %Módulo do vetor posição
    vx(i+1) = vx(i)-(Gms*x(i)/r^3)*h;
    x(i+1) = x(i) + vx(i)*h;
    vy(i+1) = vy(i)-(Gms*y(i)/r^3)*h;
    y(i+1) = y(i)+vy(i)*h;
    
    figure(1)
    subplot(2,1,1)
    plot(x(i),y(i),'.k')
   
    axis([-0.7 1.15 -1 1])
    xlabel('x(AU)'); ylabel('y(AU)');
    pause(h)
    %Trajetória discrita pelo planeta:
    %Redimensionar as matrizes
    subplot(2,1,2)
    x_x = x(1:i);
    y_y = y(1:i);
    plot(x_x,y_y,'-b')
    title('Órbita de Mercúrio em torno do Sol-Método de Euler')
    %legend('Trajetória')
    text(0,0,'Sol')
    axis([-0.4 0.8 -0.6 0.6])
end

figure(2)
t=t(1:i); %Rediemnsionar t, de forma as matrizes coincidirem
vx = vx(1:i);
vy = vy(1:i);
vv=sqrt((vx).^2+(vy).^2);%Norma do vetor velocidade
Ec=(1/2)*((vv).^2);
plot(t,Ec,'.r')
title('Gráfico Ec=f(t)-Euler')
ylabel('Energia Cinética/M'); xlabel('T (tempo)')
hold on



f=sqrt(x.^2+y.^2);                                                         %Norma
afelio=max(f);                                                             %Máximo
perielio=min(f);                                                           %Mínimo

%Afélio: 0,466 697 e perielio: 0,307 499
af_tabelado=0.466697;
per_tabelado=0.307499;
%Cálculo do erro associado:

erro_af=(abs(af_tabelado-afelio)/af_tabelado)*100
erro_perielio=(abs(per_tabelado-perielio)/per_tabelado)*100

resultado_1= ['O afélio é igual a ',num2str(afelio),...
    '  UA, e o erro associado a este cálculo é  ', num2str(erro_af),'%']
resultado_2= ['O periélio é igual a ',num2str(perielio),...
    '  UA, e o erro associadoa este cálculo é  ', num2str(erro_perielio),'%']

