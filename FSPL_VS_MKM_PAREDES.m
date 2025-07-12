% Parámetros del escenario 1
f = 2.4e9;                % Frecuencia (Hz)
c = 3e8;                  % Velocidad de la luz (m/s)
d = 0.01:0.01:15;         % Distancia (m)
L_wall = 6;               % Atenuación por pared de ladrillo (dB)
L_floor = 0;              % Sin pisos en este escenario

% FSPL
PL_fspl = 20*log10(d) + 20*log10(f) + 20*log10(4*pi/c);

% Número de paredes según distancia
n_wall = zeros(size(d));
n_wall(d >= 5) = 1;
n_wall(d >= 10) = 2;

% MKM = FSPL + n_wall * L_wall
PL_mkm = PL_fspl + n_wall * L_wall + 0 * L_floor;

d_0 = 1;
PL_0 = 20*log10(d_0) + 20*log10(f) + 20*log10(4*pi/c);
n = 4;
d_1 = 1:0.01:15;
n_wall_1 = zeros(size(d_1));
n_wall_1(d_1 >= 5) = 1;
n_wall_1(d_1 >= 10) = 2;

% WAF
PL_waf = PL_0 + 10*n*log10(d_1) + n_wall_1*L_wall;

% Gráfica
figure; hold on;
plot(d, PL_mkm, '-y', 'LineWidth', 2, 'DisplayName', 'Motley - Keenan Model');
plot(d_1, PL_waf, '-.m', 'LineWidth', 2, 'DisplayName', 'Wall Attenuation Factor Model');
plot(d, PL_fspl, '--k', 'LineWidth', 2, 'DisplayName', 'Free Space Path Loss');

xlabel('Distancia (m)');
ylabel('Pérdida de señal (dB)');
title('Comparación entre Free Space Path Loss y Motley - Keenan Model (paredes a 5 m y 10 m)');
legend('Location', 'northwest');
grid on;

xlim([0 16]); % Establece los límites del eje X de 0 a 15 metros

fprintf('Pérdida FSPL a %.2f m: %.2f dB\n', d(end), PL_fspl(end));
fprintf('Pérdida MKM  a %.2f m: %.2f dB\n', d(end), PL_mkm(end));
