% This is to plot the Cramer-Rao Lower Bound of a parameter vs the
% parameter itself and note down the my inference from the obtained plot.

%% SYSTEM SETTING
% Consider a quantity $x[n] = s[n; \theta] + w[n]$ where $s[n;\theta]$ is any signal
% (AC or DC) and $w[n]$ is an AWGN with variance $\sigma^2$. Let us consider that
% $s[n;\theta] = A\sin(2\pi\theta n + \phi)$. Thus, $s[n;\theta]$ is dependent on three
% parameters: A, $\theta$ and $\phi$. For this example, we are trying to estimate the
% value of frequency, i.e., $\theta$ of the signal s. The CRLB for the given
% estimator is found out as belows:

% Defining the parameters
N = 10;                             % Number of terms in the data set {x[n]}
A = 1;                              % Assuming A is a constant
theta_values = linspace(0, 1, 100); % Varying theta from 0 to 100

variance_values = zeros(1, length(theta_values));

for k = 1:length(theta_values)
    theta = theta_values(k);
    sum_term = 0;
    for n = 0:N-1
        sum_term = sum_term + (A*cos(2*pi*theta*n))^2;
    end
    variance = 1 / (4 * pi^2 * sum_term);
    variance_values(k) = variance;
end


%% PLOTTING
figure
plot(theta_values, variance_values, 'b-', 'LineWidth', 2)
xlabel('Theta')
ylabel('Cramer-Rao lower bound')
title('CRLB vs Theta')
grid on

