%% Tarea 1

%% Ejercicio 1
% Prueba de la funcion del ejercicio 1 Division_Multiples_Secciones:

f_1 = @(x) exp(x) -2*x - 1; % funcion para el metodo
disp('Resultado del ejercicio 1:')
Division_Multiples_Secciones(f_1, 1, 2, 10, 10^-10)



%% Ejercicio 7
% Prueba de la función del ejercicio 7 Método de Raíz Múltiple
p_7   = @(x) (x^2 + 9) * (x - 3)^4; % Se usa el subindice 7 pues es el polinomio del ejercicio 7, se hace para evitar sobreescritura de datos
dp_7 = @(x) 2*x*(x - 3)^4 + 4*(x - 3)^3 * (x^2 + 9); % Primer derivada del polinomio
d2p_7 =  @(x) 2*(x - 3)^4 + 16*x*(x - 3)^3 + 12*(x - 3)^2 * (x^2 + 9); % Segunda derivada del polinomio 
disp('Resultado del ejercicio 7d:')
metodo_Raiz_Multiple(p_7,dp_7,d2p_7,0,10^-10,100)






























%% Funciones 

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





%% Ejercicio 3


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