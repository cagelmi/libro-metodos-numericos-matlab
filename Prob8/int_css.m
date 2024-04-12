function y_exp = int_css(params,tiempo)
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "Métodos Numéricos
% Aplicados a Ingeniería: Casos de estudio en Ingeniería de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% Última revisión: 11/04/2024.

global t x

% Integra modelo diferencial
[t,x] = ode113(@css,tiempo,[4.7e-3 3.5e-3 0 0.18],[],params);
% Función de costo
y_exp = x(:,4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dx = css(t,x,params)

% Parámetros
yxs = params(1); ms = params(2);
mumax = 0.23; kd = 0.025;
k = 1.34e-4; yxni = 20.4;
kn = 7e-4;

% Ecuaciones diferenciales
% Biomasa activa
dx = zeros(4,1);
dx(1) = mumax*x(3)/(kn+x(3))*x(1)-kd*x(1);
% Urea y Nitrógeno intermediario
if x(2)>0
    dx(2) = -k;
    dx(3) = 0.47*k-mumax*x(3)/(kn+x(3))*x(1)/yxni;
else
    dx(2) = 0;
    dx(3) = 0-mumax*x(3)/(kn+x(3))*x(1)/yxni;
end
% Almidón
dx(4) = -mumax*x(3)/(kn+x(3))*x(1)/yxs-ms*x(1);
