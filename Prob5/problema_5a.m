function problema_5a
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "Métodos Numéricos
% Aplicados a Ingeniería: Casos de estudio en Ingeniería de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% Última revisión: 12/04/2024.

% Método de ajuste lineal: polyit
R = 1.987; % cal/gmol*K
k = [0.0014 0.0026 0.0047 0.0083 0.014 0.023 0.038 0.059 0.09]; % Datos experimentales
T = 300:10:380;
invT = 1./T;
y = log(k);

% Ajuste de ecuación de la recta usando polyfit de orden 1
p = polyfit(invT,y,1);

% Comparación gráfica entre modelo lineal y datos experimentales
subplot(2,1,1)
plot(invT,y,'ko',invT,polyval(p,invT),'k','LineWidth',2)
xlabel('1/Temperatura (1/K)')
ylabel('ln(k)')
subplot(2,1,2)
T1 = 300:5:380; % Calcula más valores de tiempo
plot(T,k,'ko',T1,exp(p(1,2))*exp(p(1,1)*1./T1),'k','LineWidth',2)
xlabel('Temperatura (K)')
ylabel('k (1/min)')

% Despliegue de resultados
disp(['A = ' int2str(exp(p(1,2))) ' (1/min)'])
disp(['E = ' int2str(-p(1,1)*R) ' (cal/gmol)'])

% Error cuadrático entre el modelo y datos experimentales
kmoderror = exp(p(1,2))*exp(p(1,1)*invT);
error = sumsqr(k-kmoderror);
disp(['error = ' num2str(error)])

% Método usando optimización: lsqcurvefit
[x resnorm] = lsqcurvefit(@modelo,[500000 1e4],T,k)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function F = modelo(x,xdata)
R = 1.987; % cal/gmol*K
F = x(1)*exp(-x(2)./(R*xdata));
