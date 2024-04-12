function templado_css(vinicial)
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "Métodos Numéricos
% Aplicados a Ingeniería: Casos de estudio en Ingeniería de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% Última revisión: 12/04/2024.

global t x

load almidon.txt -ascii
tiempo = almidon(:,1);
almidon = almidon(:,2);

% Rutina de optimización
% Primera iteración
param = vinicial;
sum_error = sumsqr(almidon-int_css(param,tiempo));

% Algoritmo de búsqueda aleatoria
a = -0.025; b = 0.025; % Porcentaje máximo de variación de los parámetros
n_iter = 500; % número de iteraciones totales
for i = 1:n_iter
    ferror(i) = sum_error;
    x = a+(b-a)*rand(1,2);
    p1 = (1+x).*param;    
    sum_error_1 = sumsqr(almidon-int_css(p1,tiempo));
    if sum_error_1 < sum_error,
        param = p1;
        sum_error = sum_error_1;
    end
end

% Resultado
solucion = param
resnorm = sum_error

% Grafica resultados
figure(1)
plot(1:n_iter,ferror,'k','LineWidth',2)
xlabel('# iteración')
ylabel('Función error')
figure(2)
plot(tiempo,almidon,'ko',t,x(:,4),'k','LineWidth',2)
axis([0 150 0 0.3])
xlabel('Tiempo (h)')
ylabel('[Almidón]')
