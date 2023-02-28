function [expected,stddev] = rainbow_option(S_start,T, N)
%Solves the rainbow option from uppgift3 
%   Input:
%       S_start - column vector of starting values for s
%       T - Variance of distributions
%       N - number of samples

sigma=0.2;
k=1.22;
ST = @(r)exp(-sigma^2*T/2 + sigma*r).*S_start;

samples = normrnd(0, sqrt(T),numel(S_start), N);
samples = ST(samples) - k;
if numel(S_start) > 1
    samples = max(samples);
end
samples = max(samples, 0);

expected = mean(samples);
stddev = std(samples) / sqrt(numel(samples));
end