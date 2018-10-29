function [ X ] = lrm_svp( A, b, r, sc_iters)
% Singular Value Projection

% Initialization
[d,q,~] = size(A);
A_flat = reshape(A,[d,q*q]);

b_norm = norm(b);                   % Normalization
b = b / b_norm;
X = zeros(q,q);                     % Initialize at the origin

for ii = 1 : sc_iters  
    % Compute gradient
    f = @(x) norm(A_flat * x - b);
    x = X(:); 
    g = A_flat' * (A_flat * x - b);

    % Perform a line search
    ETA = 0.00001;
    while f(x - ETA * g) < f(x)
        ETA = ETA * 2;
    end
    x = x - 0.5 * ETA * g;
    Xnewfull = reshape(x, [q, q]);

    % Project on to space of rank-r matrices
    X = lrm_ht(Xnewfull, r);
end

% Output X
X = X * b_norm;
end
