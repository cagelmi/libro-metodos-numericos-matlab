function problema_2
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "Métodos Numéricos
% Aplicados a Ingeniería: Casos de estudio en Ingeniería de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% Última revisión: 19/03/2014.

% Resolución de las ecuaciones no lineales
% Letra a
disp('- Letra A:')
options = optimset('TolX',1e-8,'TolFun',1e-8,'Display','off');
c = fsolve(@prob2,[1 1 1],options,0.5)

% Letra b
disp('- Letra B:')
i = 1;
c0 = [1 1 1];
tau = 0.1:0.5:20;
for taui = tau
    c(i,:) = fsolve(@prob2,c0,options,taui);
    c0 = c(i,:); % fsolve usa como condición inicial la solución de la iteración anterior
    i = i+1;
end

% Grafica letra (b)
plot(tau,c(:,2),'k','lineWidth',2)
xlabel('\tau (min)')
ylabel('Concentración (mol/L)')

% Cálculo del valor máximo y su tiempo
[max_B pos_B] = max(c(:,2)) % valor máximo del compuesto B y su posición
tau_max_B = tau(pos_B)      % tiempo en el cual se alcanza el máximo valor de B

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ec = prob2(c,tau)

% Parámetros
k1 = 1;   % 1/min
k2 = 0.1; % 1/min
ca0 = 1;  % mol/L

% Ecuaciones algebraicas no lineales
ec(1) = (ca0-c(1))/tau - 2*k1*c(1)^2;
ec(2) = -c(2)/tau + k1*c(1)^2-k2*c(2);
ec(3) = -c(3)/tau + k2*c(2);
