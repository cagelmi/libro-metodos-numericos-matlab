function problema_12
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "Métodos Numéricos
% Aplicados a Ingeniería: Casos de estudio en Ingeniería de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% Última revisión: 12/04/2024.

% Creación de la matriz A y su inversa
A = diag(4*ones(9,1))+diag(-1*ones(8,1),1)+diag(-1*ones(8,1),-1);
A(1,1) = 2;
Ainv = A^-1;
% Condición inicial
C = [76.1 40 40 40 40 40 40 40 60]';
% Recursión en el tiempo
for i = 1:5
    D(:,i) = Ainv*C;
    C = [56.1+D(1,i) 2*D(2:8,i)' 2*D(9,i)+20]';
end

% Gráfico 2-D
pos = 0:75:600; % mm
tpo = 0:24:120; % seg
C0 = 20*ones(9,1);
figure(1)
plot(pos,C0,'-k.',pos,D(:,1),'-ko',pos,D(:,2),'-k*',pos,D(:,3),'-k+',pos,...
    D(:,4),'-kx',pos,D(:,5),'-ks')
xlabel('Distancia (mm)')
ylabel('Temperatura (°C)')
legend('t = 0 (s)','t = 24 (s)','t = 48 (s)','t = 72 (s)','t = 96 (s)',...
    't = 120 (s)')

% Gráfico 3-D
figure(2)
surf(tpo,pos,[C0 D])
shading interp
xlabel('Tiempo (s)')
ylabel('Distancia (mm)')
zlabel('Temperatura (°C)')
