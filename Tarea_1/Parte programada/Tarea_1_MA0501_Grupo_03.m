%% Portada 
% Universidad de Costa Rica
% Departamento de Matematica Pura 
% Analisis numerico I

% Tarea 1

% Profesor:
% Esteban Segura Ugalde 

% Estudiantes:
% Alexandra Gonzalez Bermudez, C4F535
% Emily Estefania Mora Contreras, C4H522
% Jose Miguel Rodriguez Gomez, C4J104
% Daniela Prado Vargas, C26070

% Segundo semestre 
% 2026

%% Solucion de incisos: calculos a partir de las funciones creadas
%% Ejercicio 1
% Prueba de la funcion del ejercicio 1 Division_Multiples_Secciones:

f_1 = @(x) exp(x) -2*x - 1; % funcion para el metodo
disp('Resultado del ejercicio 1:')
Division_Multiples_Secciones(f_1, 1, 2, 10, 10^-10)
%% Ejercicio 2
% Prueba de la funcion del ejercicio 2 metodo_gradiente_conjugado. 

%Se define la matriz A_2, a partir del archivo descargado 
load('bcsstk06.mat');
A_2 = Problem.A;

% Se definen las variables solicitadas 
b_2 = A_2 * (1 : length(A_2))';
D_2 = diag(diag(A_2));
L_2 = tril(A_2,-1);
U_2 = triu(A_2,1);
M1_2 = D_2;
M2_2 = (D_2 + L_2) * (D_2 \ (D_2 + U_2));
x0_2 = zeros(length(A_2),1);
tol_2 = 10^-6;

% Se ejecuta la funcion con M1
[x_M1, errores_M1] = metodo_gradiente_conjugado(A_2, b_2, x0_2, M1_2, tol_2);
% Se muestran los resultados obtenidos con M1
disp('Resultado del ejercicio 2 con la matriz M1:')
% Se busca corregir el formato para que la solucion se imprima 
% de manera agradable
fprintf('Aproximacion de la solucion:\n');
for i = 1:length(x_M1)
    fprintf('x(%d) = %.10e\n', i, x_M1(i));
end

disp('Errores absolutos de cada iteracion:')
fprintf('Iteracion     Error absoluto\n');
% Se busca corregir el formato para que el numero de iteracion se imprima 
% de manera agradable
for i = 1:size(errores_M1,1)
    fprintf('%5d        %.10e\n', errores_M1(i,1), errores_M1(i,2));
end

% Se ejecuta la funcion con M2
[x_M2, errores_M2] = metodo_gradiente_conjugado(A_2, b_2, x0_2, M2_2, tol_2);
% Se muestran los resultados obtenidos con M2
disp('Resultado del ejercicio 2 con la matriz M2:')
% Se busca corregir el formato para que la solucion se imprima 
% de manera agradable
fprintf('Aproximacion de la solucion:\n');
for i = 1:length(x_M2)
    fprintf('x(%d) = %.10e\n', i, x_M2(i));
end

disp('Errores absolutos de cada iteracion:')
fprintf('Iteracion     Error absoluto\n');
% Se busca corregir el formato para que el numero de iteracion se imprima 
% de manera agradable
for i = 1:size(errores_M2,1)
    fprintf('%5d        %.10e\n', errores_M2(i,1), errores_M2(i,2));
end

% Se construye el grafico de los errores
figure
% Se grafican los errores bajo M1
% Se grafica el numero de iteraciones en el eje x y los errores en el eje y
% El gráfico se presenta con escala logaritmica en el eje y 
semilogy(errores_M1(:,1), errores_M1(:,2), '-')
% Para seguir dibujando sobre el mismo grafico
hold on
% Se grafican los errores bajo M2
% Se grafica el numero de iteraciones en el eje x y los errores en el eje y
% El gráfico se presenta con escala logaritmica en el eje y
semilogy(errores_M2(:,1), errores_M2(:,2), '-')

% Se añaden las etiquetas 
xlabel('Numero de iteración')
ylabel('Error absoluto: ||b - Ax_k||')
title('Errores absolutos por iteración bajo M1 y M2')

