clear all
close all
clc


% Defining the vectors for N and phi
N_values = [50, 100];
phi_values = [0, 45];

% Defining the other required parameteres
A = 1;                                
awgn_variance = 1;
% It is assumed in the textbook that A^2 / sigma^2 = 1


% Frequency range
frequencies = -1:.01:1;

% Preallocating the matrix for CRLB values
crlb_values = zeros(length(N_values), length(phi_values), length(frequencies));

for i = 1:length(N_values)
    N = N_values(i);
    for j = 1:length(phi_values)
        phi = phi_values(j);
        for k = 1:length(frequencies)
            f0 = frequencies(k);
            sum_term = 0;
            for n = 0:N-1
                sum_term = sum_term + (2*pi*n * sind(2*pi*f0*n + phi))^2;
            end
            crlb = awgn_variance / (A^2 * sum_term);
            crlb_values(i, j, k) = crlb;
        end
    end
end

%Plotting the CRLB vs frequency graph for different N and phi
figure;
colors = ['r', 'g', 'b', 'k'];
for i = 1:length(N_values)
    for j = 1:length(phi_values)
        subplot(length(N_values), length(phi_values), (i-1)*length(phi_values) + j);
        plot(frequencies, reshape(crlb_values(i, j, :),1,201), 'Color', colors((i-1)*length(phi_values) + j), ...
            'LineWidth', 2);
        xlabel('Frequency (Hz)');
        ylabel('Cramer-Rao Lower Bound (CRLB)');
        title(sprintf('N=%d, \\phi=%.2f', N_values(i), phi_values(j)));
        grid on;
    end
end


% plot(frequencies,crlb_values(1,:))
