map = zeros(6,17);
filas = 5;
columnas = 17;
for i = 1:filas
  for j = 1:columnas
    idCelda = (i-1)*columnas + j;
    map(i, j) = commMapMKM(43, idCelda);
  end
end
for j = 1:columnas
  map(6, j) = 100;
end
figure;
imagesc(map);
colorbar;
