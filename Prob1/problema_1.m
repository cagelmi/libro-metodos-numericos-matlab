function problema_1
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "Métodos Numéricos
% Aplicados a Ingeniería: Casos de estudio en Ingeniería de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% Última revisión: 19/03/2024.

% Integración de las ecuaciones diferenciales
[t c] = ode45(@prob1,[0 8],[1 0 0]);

% Gráficos
plot(t,c(:,1),'k','lineWidth',1)
hold on
plot(t,c(:,2),'k','lineWidth',2)
plot(t,c(:,3),'k--','lineWidth',1)
hold off
axis([0 5 0 1])
xlabel('Tiempo (h)')
ylabel('Concentración (mol/L)')
legend('A','B','C')

% Cálculo de la concentración máxima de B y tiempo de ocurrencia
[max_B pos_B] = max(c(:,2)) % valor máximo del compuesto B y su posición
tpo_max_B = t(pos_B)        % tiempo en el cual se alcanza el máximo valor de B

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dc = prob1(t,c)

% Parámetros del modelo
k1f = 2;  % 1/h
k1r = 1;  % 1/h
k2 = 1.5; % 1/h Este es el valor que cambiamos para la letra (b)

% Ecuaciones diferenciales
dc = zeros(3,1);
dc(1) = -k1f*c(1)+k1r*c(2);
dc(2) = k1f*c(1)-(k1r+k2)*c(2);
dc(3) = k2*c(2);