legend('M1', 'M2')
grid on
hold off

% Se ejecuta el metodo Gauss Seidel 
iteMax_gauss = 500;
disp('Resultados bajo el metodo Gauss Seidel')
[aproximaciones_GS, errores_GS] = metodoGaussSeidel(A_2, b_2, x0_2, tol_2, iteMax_gauss);

% Se muestran los resultados obtenidos con Gauss Seidel
disp('Errores absolutos de cada iteracion GS:')
disp(errores_GS)


%% Ejercicio 4
% Prueba de la funcion del ejercicio 4e Raiz_Cubica_21:
disp('Resultado del ejercicio 4e:')
A_4 = Raiz_Cubica_21(1, 10^-6)

%% Ejercicio 7
% Prueba de la función del ejercicio 7 Método de Raíz Múltiple
p_7   = @(x) (x^2 + 9) * (x - 3)^4; % Se usa el subindice 7 pues es el polinomio del ejercicio 7, se hace para evitar sobreescritura de datos
dp_7 = @(x) 2*x*(x - 3)^4 + 4*(x - 3)^3 * (x^2 + 9); % Primer derivada del polinomio
d2p_7 =  @(x) 2*(x - 3)^4 + 16*x*(x - 3)^3 + 12*(x - 3)^2 * (x^2 + 9); % Segunda derivada del polinomio 
disp('Resultado del ejercicio 7d:')
metodo_Raiz_Multiple(p_7,dp_7,d2p_7,0,10^-10,100)

%% Ejercicio 8
% Inciso a

f_8 = @(x_8) 816*x_8.^3 - 3835*x_8.^2 + 6000*x_8 - 3125;

c1_8 = fzero(f_8,[1.4,1.5]);
c2_8 = fzero(f_8,[1.55,1.6]);
c3_8 = fzero(f_8,[1.65,1.7]);

format rational
raices_8 = [c1_8; c2_8; c3_8];

disp('Resultado del ejercicio 8a:')
disp('Raices aproximadas con fzero =');
disp(raices_8);

% Verificacion
disp('Valores de f en las raices aproximadas =');
disp(f_8(raices_8));


% Inciso b
format long
df_8 = @(x_8) 2448*x_8.^2 - 7670*x_8 + 6000;
x0_8 = linspace(1.4,1.7);
tol_8 = 1e-10;
iteMax_8 = 100;

convergencia_8 = NaN(size(x0_8)); % Se guarda el resultado

for j_8 = 1:length(x0_8)

    M_8 = metodoNewton(f_8,df_8,x0_8(j_8),tol_8,iteMax_8);
    raizNewton_8 = M_8(end,1);

    % Verificacion
    if abs(f_8(raizNewton_8)) < tol_8
        convergencia_8(j_8) = raizNewton_8;
    end
end

% Grafica
figure;
plot(x0_8,convergencia_8,'.','MarkerSize',12);
xlabel('Valor inicial x_0');
ylabel('Raiz a la que converge Newton');
title('Ejercicio 8b: convergencia del metodo de Newton');
yticks(raices_8);
grid on;

disp('Resultado del ejercicio 8b:')
disp('Cantidad de valores iniciales sin convergencia verificada =');
disp(sum(isnan(convergencia_8)));

% Inciso c
format long
d2f_8 = @(x_8) 4896*x_8 - 7670;

df_raices_8 = df_8(raices_8);
d2f_raices_8 = d2f_8(raices_8);

radios_8 = abs(2*df_raices_8 ./ d2f_raices_8);

inferior_8 = raices_8 - radios_8;
superior_8 = raices_8 + radios_8;

disp('Resultado del ejercicio 8c:')
disp('Radios estimados de atraccion =');
disp(radios_8);

disp('Intervalos estimados: extremo inferior y extremo superior =');
disp([inferior_8(:), superior_8(:)]);

%% Ejercicio 10
% Inciso b
t_10 = [0; 0.2; 0.4; 0.6; 0.8];
Ti_10 = [37; 36.72; 36.41; 36.12; 35.90];

