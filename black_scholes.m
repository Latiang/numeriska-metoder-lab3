function [F, s, t] = black_scholes(M,N)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
T=1;
sigma=0.2;
K=1.22;

low_s = 0;
high_s = 4*K;

delta_s = (high_s - low_s) / M;
delta_t = T / N;

%D_m = sigma.^2 .* m.^2 .* delta_s .^ 2 / 2
%lambda_m = D .* delta_t ./ delta_s .^ 2
%lambda_m = sigma.^2 .* m.^2 .* delta_s .^ 2 / 2 .* delta_t ./ delta_s .^ 2
%lambda_m = sigma.^2 .* m.^2 / 2 .* delta_t
%delta_s cancels

lambda = @(m)sigma .^2 .* m.^2 .* delta_t ./ 2;

%f(m, n-1) = f(m, n) + lambda_m*(f(m + 1, n-1) - 2f(m, n-1) + f(m-1, n-1))
%-lambda_m * f(m+1, n-1) + (1 + 2*lambda_m)*f(m, n-1) - lambda_m*f(m-1,n-1)=f(m,n)

%There will be M - 1 interior points in the modeled area.

B = zeros(M - 1);

for m=1:(M-1)
    B(m, m) = 1 + 2*lambda(m);
end

for m=1:(M-2)
    B(m, m+1) = -lambda(m);
end

for m=2:(M-1)
    B(m, m-1) = -lambda(m);
end

r = zeros(M - 1, 1);
r(1) = -K*lambda(1); %f(0, n) = K, f(M, n) = 0
F = zeros(M - 1, N + 1);
%f(n) = [f(1, n); f(2, n); ...; f(M-1, n)]
%B*f(n-1) + r = f(n) 
%f(n-1) = B\(f(n) - r)

%f starts at f(N)

f_curr = zeros(M-1, 1);
for m=1:M-1
    f_curr(m) = max(K - m*delta_s, 0);
end
F(:, N + 1) = f_curr;
for n = N:-1:1
    f_curr = B\(f_curr - r);
    F(:, n) = f_curr;
end
F = [zeros(1, N+1)+K; F; zeros(1, N+1)];
s = zeros(size(F));
t = s;
s = s + linspace(low_s, high_s, M + 1)';
t = t + linspace(0, T, N+1);
end