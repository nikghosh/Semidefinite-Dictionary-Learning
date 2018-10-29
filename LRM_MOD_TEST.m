d = 30; q = 8;
D = lrm_osi(randn(d, q, q));

M = 4000;
r = 4;
sigma = 0.01;

X = zeros(q*q, M);
for j = 1:M
    X_mat = randn(q, r) * randn(r, q);
    X(:,j) = X_mat(:);
end

D_flat = reshape(D, [d, q*q]);

Y = D_flat * X + sigma * randn(d, M);

options = setoptions('lrm_am', 'am_iters', 10, 'sc_iters', 20, 'parmode', 1);
[A, X, output] = learn_dict(Y, q, r, options);
plot(1:length(output.mse), output.mse)