T_10 = @(k_10) 21 + 16*exp(-k_10*t_10); % modelo dado
r_10 = @(k_10) T_10(k_10) - Ti_10;

% Derivadas
dr_10 = @(k_10) -16*t_10.*exp(-k_10*t_10);
d2r_10 = @(k_10) 16*t_10.^2.*exp(-k_10*t_10);

% Funcion objetivo y sus derivadas
f_10 = @(k_10) sum(r_10(k_10).^2);

df_10 = @(k_10) 2*sum(r_10(k_10).*dr_10(k_10));

d2f_10 = @(k_10) 2*sum(dr_10(k_10).^2 + r_10(k_10).*d2r_10(k_10));

kInicial_10 = 0.2; % parametros para utilizar la funcion
tol_10 = 1e-10;
iteMax_10 = 100;

% Resolver f'(k) = 0
M_10 = metodoNewton(df_10,d2f_10,kInicial_10,tol_10,iteMax_10); % reutilizamos la funcion programada en el ejercicio 8
k_10 = M_10(end,1);

disp('Resultado del ejercicio 10b:')
disp('Columnas: aproximacion de k y cambio absoluto');
disp(M_10);

disp('k (horas^-1) =');
disp(k_10);

disp('f(k) =');
disp(f_10(k_10));

disp('Primera derivada =');
disp(df_10(k_10));

disp('Segunda derivada =');
disp(d2f_10(k_10));

% Verificacion
if abs(df_10(k_10)) < tol_10 && d2f_10(k_10) > 0
    disp('Se verifico numericamente un minimo local estricto.');
else
    disp('Revisar la convergencia y el criterio de minimo.');
end

% Inciso c

Ta_c_10 = 31;     
T0_c_10 = 37;     
Tmedida_c_10 = 34; 

% Despejar el tiempo
tiempo_c_10 = -log((Tmedida_c_10-Ta_c_10)/(T0_c_10-Ta_c_10))/k_10;

disp('Resultado del ejercicio 10c:')
disp('Tiempo transcurrido desde el fallecimiento (horas) =');
disp(tiempo_c_10);

% Verificacion
Tcomprobacion_c_10 = Ta_c_10 + (T0_c_10-Ta_c_10)*exp(-k_10*tiempo_c_10);

disp('Temperatura calculada para ese tiempo (grados Celsius) =');
disp(Tcomprobacion_c_10);

%% Ejercicio 11

% Prueba de la funcion del ejercicio 11, inciso c: factorizacionLU_pivoteo_total:

A_11 = [0 8 -2; 1 -3 6; 5 -15 25];
disp('Resultado del ejercicio 11 c:')
[P_11,Q_11,L_11,U_11] = factorizacionLU_pivoteo_total(A_11)

%% Ejercicio 12

% Inciso f

% La funcion solicitada se encuentra en el apartado de funciones, situado 
% mas abajo en este documento.



%% Ejercicio 15

f_15 = @(x_15) 16*x_15^4 - 40*x_15^3 + 5*x_15^2 + 20*x_15 + 6;
x0_muller = 1/2;
x1_muller = -1/2;
x2_muller = 0;

% Seccion de verificacion de la funcion
% Se prueba la funcion para el reusltado desarrollado en el inciso b
iteMax_15_prueba = 1;
[x3_muller_prueba, x3_error_muller_prueba] = metodoMuller(f_15, x0_muller, x1_muller, x2_muller, iteMax_15_prueba);
disp('Resultado de la prueba de la funcion. Ejercicio 15, inciso b')
disp('Aproximacion de x3:');
%Se busca corregir el formato del numero de iteracion para que se 
% imprima de manera agradable
for i = 1:size(x3_muller_prueba,1)
    fprintf('%d   %.6f %+.6fi\n', ...
        x3_muller_prueba(i,1), ...
        real(x3_muller_prueba(i,2)), ...
        imag(x3_muller_prueba(i,2)));
end
disp('Error absoluto de la iteracion');
%Se busca corregir el formato del numeros de iteracion y del valor del error, 
% para que se impriman de manera agradable
for i = 1:size(x3_error_muller_prueba,1)
    fprintf('%d   %.6f\n', ...
        real(x3_error_muller_prueba(i,1)), ...
        real(x3_error_muller_prueba(i,2)));
