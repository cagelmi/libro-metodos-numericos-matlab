function problema_7
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "Métodos Numéricos
% Aplicados a Ingeniería: Casos de estudio en Ingeniería de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% Última revisión: 12/04/2024.

% Cond. inicial para biomasa, glucosa y biomasa producida: Monod e Inhibición por sustrato
X0 = [0.75 2 0.75 2 0 0];
% X0 = [1 1 1 1 0 0];
% Integración del sistema diferencial
[t x] = ode15s(@bioreact,[0 30],X0);
 % Último valor del vector x
Ultimo_valor = x(end,:)
% Calculo de la biomasa total producida
Biomasa_producida_Monod = x(end,5)+1*(x(end,1)-X0(1))
Biomasa_producida_Inhibicion = x(end,6)+1*(x(end,3)-X0(3))

% Graficos
figure(1)
subplot(2,2,1)
plot(t,x(:,1),'k','LineWidth',2)
ylabel('Biomasa (g/L)')
title('Cinética de Monod')
subplot(2,2,2)
plot(t,x(:,2),'k','LineWidth',2)
ylabel('Glucosa (g/L)')
subplot(2,2,3)
plot(t,x(:,3),'k','LineWidth',2)
xlabel('Tiempo (h)'), ylabel('Biomasa (g/L)')
title('Inhibición por sustrato')
subplot(2,2,4)
plot(t,x(:,4),'k','LineWidth',2)
xlabel('Tiempo (h)'), ylabel('Glucosa (g/L)')

figure(2)
plot(t,x(:,5),'k','LineWidth',2)
hold on
plot(t,x(:,6),'k-.','LineWidth',1)
hold off
xlabel('Tiempo (h)')
ylabel('Biomasa que ha abandonado al biorreactor (g)')
legend('Cinética de Monod','Inhibición por sustrato','Location','Best')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dx = bioreact(t,x)

% Parámetros
mumax = 0.53;   % (1/h)
km = 0.12;      % (g/L)
k1 = 0.45;      % (L/g)
Y = 0.4;        %
x2f = 4.0;      % (g/L)
D = 0.30;       % (1/h)
V = 1;          % (L)

% Velocidades específicas de crecimiento:
mu1 = mumax*x(2)/(km+x(2));
mu2 = mumax*x(4)/(km+x(4)+k1*x(4)^2);

% Variables de estado: cinética de Monod 
dx = zeros(6,1);
dx(1) = (mu1-D)*x(1);
dx(2) = D*(x2f-x(2))-mu1*x(1)/Y;
% Variables de estado: inhibición por sustrato
dx(3) = (mu2-D)*x(3);
dx(4) = D*(x2f-x(4))-mu2*x(3)/Y;
% Biomasa que abandona el biorreactor
dx(5) = D*V*x(1);
dx(6) = D*V*x(3);
