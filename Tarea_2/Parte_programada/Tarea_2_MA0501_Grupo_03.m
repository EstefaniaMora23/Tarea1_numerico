%% Portada 
% Universidad de Costa Rica
% Departamento de Matematica Pura 
% Analisis numerico I

% Tarea 2

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



%% Pregunta 6

% c) Funcion de MATLAB con la regla del trapecio para integrales dobles y comprobacion de los resultados de b)

% Datos del problema: la temperatura de la placa y sus dimensiones

T_6 = @(x,y) 10 - 8*x.^2 - 2*y.^2;

a_6 = 0; % La placa mide 1 m de largo en la dimension x
b_6 = 1;
c_6 = 0; % y 2 m de ancho en la dimension y
d_6 = 2;

n_6 = 2; % Subintervalos en x
m_6 = 2; % Subintervalos en y

% Aproximacion con la funcion trapecio_doble (formula (3)), la cual se encuentra al final del archivo

disp('Resultado del ejercicio 6c:')
I_6 = trapecio_doble(T_6, a_6, b_6, c_6, d_6, n_6, m_6)

% Como puede observarse, se obtuvo que I_6 = 8, que coincide con el
% resultado obtenido a mano en el inciso b).



%% Pregunta 13

% b) Resolver el sistema con la funcion Runge-Kutta

u0_13 = 1000; % Numero inicial de presas
v0_13 = 500; % Numero inicial de depredadores
n_13 = (365 * 4); % Numero de subintervalos, este N se escogio de forma que cada subintervalo represente la poblacion de presas y depredadores cada dia
t0_13 = 0; % Tiempo inicial
t1_13 = 4; % Tiempo final
k1_13 = 3; % Tasa de natalidad de las presas
k2_13 = 0.002; % Tasa de mortalidad de las presas debido a depredación
k3_13 = 0.0006; % Tasa de natalidad de los depredadores
k4_13 = 0.5; % Tasa de mortalidad de los depredadores 

[t_13,u_13,v_13] = Runge_Kutta(u0_13, v0_13, n_13, t0_13, t1_13, k1_13, k2_13, k3_13, k4_13);

% c) Graficos con las soluciones del problema


figure;
plot(t_13,u_13);
hold on;
plot(t_13,v_13);
legend('Presas', 'Depredadores');
title("Poblaciones de presas y depredadores a lo largo del tiempo");
ylabel("Población");
xlabel("Tiempo");


figure;
plot(u_13,v_13);
hold on;
plot(833.3333, 1500, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 8);
legend('Depredador vs presa', 'Punto de solución estable', 'Location', 'best');
title("Relación entre la población de presas y depredadores");
xlabel("Población de presas");
ylabel("Población de depredadores");


% La interpretacion de los graficos, respuesta a si el modelo posee
% solucion estable y los valores
% de x_1 y x_2 para los que la
% solución es estable se
% encuentra en el documento escrito. Además, el punto rojo en el grafico
% de depredadores vs presas se grafico una vez encontrados los valores de
% x_1 y x_2 (Para evitar realizar 2 graficos)

%% Pregunta 15

% a) Seleccion de la imagen con un tamanyo superior a 1MB

% i) Carga de la imagen y traconversion a escala de grises
edificio = imread("edificio.jpg"); 

edificio_b_n = rgb2gray(edificio); % La imagen aparece como si estuviera a color (A pesar de estar en escala de grises), por lo que se pasa a blanco y negro

% ii) Representacion de la imagen en una matriz A de tipo double
A_15 = double(edificio_b_n);

% iii) Dimensiones de la matriz A y que representan
[m_15,n_15] = size(A_15);

% La interpretacion de las dimensiones se encuentra en el documento escrito




% c) Construir las aproximaciones A_k 

% i) y ii) Implementar la construccion de A_k y Graficar la imagen original y las 4 aproximaciones en un solo grafico

[U,S,V] = svd(A_15);
 
k_15 = [20, 50, 100, 200];

figure;
subplot(2,3,1);
imshow(A_15, [0,255]); % [0, 255] es para determinar el rango en que pueden estar los valores de intensidad
title("Original");
sgtitle("Comparación de la imagen original con las aproximaciones");


for i=1:length(k_15)
    k = k_15(i);
    A_k = U(:, 1:k) * S(1:k, 1:k) * V(:, 1:k)';  % V va conjugada y transpuesta

    % ii) Graficar las aproximaciones
    subplot(2,3,i+1);
    imshow(A_k, [0,255]);
    title(["k = ", num2str(k_15(i))]); % Ir cambiando el numero de k para el titulo
end

% iii) Descripcion del cambio en la calidad visual conforme aumenta k


% La descripcion del cambio en la calidad visual se encuentra en el documento escrito






% e) Calculo y comparacion de la razon de almacenamiento de las imagenes aproximadas

% i) Calcular para cada k la razon de almacenamiento 

R = zeros(1,length(k_15));
for i=1:length(k_15)
    R(i) = (k_15(i) * (m_15 + n_15 + 1) ) / (m_15 * n_15) ;
end


% ii) Determinar para cuales valores de k la representacion truncada requiere almacenar menos numeros que la matriz original

% La determinacion de los valores de k para los cuales la representacion truncada requiere almacenar menos numeros que la matriz original se encuentra en el documento escrito

% iii) Explicar la diferencia entre esta medida teorica de almacenamiento y el tamanyo real de un archivo JPG o PNG

% La expliación entre la medida teorica y el  tamanyo real de un archivo
% JPG o PNG se encuentra en el documento escrito



%% Solucion de incisos: creacion de funciones 

%% Pregunta 5: aproximacion de integrales impropias

