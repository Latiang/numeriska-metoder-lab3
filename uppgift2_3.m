%% uppgift 2

T=1;
sigma=0.2;
k=1.22;
s=k;

n = 1000000;

%calculates ST from random variable r
ST = @(r)exp(-sigma^2*T/2 + sigma*r)*s;

samples = normrnd(0, sqrt(T), 1, n);
samples = ST(samples) - k;
samples = max(samples, 0);

expected = mean(samples)
stddev = std(samples) / sqrt(numel(samples))

%% uppgift 3
%We want to do the same thing as in 1 (essentially) but with more
%dimension

%Since they are less important when calculating differences we will
%consider sigma=0.2, k=1.22, s=[k;k;k;...]

%We want to do 2 tests. 1 we want to study how the error behaves for fixed
%dimensions and changing samples. 2 we want to study for for fixed samples
%and changing dimensions

% 1 fixed dimensions [1 5 10 20] and changing points 2 4 8 16 ...
dims = 1:20;
n_dims = numel(dims);
samples = 2.^(1:10);
n_samples = numel(samples);
errors = zeros(n_samples, n_dims);

%Run test extra times based on number of sample points
min_points = 1000000;
tic
for dim_i = 1:n_dims
    S_start = zeros(dims(dim_i), 1) + k;
    for samples_i = 1:n_samples
        n = samples(samples_i);
        N = max(ceil(min_points / n), 1);
        for dummy = 1:N
            [~, stddev] = rainbow_option(S_start, T, n);
            errors(samples_i, dim_i) = errors(samples_i, dim_i) + stddev;
        end
        errors(samples_i, dim_i) = errors(samples_i, dim_i) / N;
    end
end
toc
figure
plot(dims, errors(end, :))
xlabel('Dimensions')
ylabel('Standard deviation')
title(strcat("Standard deviation vs dimensions with ", num2str(samples(end)), ' samples'))
exportgraphics(gcf, 'uppgift3_fel_vs_dimension.pdf', 'ContentType', 'vector');
figure
hold on
description = cell(1, numel(dims));
for dim = dims
    plot(log2(samples), log2(errors(:, dims)))
    description(dim) = {strcat(num2str(dim), "D")};
end
legend(description)
xlabel("Samples (log2)")
ylabel("Standar Deviation (log2)")
exportgraphics(gcf, 'uppgift3_fel_vs_punkter.pdf', 'ContentType', 'vector');
hold off