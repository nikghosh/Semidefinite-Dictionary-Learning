function [ Y, A, X ] = generate_sv_instance( d, q, r, n )
X = zeros(q, n);
for i = 1 : n
    X(:, i) = sprand(q, 1, r/d);
end

A = randn(d, q);
Y = A*X;
end

