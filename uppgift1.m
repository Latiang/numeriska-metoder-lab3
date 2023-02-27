%uppgift 1

f = @(x) (1 + x) .^ (-0.5);
low = 0;
high = 1;
TOLS = 3:14;
TOLS = 2 .^ -TOLS;

samples_montecarlo = zeros(size(TOLS));
samples_trapetzoid = samples_montecarlo;

for i = 1:numel(TOLS)
    [~, ~, samples_m] = montecarlo1d(f,low, high, TOLS(i));
    [~, ~, samples_t] = trapets1d(f,low, high, TOLS(i));
    samples_montecarlo(i) = samples_m;
    samples_trapetzoid(i) = samples_t;
end
h2_pred = TOLS .^ -0.5;
h05_pred = TOLS .^ -2;
loglog(TOLS, samples_montecarlo, TOLS, samples_trapetzoid, TOLS, h2_pred, TOLS, h05_pred);
legend("Montecarlo", "Trapetsmetoden", "Förväntad ordnign 2", "Förväntad ordning 1/2");
xlabel("Tolerans")
ylabel("Antal punkter")
exportgraphics(gcf, 'uppgift1_punkter_vs_fel.pdf', 'ContentType', 'vector');

