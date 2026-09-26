%% Tarea 1

%% Ejercicio 1

% Prueba de la funcion del ejercicio 1 Division_Multiples_Secciones:

f_1 = @(x) exp(x) -2*x - 1; % funcion para el metodo
disp('Resultado del ejercicio 1:')
Division_Multiples_Secciones(f_1, 1, 2, 10, 10^-10)






























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