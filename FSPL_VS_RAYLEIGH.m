% Parámetros del escenario 1
f = 2.4e9;                % Frecuencia (Hz)
c = 3e8;                  % Velocidad de la luz (m/s)
d = 0.01:0.01:15;         % Distancia (m)
L_wall = 6;               % Atenuación por pared de ladrillo (dB)
L_floor = 0;              % Sin pisos en este escenario

% FSPL
PL_fspl = 20*log10(d) + 20*log10(f) + 20*log10(4*pi/c);

% Variable Rayleigh
sigma = 1;  % parámetro de la distribución
N = length(d);

% Muestras independientes de Rayleigh
PF = raylrnd(sigma, 1, N);  % un valor distinto por punto

PL_rayleigh = PL_fspl + 10*log10(PF);

% Gráfica
figure; hold on;
plot(d, PL_rayleigh, '-r', 'LineWidth', 0.5, 'DisplayName', 'Rayleigh Fading Model con FSPL');
plot(d, PL_fspl, '--k', 'LineWidth', 1, 'DisplayName', 'Free Space Path Loss');

xlim([0 16]); % Establece los límites del eje X de 0 a 15 metros

xlabel('Distancia (m)');
ylabel('Pérdida de señal (dB)');
title('Comparación entre Free Space Path Loss - Rayleigh Fading Model');
legend('Location', 'northwest');
grid on;

fprintf('Pérdida FSPL a %.2f m: %.2f dB\n', d(end), PL_fspl(end));
fprintf('Pérdida MKM  a %.2f m: %.2f dB\n', d(end), PL_rayleigh(end));
