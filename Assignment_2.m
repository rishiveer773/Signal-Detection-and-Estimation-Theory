% Defining the vectors N and intial_phase
N = [10, 20];
initial_phase = [0, pi/4];

% Code for generation of the CRLB vs frequency graph
A = 5;
f0 = 100;
awgn_variance = 5;

for i = 1:length(N)
    n = N(i);
    array = zeros(length(n));
    for j = 1:length(initial_phase)
        phase = initial_phase(j);
        array(i) = (2*pi*n*sin(2*pi*f0*n + phase))^2;
    end
end
