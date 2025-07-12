% Parámetros del grid
rows = 4;
cols = 4;
grid = [ 0 0 0 1;
         0 0 1 1;
         0 0 0 0;
         1 1 0 0 ];  % 0: libre, 1: pared

% Parámetros de FSPL
f = 2.4e9;       % Frecuencia en Hz (2.4 GHz)
c = 3e8;         % Velocidad de la luz (m/s)
MUY_ALTO = 999;  % Valor para conexiones no válidas (paredes)

% Inicializar matriz de comunicación para todas las celdas (16x16)
N = rows * cols;
commMap = MUY_ALTO * ones(N, N);  % todo empieza como inaccesible

% Coordenadas de cada celda (para luego calcular distancia)
posiciones = zeros(N, 2);
for i = 1:rows
  for j = 1:cols
    idx = (i-1)*cols + j;
    posiciones(idx, :) = [i, j];
  end
end
disp(posiciones);
% Calcular pérdidas entre celdas libres solamente
for i = 1:N
  for j = 1:N
    [r1, c1] = deal(posiciones(i,1), posiciones(i,2));
    [r2, c2] = deal(posiciones(j,1), posiciones(j,2));
    if grid(r1, c1) == 0 && grid(r2, c2) == 0  % solo si ambos son libres
      dist = norm([r1 c1] - [r2 c2]);
      if dist == 0
        PL = 0;
      else
        PL = 20*log10(dist) + 20*log10(f) + 20*log10(4*pi/c);
      end
      commMap(i, j) = PL;
    end
  end
end

% Mostrar la matriz
disp('Matriz de comunicación (FSPL) considerando todas las celdas:');
disp(commMap);

