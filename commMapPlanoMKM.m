% Parámetros del occupancy grid
filas = 5;
columnas = 17;
grid = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1;
        1 0 0 0 0 1 1 0 0 0 1 1 0 0 1 1 1;
        1 0 0 0 0 1 1 0 0 0 1 1 0 0 1 0 1;
        1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 1 1;
        1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

% Parámetros de FSPL
f = 2.4e9;       % Frecuencia en Hz (2.4 GHz)
c = 3e8;         % Velocidad de la luz (m/s)
obstaculo = NaN;  % Valor para casilleros con obstaculos

% Parámetros de MKM
L_wall = 6;               % Atenuación por pared de ladrillo (dB)

% Se inicializa la matriz de comunicación con NaN para todas las entradas
N = filas * columnas;
commMapMKM = obstaculo * ones(N, N);

% Coordenadas de cada celda
posiciones = zeros(N, 2);
for i = 1:filas
  for j = 1:columnas
    idCelda = (i-1)*columnas + j;
    posiciones(idCelda, :) = [i, j];
  end
end

% Calcular pérdidas entre celdas libres solamente
for i = 1:N
  for j = 1:N
    f1 = posiciones(i,1);
    c1 = posiciones(i,2);
    f2 = posiciones(j,1);
    c2 = posiciones(j,2);
    if grid(f1, c1) == 0 && grid(f2, c2) == 0  % solo si los dos son libres
      dist = norm([f1 c1] - [f2 c2]);
      if dist == 0
        PL_mkm2 = 0;
      else
        walls = obstaculosEntreMedio(grid, f1, c1, f2, c2);
        PL = 20*log10(dist) + 20*log10(f) + 20*log10(4*pi/c);
        PL_mkm2 = PL + walls * L_wall;
      end
      commMapMKM(i, j) = PL_mkm2;
    end
  end
end

commMapMKM(1, 1) = 100;

figure;
imagesc(commMapMKM);
colorbar;
title('Mapa de comunicacion del escenario 1 utilizando MKM representado con colores');
xlabel('Celda destino');
ylabel('Celda origen');

disp('Mapa de comunicación (MKM):');
disp(commMapMKM);
