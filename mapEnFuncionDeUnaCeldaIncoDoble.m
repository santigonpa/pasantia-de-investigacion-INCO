map = zeros(16,120);
filas = 16;
columnas = 120;
for i = 1:filas
  for j = 1:columnas
    idCelda = (i-1)*columnas + j;
    map(i, j) = commMapIncoDobleMkm(60, idCelda);
  end
end
figure;
imagesc(map);
colorbar;
