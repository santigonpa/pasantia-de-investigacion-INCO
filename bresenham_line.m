function puntos = bresenham_line(x0, y0, x1, y1)
  puntos = [];

  if abs(x1 - x0) > abs(y1 - y0)
    puntos = drawLineH(x0, y0, x1, y1);
  else
    puntos = drawLineV(x0, y0, x1, y1);
  endif
endfunction

function puntos = drawLineH(x0, y0, x1, y1)
  puntos = [];
  if x0 > x1
    [x0, x1] = deal(x1, x0);
    [y0, y1] = deal(y1, y0);
  endif

  dx = x1 - x0;
  dy = y1 - y0;
  dir = 1;
  if dy < 0
    dir = -1;
    dy = -dy;
  endif

  y = y0;
  p = 2 * dy - dx;
  for i = 0:dx
    puntos = [puntos; y, x0 + i]; %[fila columna]
    if p >= 0
      y += dir;
      p -= 2 * dx;
    endif
    p += 2 * dy;
  endfor
endfunction

function puntos = drawLineV(x0, y0, x1, y1)
  puntos = [];
  if y0 > y1
    [x0, x1] = deal(x1, x0);
    [y0, y1] = deal(y1, y0);
  endif

  dx = x1 - x0;
  dy = y1 - y0;
  dir = 1;
  if dx < 0
    dir = -1;
    dx = -dx;
  endif

  x = x0;
  p = 2 * dx - dy;
  for i = 0:dy
    puntos = [puntos; y0 + i, x]; %[fila columna]
    if p >= 0
      x += dir;
      p -= 2 * dy;
    endif
    p += 2 * dx;
  endfor
endfunction

