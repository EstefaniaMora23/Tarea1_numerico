% Este documento es para hacer los gráficos

% Moverse a la carpeta donde está este archivo
cd(fileparts(mfilename('fullpath')))

% Leer los datos exportados desde Python
datos = readtable('../../datos/localidades_seleccionadas.csv');

x = datos.x_km;
y = datos.y_km;

% Figura de ubicación de las localidades
figure
scatter(x, y, 50, 'filled')
axis equal
grid on
xlabel('x (km)')
ylabel('y (km)')
title('Localidades seleccionadas')
saveas(gcf, '../../figuras/localidades.png')

% Leer los resultados de los tres algoritmos
resultados = readtable('../../datos/resultados_algoritmos.csv', 'TextType', 'string', 'Delimiter', ',');

algoritmos = ["2-opt", "X-opt", "Y-opt"];
n_alg = numel(algoritmos);

% Mapa con la ruta final de cada algoritmo
id_ruta_mapa = 1;

figure
tiledlayout(1, n_alg)

for a = 1:n_alg
    fila = resultados.id_ruta == id_ruta_mapa & resultados.algoritmo == algoritmos(a);
    ruta = str2double(split(strtrim(resultados.ruta_final(fila)))).' + 1;  % de índices 0-49 a 1-50
    ruta = [ruta, ruta(1)];                                                % regreso a la localidad inicial

    nexttile
    plot(x(ruta), y(ruta), '-', 'LineWidth', 0.8)
    hold on
    scatter(x, y, 15, 'filled')
    hold off
    axis equal
    xlim([min(x) - 10, max(x) + 10])  
    ylim([min(y) - 10, max(y) + 10])
    xlabel('x (km)')
    ylabel('y (km)')
    title(sprintf('%s: %.1f km', algoritmos(a), resultados.longitud_final(fila)))
end

sgtitle(sprintf('Ruta final obtenida desde la ruta inicial %d', id_ruta_mapa))
saveas(gcf, '../../figuras/mapa_rutas_finales.png')