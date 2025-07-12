map = zeros(8,60);
filas = 8;
columnas = 60;
for i = 1:filas
  for j = 1:columnas
    idCelda = (i-1)*columnas + j;
    map(i, j) = commMapIncoMkm(30, idCelda);
  end
end
figure;
imagesc(map);
colorbar;
