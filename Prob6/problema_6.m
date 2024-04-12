function problema_6
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "Métodos Numéricos
% Aplicados a Ingeniería: Casos de estudio en Ingeniería de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% Última revisión: 11/05/2014.

% Datos experimentales
x = [0.10 0.15 0.25 0.50 0.75 1.00 1.50 3.00];
mu = [0.24 0.27 0.34 0.35 0.35 0.34 0.33 0.22];

 % Calcula los parámetros, residuos y el Jacobiano
[param,residuos,J] = nlinfit(x,mu,@modelo,[1 1 1]);
param

% Calcula los intervalos de confianza para los parámetros
ic_param = nlparci(param,residuos,J);
delta = (ic_param(:,2)-ic_param(:,1))/2

% Calcula los intervalos de confianza de las predicciones de mu
[mu_pred,ic_mu] = nlpredci(@modelo,x,param,residuos,J);

% Suma de error cuadrático
suma_error = sumsqr(residuos)

% Grafica intervalos de confianza
plot(x,mu,'ko',x,mu_pred,'k','LineWidth',2)
hold on
plot(x,mu_pred-ic_mu,'k','LineWidth',1)
plot(x,mu_pred+ic_mu,'k','LineWidth',1)
hold off
xlabel('x (g/l)')
ylabel('\mu (1/h)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function F = modelo(param, xdata)
F = (param(1)*xdata)./(param(2) + xdata + param(3)*xdata.^2);
