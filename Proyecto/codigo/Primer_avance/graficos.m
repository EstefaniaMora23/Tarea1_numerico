% Este documento es para hacer los gráficos

% Moverse a la carpeta donde está este archivo
cd(fileparts(mfilename('fullpath')))

% Leer los datos exportados desde Python
datos = readtable('../datos/localidades_seleccionadas.csv');

x = datos.x_km;
y = datos.y_km;

% Figura de ubicación de las localidades
figure
scatter(x, y, 80, 'filled')
text(x + 3, y + 3, string(datos.indice))
axis equal
grid on
xlabel('x (km)')
ylabel('y (km)')
title('Localidades seleccionadas')

% Guardar la figura
if ~exist('../figuras', 'dir')
    mkdir('../figuras')
end
saveas(gcf, '../figuras/localidades.png')