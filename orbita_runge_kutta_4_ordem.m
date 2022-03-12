close all
clc;
global Gms
Gms = 4*(pi)^2;
h=0.001;
t = 0:h:0.5;
 tic                                       
%Condi��es Iniciais
y(1) = 0; vx(1) = 0;vy(1) = 8.2;  x(1) = 0.47;

for i=1:numel(t)-1
    
    r1_v=-Gms/(norm([x(i) y(i)])^3)*[x(i) y(i)];
    r1_r=[vx(i) vy(i)];
    
    
    r2_v=-Gms/(norm([x(i) y(i)]+h/2*r1_r)^3).*([x(i) y(i)]+r1_r*h/2);
    r2_r=[vx(i) vy(i)]+r1_v*h/2;

    r3_v=-Gms/(norm([x(i) y(i)]+h/2*r2_r)^3).*([x(i) y(i)]+r2_r*h/2);
    r3_r=[vx(i) vy(i)]+r2_v*h/2;
    
    r4_v=-Gms/(norm([x(i) y(i)]+h*r3_r)^3).*([x(i) y(i)]+r3_r*h);
    r4_r=[vx(i) vy(i)]+r3_v*h;

    %Atualiza��o da trajet�ria
    A= [x(i) y(i)]+h/6*(r1_r+2*r2_r+2*r3_r+r4_r);
    
    B= [vx(i) vy(i)]+h/6*(r1_v+2*r2_v+2*r3_v+r4_v);
    
    x(i+1)=A(1);
    y(i+1)=A(2);
    vx(i+1)=B(1);
    vy(i+1)=B(2);
    
    disp(t(i));
    
    figure(1)
    subplot(2,1,1)
    plot(x(i),y(i),'.k');
    axis([-0.35 0.5 -0.5 0.5]);
    title('Runge-Kutta 4� ordem')
    xlabel('x(AU)'); ylabel('y(AU)');
    pause(h)
    
    %Trajet�ria discrita pelo planeta:
    subplot(2,1,2)
    x_x = x(1:i);
    y_y = y(1:i);
    plot(x_x,y_y,'-b')
    legend('Trajet�ria')

    title('�rbita de Merc�rio em torno do Sol-RK4')
    text(0,0,'Sol')
    axis([-0.4 0.6 -0.5 0.5])
end
toc

figure(2)
%Energia Cin�tica
t=t(1:i);                                                                  %Rediemnsionar t, de forma as matrizes coincidirem
vx = vx(1:i);
vy = vy(1:i);
vv=sqrt((vx).^2+(vy).^2);                                                  %Norma do vetor velocidade
Ec=(1/2)*((vv).^2);
plot(t,Ec,'.r')
title('Gr�fico Ec=f(t)-RK4')
ylabel('Energia Cin�tica/M'); xlabel('T (tempo)')
hold on

f=sqrt(x.^2+y.^2);                                                         %Norma
afelio=max(f)                                                              %Dist�ncia m�nima ao Sol
perielio=min(f)                                                            %Dist�ncia m�xima ao Sol
%Valores Tabelados: af�lio: 0,466 697 e perielio: 0,307 499
af_tabelado=0.466697; per_tabelado=0.307499;
%C�lculo do erro associado:
erro_af=(abs(af_tabelado-afelio)/af_tabelado)*100;
erro_perielio=(abs(per_tabelado-perielio)/per_tabelado)*100;

resultado_1= ['O af�lio � igual a ',num2str(afelio),...
    '  UA, e o erro associado a este c�lculo �  ', num2str(erro_af),'%']
resultado_2= ['O peri�lio � igual a ',num2str(perielio),...
    '  UA, e o erro associadoa este c�lculo �  ', num2str(erro_perielio),'%']
