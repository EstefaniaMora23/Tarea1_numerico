%% Datos y colores

cd(fileparts(mfilename('fullpath')))
datos = readtable('../../datos/localidades_seleccionadas.csv');
resultados = readtable('../../datos/resultados_algoritmos.csv', 'TextType', 'string', 'Delimiter', ',');

% Latitud y longitud
lat = datos.latitud;
lon = datos.longitud;

% Límites del mapa
latlim = [min(lat) - 0.15, max(lat) + 0.15];
lonlim = [min(lon) - 0.15, max(lon) + 0.15];

algoritmos = ["2-opt", "X-opt", "Y-opt"];
n_alg = numel(algoritmos);

% Colores de la paleta de la presentación 
colores = [212 163 89; 200 109 81; 74 107 130] / 255;
verde_salvia = [86 106 90] / 255;

%% Localidades seleccionadas
% Mapa con la ubicación de las 50 localidades

figure('Position', [100 100 900 600])
geoscatter(lat, lon, 50, verde_salvia, 'filled')
geobasemap streets-light
geolimits(latlim, lonlim)
set(gca, 'FontSize', 16)
title('Localidades seleccionadas', 'FontSize', 20)
exportgraphics(gcf, '../../figuras/localidades.png', 'Resolution', 300)

%% Rutas finales de cada algoritmo
% Ruta final que obtiene cada algoritmo partiendo de la misma ruta inicial
% El título de cada mapa indica la longitud de la ruta en km

id_ruta_mapa = 1;

figure('Position', [50 100 1500 600])
tiledlayout(1, n_alg)

for a = 1:n_alg
    fila = resultados.id_ruta == id_ruta_mapa & resultados.algoritmo == algoritmos(a);
    ruta = str2double(split(strtrim(resultados.ruta_final(fila)))).' + 1;  % de índices 0-49 a 1-50
    ruta = [ruta, ruta(1)];                                                % regreso a la localidad inicial

    nexttile
    geoplot(lat(ruta), lon(ruta), '-', 'LineWidth', 1.3, 'Color', colores(a, :))
    hold on
    geoscatter(lat, lon, 13, 'k', 'filled')
    hold off
    geobasemap streets-light
    geolimits(latlim, lonlim)
    set(gca, 'FontSize', 14)
    title(sprintf('%s: %.1f km', algoritmos(a), resultados.longitud_final(fila)), 'FontSize', 18)
end

sgtitle(sprintf('Ruta final obtenida desde la ruta inicial %d', id_ruta_mapa), 'FontSize', 22)
drawnow; pause(3)
exportgraphics(gcf, '../../figuras/mapa_rutas_finales.png', 'Resolution', 300)

%% Longitud final en las 100 rutas iniciales
% Longitud final de cada algoritmo para cada una de las 100 rutas iniciales aleatorias

figure('Position', [100 100 1000 550])
hold on
for a = 1:n_alg
    filas = resultados.algoritmo == algoritmos(a);
    plot(resultados.id_ruta(filas), resultados.longitud_final(filas), 'LineWidth', 2, 'Color', colores(a, :))
end
hold off
set(gca, 'FontSize', 16)
xlabel('Número de ruta inicial')
ylabel('Longitud final (km)')
title('Longitud final por algoritmo en cada ruta inicial', 'FontSize', 20)
legend(algoritmos, 'Location', 'northeastoutside', 'FontSize', 16)
exportgraphics(gcf, '../../figuras/longitudes_finales.png', 'Resolution', 300)

%% Longitud final media según el número de localidades
% Longitud final promedio de cada algoritmo al aumentar el número de localidades.

rendimiento = readtable('../../datos/rendimiento_por_n.csv', 'TextType', 'string');

figure('Position', [100 100 1100 550])
hold on
for a = 1:n_alg
    filas = rendimiento.algoritmo == algoritmos(a);
    plot(rendimiento.n(filas), rendimiento.longitud_media(filas), '-s', 'LineWidth', 2, 'Color', colores(a, :), 'MarkerFaceColor', colores(a, :))
end
hold off
set(gca, 'FontSize', 16)
xlabel('Número de localidades (n)')
ylabel('Longitud final media (km)')
title('Longitud final media por algoritmo según el número de localidades', 'FontSize', 18)
legend(algoritmos, 'Location', 'best', 'FontSize', 16)
exportgraphics(gcf, '../../figuras/longitud_media_por_n.png', 'Resolution', 300)

%% Tiempo de ejecución según el número de iteraciones
% Cada punto es una de las 100 rutas iniciales
% Compara las iteraciones (parejas de aristas evaluadas) con el tiempo que tardó el algoritmo

figure('Position', [100 100 800 600])
hold on
for a = 1:n_alg
    filas = resultados.algoritmo == algoritmos(a);
    scatter(resultados.parejas_evaluadas(filas), resultados.tiempo_ejecucion(filas), 25, colores(a, :), 'filled', 'MarkerFaceAlpha', 0.8)
end
hold off
set(gca, 'FontSize', 18)
xlabel('Número de iteraciones')
ylabel('Tiempo de ejecución (s)')
title({'Tiempo de ejecución según', 'el número de iteraciones'}, 'FontSize', 20)
legend(algoritmos, 'Location', 'best', 'FontSize', 18)
exportgraphics(gcf, '../../figuras/iteraciones_vs_tiempo.png', 'Resolution', 300)

%% Tiempo promedio por iteración
% Tiempo total entre el total de iteraciones de cada algoritmo en microsegundos

tiempo_por_iteracion = zeros(1, n_alg);
for a = 1:n_alg
    filas = resultados.algoritmo == algoritmos(a);
    tiempo_total = sum(resultados.tiempo_ejecucion(filas));
    iteraciones_totales = sum(resultados.parejas_evaluadas(filas));
    tiempo_por_iteracion(a) = tiempo_total / iteraciones_totales * 1e6;
end

figure('Position', [100 100 800 600])
b = bar(tiempo_por_iteracion);
b.FaceColor = 'flat';
b.CData = colores;
xticklabels(algoritmos)
set(gca, 'FontSize', 18)
ylabel('Tiempo por iteración (μs)')
title({'Tiempo promedio por iteración', 'de cada algoritmo'}, 'FontSize', 20)
exportgraphics(gcf, '../../figuras/tiempo_por_iteracion.png', 'Resolution', 300)