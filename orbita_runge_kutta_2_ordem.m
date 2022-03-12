close all
clc;

global Gms

Gms = 4*(pi)^2;
h=0.001;
t = 0:h:0.5;
                                        
%Condi��es Iniciais
y(1) = 0; 
vx(1) = 0;
vy(1) = 8.2;  
x(1) = 0.47; 

for i=1:numel(t)-1

    r1_x=vx(i);
    r1_y=vy(i);
    
    r1_vx=-Gms/(norm([x(i) y(i)])^3)*x(i);
    r1_vy=-Gms/(norm([x(i) y(i)])^3)*y(i);
    
    
    r2_vx=-Gms/(norm([x(i)+r1_x*h/2 y(i)+r1_y*h/2])^3).*(x(i)+r1_x*h/2);
    r2_vy=-Gms/(norm([x(i)+r1_x*h/2 y(i)+r1_y*h/2])^3).*(y(i)+r1_y*h/2);
    
    r2_x=vx(i)+r1_vx*h/2;
    r2_y=vy(i)+r1_vy*h/2;
    
    %Atualiza��o da trajet�ria
    %Vetor posi��o:
    x(i+1) = x(i)+r2_x*h;
    y(i+1) = y(i)+r2_y*h;
    %Vetor velocidade:
    vx(i+1) = vx(i)+r2_vx*h;
    vy(i+1) = vy(i)+r2_vy*h;
    %Update: Anima��o
    x_x = x(1:i);
    y_y = y(1:i);
    figure(1)
    subplot(2,1,1)
    plot(x(i),y(i),'.k');
    axis([-0.35 0.5 -0.5 0.5]);
    title('Runge-Kutta 2� ordem');
    xlabel('x(AU)'); ylabel('y(AU)');
    pause(h)
    
    %Trajet�ria discrita pelo planeta:
    
    subplot(2,1,2)
    x_x = x(1:i);
    y_y = y(1:i);
    plot(x_x,y_y,'-b')
    hold on
    %legend('Trajet�ria')
    title('�rbita de Merc�rio em torno do Sol-RK2')
    text(0,0,'Sol')
    axis([-0.4 0.6 -0.5 0.5])
end

figure(2)
%Energia Cin�tica
t=t(1:i);                                                                  %Rediemnsionar t, de forma as matrizes coincidirem
vx = vx(1:i);
vy = vy(1:i);
vv=sqrt((vx).^2+(vy).^2);                                                  %Norma do vetor velocidade
Ec=(1/2)*((vv).^2);
plot(t,Ec,'.r')
title('Gr�fico Ec=f(t)-Euler')
ylabel('Energia Cin�tica/M'); xlabel('T (tempo)')
hold on

%C�lculo das dis m�s/min 
f=sqrt(x_x.^2+y_y.^2);                                                     %Norma
afelio=max(f);                                                             %Dist�ncia m�nima ao Sol
perielio=min(f);                                                           %Dist�ncia m�xima ao Sol
%Segundo o wikip�dia: af�lio: 0,466 697 e perielio: 0,307 499
af_tabelado=0.466697; per_tabelado=0.307499;

%C�lculo do erro associado:
erro_af=(abs(af_tabelado-afelio)/af_tabelado)*100;
erro_perielio=(abs(per_tabelado-perielio)/per_tabelado)*100;
resultado_1= ['O af�lio � igual a ',num2str(afelio),...
    '  UA, e o erro associado a este c�lculo �  ', num2str(erro_af),'%']
resultado_2= ['O peri�lio � igual a ',num2str(perielio),...
    '  UA, e o erro associadoa este c�lculo �  ', num2str(erro_perielio),'%']
