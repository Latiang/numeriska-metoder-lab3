function [area,stddev, N] = montecarlo1d(f,low, high, TOL)
%Performs montecarlo integration of the onedimensional function f over the
% range [low, high]. 
%   input:
%       f - function to integrate
%       low - lower limit of integration
%       high - higher limit of integration
%       TOL - accepted stddev of approximation
%   output:
%       area - approximated area
%       stddev - standard deviation of area
%       N - number of points sampled
N = 2;
stddev = TOL * 2;
line_length = high - low;
sample_generator = @(dims)low + line_length * rand(dims);
old_samples = sample_generator([1, N]);
for i = 1:N
    old_samples(i) = f(old_samples(i));
end
while stddev > TOL 
    samples = [old_samples sample_generator(size(old_samples))];

    for i = (N+1):(2*N)
        samples(i) = f(samples(i));
    end
    N = N*2;
    stddev = std(samples)/sqrt(N);
    old_samples = samples;
end

area = mean(samples) * line_length;
end