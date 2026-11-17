% Este documento es para hacer los gráficos

% Moverse a la carpeta donde está este archivo
cd(fileparts(mfilename('fullpath')))

% Leer los datos exportados desde Python
datos = readtable('../../datos/localidades_seleccionadas.csv');

% Latitud y longitud

lat = datos.latitud;
lon = datos.longitud;

% Límites del mapa con un pequeño margen
latlim = [min(lat) - 0.15, max(lat) + 0.15];
lonlim = [min(lon) - 0.15, max(lon) + 0.15];

% Figura de ubicación de las localidades
figure
geoscatter(lat, lon, 50, 'filled')
geobasemap streets-light
geolimits(latlim, lonlim)
title('Localidades seleccionadas')
exportgraphics(gcf, '../../figuras/localidades.png', 'Resolution', 300)

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
    geoplot(lat(ruta), lon(ruta), '-', 'LineWidth', 0.8)
    hold on
    geoscatter(lat, lon, 15, 'filled')
    hold off
    geobasemap streets-light
    geolimits(latlim, lonlim)
    title(sprintf('%s: %.1f km', algoritmos(a), resultados.longitud_final(fila)))
end

sgtitle(sprintf('Ruta final obtenida desde la ruta inicial %d', id_ruta_mapa))
drawnow; pause(3)
exportgraphics(gcf, '../../figuras/mapa_rutas_finales.png', 'Resolution', 300)


% Longitud final de cada algoritmo en las 100 rutas iniciales
figure
hold on
for a = 1:n_alg
    filas = resultados.algoritmo == algoritmos(a);
    plot(resultados.id_ruta(filas), resultados.longitud_final(filas))
end
hold off
xlabel('Número de ruta inicial')
ylabel('Longitud final (km)')
title('Longitud final por algoritmo en cada ruta inicial')
legend(algoritmos, 'Location', 'best')
exportgraphics(gcf, '../../figuras/longitudes_finales.png', 'Resolution', 300)

% Longitud final media de cada algoritmo según el número de localidades (equivalente a la Fig. 6 del artículo)
rendimiento = readtable('../../datos/rendimiento_por_n.csv', 'TextType', 'string');

figure
hold on
for a = 1:n_alg
    filas = rendimiento.algoritmo == algoritmos(a);
    plot(rendimiento.n(filas), rendimiento.longitud_media(filas), '-s')
end
hold off
xlabel('Número de localidades (n)')
ylabel('Longitud final media (km)')
title('Longitud final media por algoritmo según el número de localidades')
legend(algoritmos, 'Location', 'best')
exportgraphics(gcf, '../../figuras/longitud_media_por_n.png', 'Resolution', 300)