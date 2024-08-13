% This is to plot the Cramer-Rao Lower Bound of a parameter vs the
% parameter itself and note down the my inference from the obtained plot.

%% SYSTEM SETTING
% Consider a the quantity x[n] = s[n;θ] + w[n] where s[n;θ] is any signal
% (AC or DC) and w[n] is an AWGN with variance σ^2. Let us consider that
% s[n;θ] = A*sin(2*pi*θ*n + Φ). Thus, s[n;θ] is dependent on three
% parameters: A, θ and Φ. For this example, we are trying to estimate the
% value of frequency, i.e., θ of the signal s. The CRLB for the given
% estimator is found out as belows:

% Define parameters
N = 10;
phi = 0;
A = 1;  % Assuming A is a constant (it was given as sigma^2 earlier)
theta_values = linspace(0, 1, 100); % Varying theta from 0 to 1
sigma_sq = 1;  % Variance (sigma^2)

% Initialize the CRLB array
CRLB_values = zeros(1, length(theta_values));

% Compute CRLB for each theta
for k = 1:length(theta_values)
    theta = theta_values(k);

    % Sum term in the denominator
    sum_term = 0;
    for n = 0:N-1
        sum_term = sum_term + (n * cos(2 * pi * theta * n + phi))^2;
    end

    % Compute CRLB
    CRLB = sigma_sq / ((2 * pi * A)^2 * sum_term);
    CRLB_values(k) = CRLB;
end

% Plot CRLB vs theta
figure;
plot(theta_values, CRLB_values, 'b-', 'LineWidth', 2);
xlabel('Frequency');
ylabel('Cramer-Rao lower bound');
title('CRLB vs frequency');
grid on;

% Optionally, you can also plot a horizontal line representing variance
hold on;
variance = sigma_sq * ones(1, length(theta_values));  % Assuming variance is constant
plot(theta_values, variance, 'r--', 'LineWidth', 2);
legend('CRLB', 'Variance');
hold off;
