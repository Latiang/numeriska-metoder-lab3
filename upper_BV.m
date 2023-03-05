T=1;
sigma=0.2;
k=1.22;

n = 100000000;

%calculates ST from random variable r
ST = @(r)exp(-sigma^2*T/2 + sigma*r);

samples = normrnd(0, sqrt(T), 1, n);
samples = ST(samples);

min_found = min(samples)