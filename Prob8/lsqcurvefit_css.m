function lsqcurvefit_css(vinicial)
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "Métodos Numéricos
% Aplicados a Ingeniería: Casos de estudio en Ingeniería de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% Última revisión: 12/04/2024.

% Para rescatar los valores y graficar en la rutina de optimizacion
global t x

% Lectura de datos experimentales
load almidon.txt -ascii
tiempo = almidon(:,1);
almidon = almidon(:,2);

% Rutina de optimización
options = optimset('display','iter','TolFun',1e-8);
[params,resnorm,residual,exitflag] = lsqcurvefit('int_css',vinicial,tiempo,...
    almidon,[],[],options)

% Comparación gráfica entre datos experimentales y simulación
plot(tiempo,almidon,'ko',t,x(:,4),'k','LineWidth',2)
axis([0 150 0 0.30])
xlabel('Tiempo (h)')
ylabel('[Almidón]')
