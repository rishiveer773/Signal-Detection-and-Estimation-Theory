% Defining the vectors for N and phi
N_values = [10, 20];                  % Example sample sizes
phi_values = [0, pi/4];               % Example initial phases

% Constant amplitude
A = 1;                                % Amplitude is constant

% Noise variance
awgn_variance = 5;

% Frequency range
frequencies = :5:150;  % Example frequency range

% Preallocate the matrix for CRLB values
crlb_values = zeros(length(frequencies), length(N_values), length(phi_values));

% Loop over N, phi, and frequency
for i = 1:length(N_values)
    N = N_values(i);  % Set number of samples
    for j = 1:length(phi_values)
        phi = phi_values(j);  % Set phase
        for k = 1:length(frequencies)
            f0 = frequencies(k);  % Current frequency
            sum_term = 0;
            for n = 0:N-1
                sum_term = sum_term + (2 * pi * n * sin(2 * pi * f0 * n + phi))^2;
            end
            crlb = awgn_variance / (A^2 * sum_term);  % Calculate CRLB
            crlb_values(k, i, j) = crlb;  % Store CRLB value
        end
    end
end

% Plotting the CRLB vs frequency graph for different N and phi
figure;
hold on;
colors = ['r', 'g', 'b', 'k'];  % Colors for different plots
for i = 1:length(N_values)
    for j = 1:length(phi_values)
        plot(frequencies, crlb_values(:, i, j), 'Color', colors((i-1)*length(phi_values) + j), ...
            'LineWidth', 2, 'DisplayName', sprintf('N=%d, \\phi=%.2f', N_values(i), phi_values(j)));
    end
end
hold off;

% Labels and title
xlabel('Frequency (Hz)');
ylabel('Cramer-Rao Lower Bound (CRLB)');
title('CRLB vs Frequency for Different N and \phi');
legend('show');
grid on;
