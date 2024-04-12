function problema_5b
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "Métodos Numéricos
% Aplicados a Ingeniería: Casos de estudio en Ingeniería de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% Última revisión: 12/04/2024.

% Datos experimentales
x = [0.10 0.15 0.25 0.50 0.75 1.00 1.50 3.00]';
mu = [0.24 0.27 0.34 0.35 0.35 0.34 0.33 0.22]';

% Resolución del modelo lineal
Y = 1./mu;
fi = [x 1./x ones(8,1)];
theta = fi\Y; % = (fi'*fi)^-1*fi'*Y
disp('- Método usando el modelo lineal:')
mu_max = 1/theta(3,1)
k1 = mu_max*theta(1,1)
km = mu_max*theta(2,1)

% Grafica resultados
model1 = 1./(theta(1,1)*x+theta(2,1)./x+theta(3,1));
plot(x,mu,'ko',x,model1,'k*-')
xlabel('x (g/l)')
ylabel('\mu (1/h)')

% Suma error cuadrático
error = sumsqr(mu-model1)

% Método usando la función lsqcurvefit
[param resnorm] = lsqcurvefit(@modelo,[1 1 1], x, mu);
disp('- Método usando la función lsqcurvefit:')
mu_max = param(1)
km = param(2)
kl = param(3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function F = modelo(param,xdata)
F = (param(1)*xdata)./(param(2)+xdata+param(3)*xdata.^2);
