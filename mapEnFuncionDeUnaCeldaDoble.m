mapDobl = zeros(11,34);
filas = 10;
columnas = 34;
for i = 1:filas
  for j = 1:columnas
    idCelda = (i-1)*columnas + j;
    mapDoble(i, j) = commMapDoble(36, idCelda);
  end
end
for j = 1:columnas
  mapDoble(11, j) = 100;
end
figure;
imagesc(mapDoble);
colorbar;
