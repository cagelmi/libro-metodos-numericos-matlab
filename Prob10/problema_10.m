function problema_10
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "Métodos Numéricos
% Aplicados a Ingeniería: Casos de estudio en Ingeniería de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% Última revisión: 12/04/2024.

% Parámetros
T0 = 373.15;        % K
h = 10;             % W/m^2*K
Ta = 273.15 + 10;   % K
k = [382 14.9 204 62.3]; % [Cobre Acero Aluminio Fierro]

% Rutina de optimización
[param,fval,exitflag] = fminunc(@aleta,-1000*ones(1,4),[],h,Ta,T0,k)

% Gráficos
% Se integran los modelos para obtener los valores de las gráficas
[r1,T1] = ode15s(@modelo,[0.01 0.1],[T0 param(1) 0],[],k(1),h,Ta);
[r2,T2] = ode15s(@modelo,[0.01 0.1],[T0 param(2) 0],[],k(2),h,Ta);
[r3,T3] = ode15s(@modelo,[0.01 0.1],[T0 param(3) 0],[],k(3),h,Ta);
[r4,T4] = ode15s(@modelo,[0.01 0.1],[T0 param(4) 0],[],k(4),h,Ta);
figure(1)
plot(r1,T1(:,1)-273.15,'k',r2,T2(:,1)-273.15,'ko-',r3,T3(:,1)-273.15,'k+-',r4,...
    T4(:,1)-273.15,'k*-')
xlabel('r (m)')
ylabel('Temperatura (°C)')
legend('Cobre','Acero','Aluminio','Fierro','Location','Best')
figure(2)
plot(r1,T1(:,3),'k',r2,T2(:,3),'ko-',r3,T3(:,3),'k+-',r4,T4(:,3),'k*-'),
xlabel('r (m)')
ylabel('Calor perdido entre 0 a r (Watts)')
legend('Cobre','Acero','Aluminio','Fierro',location='best')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fcosto = aleta(param,h,Ta,T0,k)
% Integración del modelo diferencial
[r1,T1] = ode15s(@modelo,[0.01 0.1],[T0 param(1) 0],[],k(1),h,Ta);
[r2,T2] = ode15s(@modelo,[0.01 0.1],[T0 param(2) 0],[],k(2),h,Ta);
[r3,T3] = ode15s(@modelo,[0.01 0.1],[T0 param(3) 0],[],k(3),h,Ta);
[r4,T4] = ode15s(@modelo,[0.01 0.1],[T0 param(4) 0],[],k(4),h,Ta);

% Función objetivo escrita elemento por elemento
% (-k*dT/dr(r=R1)=h*(T(R1)-Ta))^2
fcosto(1) = (k(1)*T1(end,2)+h*(T1(end,1)-Ta))^2;
fcosto(2) = (k(2)*T2(end,2)+h*(T2(end,1)-Ta))^2;
fcosto(3) = (k(3)*T3(end,2)+h*(T3(end,1)-Ta))^2;
fcosto(4) = (k(4)*T4(end,2)+h*(T4(end,1)-Ta))^2;
fcosto = sum(fcosto);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dz = modelo(r,z,k,h,Ta)

% Parámetro
B = 0.001; % m

% Ecuaciones diferenciales
dz = zeros(3,1);
dz(1) = z(2);
dz(2) = -1/r*z(2)+2*h/(B*k)*(z(1)-Ta);
dz(3) = 4*pi*r*h*(z(1)-Ta);
