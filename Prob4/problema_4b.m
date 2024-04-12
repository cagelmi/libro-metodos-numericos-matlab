function problema_4b
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "Métodos Numéricos
% Aplicados a Ingeniería: Casos de estudio en Ingeniería de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% Última revisión: 11/05/2014.

% Integración del sistema diferencial
[t,x] = ode15s(@est,[0 500],[2 5 1e-8]);

% Grafica
subplot(2,1,1)
plot(t,x(:,1),'k','LineWidth',2)
hold on
plot(t,x(:,2),'k-.','LineWidth',2)
hold off
ylabel('Altura (m)')
legend('h_1','h_2','Location','Best')
subplot(2,1,2)
plot(t,x(:,3),'k','LineWidth',2)
xlabel('Tiempo (s)')
ylabel('Velocidad (m/s)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dx = est(t,x)

% Parámetros y constantes
cv = 0.1; D1 = 2.5; D2 = 3.0; Dt = 0.3;
F0 = 0.2*0; g = 9.8; h1max = 4.0;
L = 100; mu = 0.001; ro = 1000;

% Relaciones constitutivas
A1 = pi*D1^2/4; A2 = pi*D2^2/4; At = pi*Dt^2/4;
Re = Dt*ro*abs(x(3))/mu;
F2 = cv*x(2)^0.5*0;
if Re <= 2000
    f = 64/Re;
else
    f = 0.18/Re^0.2;
end

% Ecuaciones diferenciales
dx = zeros(3,1);
dx(1) = (F0-x(3)*At)/A1;
dx(2) = (x(3)*At-F2)/A2;
dx(3) = g/L*(x(1)-x(2))-0*f*x(3)*abs(x(3))/(2*Dt);