end


% Inciso d
iteMax_15_d = 6;

% Se calcula la aproximacion x8 a partir de la funcion creada
[x8_muller, x8_errores_muller] = metodoMuller(f_15, x0_muller, x1_muller, x2_muller, iteMax_15_d);

disp('Resultado del ejercicio 15, inciso c:')
disp('Tabla de aproximaciones en cada iteracion hasta obtener x8:');
%Se busca corregir el formato de los numeros de iteracion para que se 
% impriman de manera agradable
for i = 1:size(x8_muller,1)
    fprintf('%d   %.6f %+.6fi\n', ...
        x8_muller(i,1), ...
        real(x8_muller(i,2)), ...
        imag(x8_muller(i,2)));
end
disp('Tabla de errores absolutos en cada iteracion hasta obtener x8:');
%Se busca corregir el formato de los numeros de iteracion y de los valores 
% de los errores, para que se impriman de manera agradable
for i = 1:size(x8_errores_muller,1)
    fprintf('%d   %.6f\n', ...
        real(x8_errores_muller(i,1)), ...
        real(x8_errores_muller(i,2)));
end



%% Solucion de incisos: creacion de funciones 

%% Ejercicio 1

function[A] = Division_Multiples_Secciones(f,a,b,n,tol)
% Se va a aproximar la solucion de f(x) = 0 usando el metodo de Division en
% Multiples Secciones
% Entradas:         f ---- Funcion continua en el intervalo [a,b]
%               [a,b] ---- Intervalo de busqueda de la solucion
%                   n ---- Numero de subintervalos en los que se va a partir el intervalo [a,b]
%                 tol ---- Numero pequeño para detener el programa 
% Salidas:          A ---- Matriz la cual contendrá en la primer columna las aproximaciones en cada iteracion; en la segunda columna el error en la respectiva iteracion y en la tercer y cuarta columnas los valores a y b del nuevo intervalo

if (f(a) * f(b) > 0)
    error('El metodo no va a funcionar ya que la funcion no tiene ninguna raiz en el intervalo dado');
end 

er = abs(a-b);
cont = 1;
A(cont,1) = (a+b)/2;
A(cont,2) = er;
A(cont,3) = a;
A(cont,4) = b;

while (er > tol)
    subintervalos = [a];
    for i = 1:(n)
        subintervalos = [subintervalos,a + (i * ((b-a)/n))];
    end 

    for j = 1:n
        if (f(subintervalos(j)) * f(subintervalos(j+1)) < 0)
            a = subintervalos(j);
            b = subintervalos(j+1);
            break; % Hacer que termine el for ya que se encontro un intervalo que cumple, de esta forma se toma el primer subintervalo en el que el producto de los extremos evaluados sea negativo
        end
    end
    x = (a+b)/2;
    A(cont+1,1) = x;
    er = abs(a-b);
    A(cont+1,2) = er;
    A(cont+1,3) = a;
    A(cont+1,4) = b;
    cont = cont + 1;
end
end

%% Ejercicio 2

%Metodo iterativo de gradiente conjugado con precondicionador 

function[x, res] = metodo_gradiente_conjugado(A, b, x0, M, tol)
% Funcion para aproximar la solucion de Ax = b con el metodo de la
% gradiente conjugado 

% Entradas:         A --- matriz en R^{nxn}, simetrica y definida positiva 
%                   b --- vector de constantes en R^{n}
%                  x0 --- aproximacion inicial
%                   M --- matriz que precondiciona el sistema
%                 tol --- tolerancia para detener el programa 
% Salidas:          x --- aproximacion final de la solucion del sistema 
%                 res --- vector columna de los errores absolutos  (∥b − Axk∥) 
%                         en cada iteracion

% Se revisa la simetria y la definicion positiva 
simetria = issymmetric(A);
if simetria == 0
    error("La matriz ingresada no es simetrica")
end 

