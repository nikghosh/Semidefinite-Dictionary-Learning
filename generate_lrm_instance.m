function [ Y, A, X ] = generate_lrm_instance( d, q, r, n )
X = zeros(q, q, n);
for i = 1 : n
    X(:, :, i) = lrm_ht(randn(q, q), r);
end

A = randn(d, q, q);
Y = reshape(A, [d, q*q]) * reshape(X, [q*q, n]);
end

