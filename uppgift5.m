close all

%Error with fixed delta_s

M = 1000;
N = 1;
[F, ~, ~, ~, delta_t] = black_scholes(M, N);
old_approx = F(125, 1);
differences = [];
delta_ts = [];
while N < 10000
    N = N * 2;
    [F, ~, ~, ~, delta_t] = black_scholes(M, N);
    approx = F(125, 1);
    differences = [differences approx-old_approx];
    old_approx = approx;
    delta_ts = [delta_ts delta_t];
end
figure
hold on
plot(log10(delta_ts), log10(abs(differences)));
plot(log10(delta_ts), log10(delta_ts))
legend("Faktisk kurva", "Förväntad lutning (p=1)")
xlabel("Delta t (log10)")
ylabel("log10(abs(Ah-A2h))")
exportgraphics(gcf, 'uppgift5_fel_vs_delta_t.pdf', 'ContentType', 'vector');
%% error with fixed delta_t
M = 8;
pos = 1;
N = 10000;
[F, s, ~, ~, delta_t] = black_scholes(M, N);
old_approx = F(pos+1, 1);
differences = [];
delta_ss = [];
while M < 5000
    M = M * 2;
    pos = pos * 2;
    [F, s, ~, delta_s, ~] = black_scholes(M, N);
    approx = F(pos + 1, 1);
    differences = [differences approx-old_approx];
    old_approx = approx;
    delta_ss = [delta_ss delta_s];
end
figure
hold on
plot(log10(delta_ss), log10(abs(differences)));
plot(log10(delta_ss), log10(delta_ss.^2))
legend("Faktisk kurva", "Förväntad lutning (p=2)")
xlabel("Delta s (log10)")
ylabel("log10(abs(Ah-A2h))")
exportgraphics(gcf, 'uppgift5_fel_vs_delta_s.pdf', 'ContentType', 'vector');

%% Error with delta_s=k * delta_t
M = 8;
pos = 1;
N =16;
[F, s, ~, ~, delta_t] = black_scholes(M, N);
old_approx = F(pos+1, 1);
right_s = s(pos+1, 1);
differences = [];
delta_ss = [];
while N < 10000
    M = M * 2;
    N = N * 2;
    pos = pos * 2;
    [F, s, ~, delta_s, ~] = black_scholes(M, N);
    right_s - s(pos+1, 1)
    approx = F(pos + 1, 1);
    differences = [differences approx-old_approx];
    old_approx = approx;
    delta_ss = [delta_ss delta_s];
end
figure
hold on
plot(log10(delta_ss), log10(abs(differences)));
plot(log10(delta_ss), log10(delta_ss.^2))
legend("Faktisk kurva", "Förväntad lutning (p=1)")
xlabel("h (log10)")
ylabel("log10(abs(Ah-A2h))")
exportgraphics(gcf, 'uppgift5_fel_vs_h.pdf', 'ContentType', 'vector');