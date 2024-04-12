function problema_9
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "Métodos Numéricos
% Aplicados a Ingeniería: Casos de estudio en Ingeniería de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% Última revisión: 12/04/2024.

% Datos experimentales
tiempo = [0 1 2 3 4 5 6 7 9 11 14 19 24 29 39]';
xdata = [0 1.4 6.3 10.5 14.2 17.6 21.4 23 27 30.5 34.4 38.8 41.6 43.5 45.3]';

% Rutina de optimización
[params,resnorm,residual,exitflag] = lsqcurvefit(@integra,[1e-5 1e-3],tiempo,xdata)

% Graficos
[t,x] = ode15s(@modelo,tiempo,[0 0 0],[],params);
subplot(2,1,1)
plot(tiempo,xdata,'ko',t,x(:,1),'k','lineWidth',2)
ylabel('Concentración NO_2')
subplot(2,1,2)
AX = plotyy(t,x(:,2),t,x(:,3));
xlabel('Tiempo')
set(get(AX(1),'Ylabel'),'String','dx/dk_1','Color','k')
set(get(AX(2),'Ylabel'),'String','dx/dk_2','Color','k')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function valores_x = integra(params,tiempo)
[t,x] = ode15s(@modelo,tiempo,[0 0 0],[],params);
valores_x = x(:,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dx = modelo(t,x,params)
% Parámetros desconocidos
k1 = params(1);
k2 = params(2);
% Parámetros conocidos
a = 126.2;
b = 91.9;
% Modelo diferencial
dx = zeros(3,1);
dx(1) = k1*(a-x(1))*(b-x(1))^2-k2*x(1)^2;
dx(2) = -(k1*(b-x(1))^2+2*k1*(a-x(1))*(b-x(1))+2*k2*x(1))*x(2)+(a-x(1))*(b-x(1))^2;
dx(3) = -(k1*(b-x(1))^2+2*k1*(a-x(1))*(b-x(1))+2*k2*x(1))*x(3)-x(1)^2;