valores_propios = eig(A);
if ~all(valores_propios > 0)
    error("La matriz ingresada no es definida positiva")
end

% Se definen las variables 

xk = x0;
rk = b - A*x0;
zk = M \ rk;
pk = zk;
alpha_k = 1;
k = 0;

% Se guarda el error inicial 
res = norm(rk);

while norm(alpha_k * pk) >= tol
    alpha_k = (rk' * zk) / (pk' * A * pk);
    x_k_mas_1 =  xk + alpha_k * pk;
    r_k_mas_1 = rk - (alpha_k * A * pk);
    z_k_mas_1 = M  \  r_k_mas_1;
    beta_k = (z_k_mas_1' *  r_k_mas_1) / (zk' * rk);
    p_k_mas_1 = z_k_mas_1 + (beta_k * pk);
    k = k + 1;

    % Tras aumentar el k, se redefinen las variables
    xk = x_k_mas_1;
    rk = r_k_mas_1;
    zk = z_k_mas_1;
    pk = p_k_mas_1;

    % Se guarda el error absoluto de la iteracion
    res = [res; norm(b - A * xk)];
end
% Se define la aproximacion final a retornar 
x = xk;
% Se agrega el numero de iteracion al vector de errores absolutos 
res = [(0:k)', res];
end

% Funcion del metodo Gauss Seidel programada en clase

function[GS,E] = metodoGaussSeidel(A,b,x,tol, iteMax)
% Metodo para aproximar la solucion x de Ax = b
% Entradas:       A ---- matriz del sistema n x n
%                 b ---- vector de constanntes 
%                 x ---- aproximacion inicial
%               tol ---- tolerancia para detener el ciclo
%            iteMax ---- numero maximo de iteraciones
% Salidas:       GS ---- matriz con las aproximaciones 
%                 E ---- vector columna con los errores absolutos 

L_gauss = tril(A,-1); 
D_gauss = diag(diag(A)); 
U_gauss = triu(A,1);


M_gauss = D_gauss + L_gauss;       
N_gauss = -U_gauss;

if norm(M_gauss\N_gauss, inf) >= 1 
    disp('No se cumple la condicion de convergencia. El metodo podria no converger.')
end
GS = x; 
er = norm(A*x - b);
E = er;
B = (M_gauss\N_gauss);
c = (M_gauss\b);
ite = 0;
while (er > tol && ite < iteMax)
    x = B*x + c;
    er = norm(A*x - b);
    GS = [GS,x];
    E = [E;er]; 
    ite = ite + 1;
end

if er > tol
    disp('Se alcanzo el numero maximo de iteraciones sin cumplir la tolerancia.');
end
end

%% Ejercicio 4

% Se aproxima la raiz cubica de 21 mediante la sucesion x_{k+1} = (20*x_k + 21/x_k^2)/21
% Entradas:        x0 ---- Valor inicial, debe ser un numero real positivo
%                 tol ---- Tolerancia para el error relativo, debe ser un numero real positivo
% Salidas:          A ---- Matriz con iteracion (col 1), aproximacion x_k (col 2) y error relativo (col 3)

% Validacion de restricciones para las entradas
function [A] = Raiz_Cubica_21(x0, tol)
    if ~(isnumeric(x0) && isreal(x0) && isscalar(x0)) || x0 <= 0
        error('El valor inicial x0 debe ser un numero real positivo.');
    end
    if ~(isnumeric(tol) && isreal(tol) && isscalar(tol)) || tol <= 0
        error('La tolerancia debe ser un numero real positivo.');
    end
    
    cont = 0;
    er = tol + 1; 
    
    % Fila inicial de la matriz de salida (iteracion 0)
    A(1, 1) = cont;
    A(1, 2) = x0;
    A(1, 3) = NaN; 
    
    % Ciclo iterativo de la sucesión
    while (er > tol)
        x1 = (20*x0 + 21/(x0^2)) / 21;
        er = abs(x1 - x0) / abs(x1); 
        
        % Almacenamiento en la matriz A
        cont = cont + 1;
        A(cont + 1, 1) = cont;
        A(cont + 1, 2) = x1;
        A(cont + 1, 3) = er;
        
        x0 = x1;
    end
end

%% Ejercicio 7

function[A] = metodo_Raiz_Multiple(p,dp,d2p,x0,tol,IterMax)
% Metodo para aproximar la solucion de un polinomio con raices multiples
% Entradas:        p ---- Polinomio de raices multiples
%                 dp ---- Primer derivada del polinomio p
%                d2p ---- Segunda derivada del polinomio p
%                 x0 ---- Aproximacion inicial
%                tol ---- Tolerancia para detener el ciclo while
%            IterMax ---- Numero de iteraciones maximas para detener el programa
% Salidas:         A ---- Matriz que contendra en la primer columna el numero de iteracion, en la segunda la aproximacion de x y en la tercera el error absoluto

if (dp(x0)^2 - p(x0)*d2p(x0) == 0)
    error('El denominador del segundo elemento se hace cero con el valor inicial. El metodo no puede ejecutarse')
end 

cont = 0;
er = tol + 1;
A(1,1) = cont;
A(1,2) = x0;
A(1,3) = NaN;
cont = 1; % Mover el contador para no tener problema en la asignación dentro de la matriz

while (er > tol) && (cont <= IterMax)
    x = x0;
    primer_derivada = dp(x0);
    segunda_derivada = d2p(x0);

    if (abs(primer_derivada^2 - p(x0) * segunda_derivada) < tol)
        warning('El denominador es muy pequeño en la iteracion %d. Deteniendo el programa.', cont); % Se usa warning para advertir que el denominador es muy cercano a cero, el %d es para reemplazar por el número de iteración actual 
        break; % Como el warning no detiene el programa se usa un break para salir del while y que asi se devuelva la matriz A con el progreso hasta la ultima iteracion posible 
    end

    x0 = x0 - (p(x0) * primer_derivada) / (primer_derivada^2 - p(x0) * segunda_derivada);
    er = abs(x-x0);
    A(cont+1,1) = cont;
    A(cont+1,2) = x0;
    A(cont+1,3) = er;
    cont = cont + 1;
end 
end

%% Ejercicio 8

% Funcion del metodo de Newton

function[M] = metodoNewton(f,df,x,tol,iteMax)
% Funcion para aproximar la solucion de f(x) = 0 usando el metodo de Newton.
% Entradas:       f --- funcion cuya raiz se busca
%                df --- derivada de f
%                 x --- aproximacion inicial
%               tol --- tolerancia para detener el ciclo
%            iteMax --- numero maximo de filas de M, incluida la inicial
% Salidas:        M --- columna 1: aproximaciones
%                       columna 2: cambios absolutos entre aproximaciones

cont = 1; er = tol + 1; M(1,1) = x; M(1,2) = inf;

while er > tol && cont < iteMax
    t = x;
    q = df(x);

    if (abs(q)<tol)
        return;
    end

    x = x - f(x)/q;
    er = abs(t-x);

    M(cont+1,1) = x;
    M(cont+1,2) = er;
    cont = cont + 1;
end
end


%% Ejercicio 11

function[P,Q,L,U] = factorizacionLU_pivoteo_total(A)
% funcion para calcular la desconposicion PAQ = LU
% Entradas:   A --- matriz nxn
% Salidas     L --- matriz triangular inferior
%             U --- matriz triangular superior
%             P --- matriz de cambio de filas
%             Q --- matriz de cambio de columnas

[m,n] = size(A);

if (m~=n)
    error("La matriz no es cuadrada")
end

U = A; 
L = eye(n);
P = eye(n);
Q = eye(n);
for k = 1 : m-1
    % Buscar la coordenada de la matriz donde se encuentra el máximo 
    maximo  = 0;
    fila = k; % Como estamos actualmente en k, el máximo podría ser en (k,k)
    col = k;
    for i = k:m
        for j = k:n
            if abs((U(i,j))) > maximo
                maximo = abs(U(i,j));
                fila = i;
                col = j;
            end
        end 

    end
    % Intercambiar filas
    U([k,fila], k:m) = U([fila,k], k:m);
    L([k,fila], 1:k-1) = L([fila,k], 1:k-1);
    P([k,fila], :) = P([fila,k], :);

    % Intercambiar columnas
    U(:, [k,col]) = U(:, [col,k]);
    Q(:, [k,col]) = Q(:, [col,k]);

    for j = k+1 :m
        L(j,k) = U(j,k)/U(k,k);
        U(j,k:m) = U(j,k:m) - L(j,k) * U(k,k:m);
    end
end 
end

%% Ejercicio 12

% Inciso a

% Metodo de Newton para ecuaciones no lineales

function[M] = metodoNewtonSistemas(F,J,x,tol,iteMax)
% Funcion para aproximar la solucion de F(x) = 0 usando Newton.
% Entradas:       F --- funcion que devuelve el vector de ecuaciones
%                 J --- funcion que devuelve la matriz jacobiana
%                 x --- vector de aproximacion inicial
%               tol --- tolerancia para el cambio entre aproximaciones
%            iteMax --- numero maximo de filas de M, incluida la inicial
% Salidas:        M --- primeras n columnas: componentes de x
%                       ultima columna: norma del cambio entre aproximaciones

x = x(:); % Trabajar con un vector columna
n = length(x);

cont = 1;
er = tol + 1;
M(1,1:n) = x.';
M(1,n+1) = inf;

while er > tol && cont < iteMax
    t = x;
    A = J(x);

    if rcond(A) < eps
        warning('El jacobiano es singular o numericamente casi singular.');
        return;
    end

    % Resolver J(x)*y = -F(x)
    y = A\(-F(x));
    x = x + y; % actualizar
    er = norm(t-x,2);

    M(cont+1,1:n) = x.';
    M(cont+1,n+1) = er;
    cont = cont + 1;
end
end

%% Ejercicio 15

% Inciso c

% Metodo de Muller para ecuaciones no lineales

function[x_muller, errores_muller] = metodoMuller(f_muller,x0,x1,x2, iteMax)
% Funcion para aproximar la solucion de f(x) = 0 usando el metodo de Muller.
% Entradas: f_muller --- funcion a la que se le quiere calcular la
%                       aproximacion de la raiz
%                 x0 --- primer punto inicial 
%                 x1 --- segundo punto inicial
%                 x2 --- tercer punto inicial
%                tol --- tolerancia para el cambio entre aproximaciones
%             iteMax --- numero de iteraciones maximas a calcular
% Salidas:  x_muller --- vector de aproximaciones de la raiz en cada 
%                        iteracion
%     errores_muller --- vector de errores absolutos de cada iteracion

x_muller = zeros(iteMax, 2);
errores_muller = zeros(iteMax, 2);
contador_iteraciones = 0;
error_iteracion_actual = 0;

while contador_iteraciones < iteMax 
    h0 = x1 - x0;
    h1 = x2 - x1;
    delta_0 = (f_muller(x1) - f_muller(x0)) / h0;
    delta_1 = (f_muller(x2) - f_muller(x1)) / h1;

    a = (delta_1 - delta_0)/(h1 + h0);
    b = a*h1 + delta_1;
    c = f_muller(x2);

    discriminante_muller = sqrt(b^2 - 4*a*c);

    % Se revisa el valor absoluto  del denominador para seleccionar 
    % la forma de la aproximacion final
    if abs(b + discriminante_muller) >= abs(b - discriminante_muller)
            denominador_muller = b + discriminante_muller;
    else
        denominador_muller = b - discriminante_muller;
    end

    x_iteracion = x2 + (-2*c)/denominador_muller;
    error_iteracion_actual = abs(x_iteracion - x2);

    %Se agrega la aproximacion de la raiz y el error de la iteracion a los 
    %vectores
    x_muller(contador_iteraciones + 1, :) = [contador_iteraciones + 3, x_iteracion];
    errores_muller(contador_iteraciones + 1, :) = [contador_iteraciones + 3, error_iteracion_actual];

    x0 = x1;
    x1 = x2;
    x2 = x_iteracion;

    contador_iteraciones = contador_iteraciones + 1;

end
end



