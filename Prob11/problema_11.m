function problema_11
% Para ser utilizado con el texto H. Jorquera y C. Gelmi "Métodos Numéricos
% Aplicados a Ingeniería: Casos de estudio en Ingeniería de Procesos usando
% MATLAB", Ediciones UC, 2014.
%
% Última revisión: 12/04/2024.

% Parámetros físicos
ro = 2500; cp = 100;
hc = 15; h = 4;
d = 0.01; w = 0.005;
Tc = 318.16; Th = 356.16;

% Rutina de optimización
options = optimset('TolX',1e-8,'TolFun',1e-8);
[condInicial,fval,exitflag] = fminunc(@int_tambor,325,options,cp,d,h,hc,...
    ro,Tc,Th,w)

% Grafica el perfil de temperatura
[ang1,T1] = ode15s(@cara1,[0 pi],condInicial,options,cp,d,h,hc,ro,Tc,Th,w);
[ang2,T2] = ode15s(@cara2,[pi 2*pi],T1(end,1),options,cp,d,h,hc,ro,Tc,Th,w);
angulo = [ang1; ang2];
Temp = [T1; T2]
plot(angulo,Temp(:,1),'k','LineWidth',2)
xlabel('Ángulo (radianes)')
ylabel('Temperatura (K)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fcosto = int_tambor(condInicial,cp,d,h,hc,ro,Tc,Th,w)
[ang1, T1] = ode15s(@cara1,[0 pi],condInicial,[],cp,d,h,hc,ro,Tc,Th,w);
[ang2, T2] = ode15s(@cara2,[pi 2*pi],T1(end,1),[],cp,d,h,hc,ro,Tc,Th,w);
% Función objetivo a minimizar
fcosto = (condInicial-T2(end,1))^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dz = cara1(ang,z,cp,d,h,hc,ro,Tc,Th,w)
% Ecuaciones diferenciales: cara expuesta al aire caliente
dz = h*(Th-z(1))/(cp*d*ro*w);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dz = cara2(ang,z,cp,d,h,hc,ro,Tc,Th,w)
% Ecuaciones diferenciales: cara expuesta al lqdo. refrigerante
dz = -hc*(z(1)-Tc)/(cp*d*ro*w);