function[] = integralesImpropias(f,a,b,m)
% Funcion para aproximar integrales impropias utilizando la regla compuesta
% del enunciado 
% Entradas: f----funcion por integrar
%           a----limite inferior, puede ser -Inf
%           b----limite superior, puede ser Inf
%           m----numero entero de subintervalos por intervalo, m >= 3
% Salidas:  I----aproximacion de la integral

I = 0; 

if a == -Inf && b == Inf
    intervalos = [-Inf,-1; -1,1; 1,Inf];
elseif a == -Inf && b >= 0
    intervalos = [-Inf,-1; -1,b];
elseif b == Inf && a <= 0
    intervalos = [a,1; 1,Inf];
else
    intervalos = [a,b];
end

n = size(intervalos,1);

for k = 1:n

    inferior = intervalos(k,1);
    superior = intervalos(k,2);

    if inferior == -Inf
        g = @(x) f(1/x)/x^2;
        A = 1/superior;
        B = 0;
    elseif superior == Inf
        g = @(x) f(1/x)/x^2;
        A = 0;
        B = 1/inferior;
    else
        g = f;
        A = inferior;
        B = superior;
    end

    h = (B-A)/m;
    suma = 0;

    for i = 2:m-2
        xi = A + i*h;
        suma = suma + g(xi);
    end
    I = I + (h/2)*(3*g(A+h) + 2*suma + 3*g(B-h));
end
I
end

%% Pregunta 6: regla del trapecio compuesta para integrales dobles

function I = trapecio_doble(f, a, b, c, d, n, m)
% f es un function handle de la forma f(x,y)
% [a,b] es el intervalo en x, dividido en n subintervalos
% [c,d] es el intervalo en y, dividido en m subintervalos
% Se implementa la formula (3), donde x(i+1) = x_i y y(j+1) = y_j

    h = (b - a) / n;
    k = (d - c) / m;

    x = a + (0:n) * h;
    y = c + (0:m) * k;

    % Esquinas: f(x0,y0) + f(xn,y0) + f(x0,ym) + f(xn,ym)
    S = f(x(1), y(1)) + f(x(n+1), y(1)) + f(x(1), y(m+1)) + f(x(n+1), y(m+1));

    % Bordes inferior y superior (peso 2)
    for i = 1:n-1
        S = S + 2*f(x(i+1), y(1)) + 2*f(x(i+1), y(m+1));
    end

    % Bordes izquierdo y derecho (peso 2)
    for j = 1:m-1
        S = S + 2*f(x(1), y(j+1)) + 2*f(x(n+1), y(j+1));
    end

    % Nodos interiores (peso 4)
    for j = 1:m-1
        for i = 1:n-1
            S = S + 4*f(x(i+1), y(j+1));
        end
    end

    I = (h*k/4) * S;
end


%% Pregunta 13

% a) Crear la funcion Runge-Kutta de orden 4

function[t,u,v] = Runge_Kutta(u0, v0, n, t0, t1 ,k1, k2, k3, k4)
% Función para calcular la población de presas y depredadores a lo largo del tiempo
% Entradas:            u0 ---- Numero inicial de presas
%                      v0 ---- Numero inicial de depredadores
%                      t0 ---- tiempo inicial
%                      t1 ---- tiempo final
%                      k1 ---- Tasa de natalidad de las presas
%                      k2 ---- Tasa de mortalidad de las presas debido a depredación
%                      k3 ---- Tasa de natalidad de los depredadores 
%                      k4 ---- Tasa de mortalidad de los depredadores 
% Salidas:              t ---- Vector con la evolución del tiempo
%                       u ---- Vector con el número de presas vivas en el tiempo t
%                       v ---- Vector con el número de depredadores vivos en el tiempo t

t = zeros(1,n+1);
u = zeros(1,n+1);
v = zeros(1,n+1);
t(1) = t0;
u(1) = u0;
v(1) = v0;
h = abs(t1 - t0)/n; % Tamanyo del paso
tactual = t0; % numero para guardar el tiempo actual 

% f(ti, ui, vi) = k1*ui-k2*ui*vi
% g(ti, ui, vi) = k3*ui*vi-k4*vi
for i = 1:n % Se llega hasta n porque el indice de los arreglos en matlab empieza en 1 y no en 0
    tactual = tactual + h;
    t(i+1) = tactual;

    k_1 = k1*u(i) - k2 * u(i)*v(i);
    l_1 = k3*u(i)*v(i) - k4*v(i);


    k_2 = k1 * (u(i) + (h/2) * k_1) - k2 * (u(i) + (h/2) * k_1) * (v(i) + (h/2) * l_1);
    l_2 = k3 * (u(i) + (h/2) * k_1) * (v(i) + (h/2) * l_1) - k4 * (v(i) + (h/2) * l_1);

    k_3 = k1 * (u(i) + (h/2) * k_2) - k2 * (u(i) + (h/2) * k_2) * (v(i) + (h/2) * l_2); 
    l_3 = k3 * (u(i) + (h/2) * k_2) * (v(i) + (h/2) * l_2) - k4 * (v(i) + (h/2) * l_2);

    k_4 = k1 * (u(i) + h * k_3) - k2 * (u(i) + h * k_3) * (v(i) + h*l_3);
    l_4 = k3 * (u(i) + h * k_3) * (v(i) + h*l_3) - k4 * (v(i) + h*l_3);


    u(i+1) = u(i) + (h/6) * (k_1 + 2*k_2 + 2*k_3 + k_4);
    v(i+1) = v(i) + (h/6) * (l_1 + 2*l_2 + 2*l_3 + l_4);
end
end
