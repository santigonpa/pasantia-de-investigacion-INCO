% Parámetros
f = 2.4e9;            % Frecuencia (Hz)
c = 3e8;              % Velocidad de la luz (m/s)
d = 0.1:0.1:30;     % Distancia (m)

% Free Space Path Loss (FSPL)
PL_fspl = 20*log10(d) + 20*log10(f) + 20*log10(4*pi/c);

% Generar Rayleigh fading (potencia de desvanecimiento en dB)
N = length(d);
sigma = 1;  % parámetro Rayleigh
rayleigh_env = sigma * sqrt(-2 * log(rand(1, N)));   % envolvente
PF_dB = -20 * log10(rayleigh_env);                   % conversión a dB

% Sumar la atenuación por fading a la pérdida de espacio libre
PL_total = PL_fspl + PF_dB;

% Graficar
figure; hold on;
plot(d, PL_total, '-r', 'LineWidth', 1, 'DisplayName', 'FSPL + Rayleigh Fading');
plot(d, PL_fspl, '-k', 'LineWidth', 2, 'DisplayName', 'FSPL');

xlabel('Distancia (m)');
ylabel('Pérdida de señal (dB)');
title('Pérdida de señal: FSPL vs FSPL + Rayleigh Fading');
legend('Location', 'northwest');
grid on;

% Mostrar pérdida final
fprintf('Pérdida FSPL a %.2f m: %.2f dB\n', d(end), PL_fspl(end));
fprintf('Pérdida total con Rayleigh a %.2f m: %.2f dB\n', d(end), PL_total(end));

