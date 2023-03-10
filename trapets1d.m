function [area, error, N] = trapets1d(f,low, high, TOL)
%Performs trapetzoid (?) integration of the onedimensional function f over 
% the range [low, high]. The error calculations assuems that the function f
% is sufficiently "nice" so that the trapetzoid method is a second order
% method. 
%   input:
%       f - function to integrate
%       low - lower limit of integration
%       high - higher limit of integration
%       TOL - accepted error of approximation
%   output:
%       area - approximated area
%       error - approximated error of calculation
%       N - number of intervals in calculation
    N = 1;
    line_length = high - low;
    points = linspace(low, high, N+1);
    for i = 2:N
        points(i) = f(points(i)) * 2;
    end
    points(1) = f(points(1));
    points(end) = f(points(end));
    error = TOL * 2;
    h = line_length / N;
    area = sum(points) * h / 2;
    while error > TOL
        old_area = area;
        N = N * 2;
        h = line_length / N;
        points = linspace(low, high, N + 1);
        for i = 2:N
            points(i) = f(points(i)) * 2;
        end
        points(1) = f(points(1));
        points(end) = f(points(end));
        area = sum(points) * h / 2;
        error = abs((area - old_area) / 3);
    end
end