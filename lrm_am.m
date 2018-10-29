function [ A, X, output ] = lrm_am( Y, A, r, df, sc_iters, parmode)
% One step of the alternating minimization algorithm for recovering A

% Usage
% Y is data matrix. Data arranged in columns
% r is rank of lifted represented
% parmode: Set to 1 to run the variety constrained optimization step in
% parallel, otherwise set to 0

% Tunable parameters
% Damp factor
% 1 for no damping, Choose a value in (0,1]

% Begin algorithm
[d, n] = size(Y);
[~, q, ~] = size(A);

X_flat = zeros(q*q, n);   

tic
% Run the main LRM SVP engine over all observations
if parmode == 1 % Parallel mode
    parfor j = 1 : n
         X = lrm_svp(A, Y(:,j), r, sc_iters);
         X_flat(:, j) = X(:);
    end
else % Non parallel mode prints an output to screen
    for j = 1 : n
        X = lrm_svp(A, Y(:,j), r, sc_iters);
        X_flat(:, j) = X(:);   
    end
end

X = reshape(X_flat, [q,q,n]);

% Pseudo-inverse + Damp + Normalize % % % % % 
A_int = reshape(Y/X_flat,[d,q,q]);
A_new = lrm_osi(df*A_int+(1-df)*A);
A = A_new;
A_flat = reshape(A, [d, q*q]);

output.mse =  sqrt(norm(Y - A_flat * X_flat, 'fro')^2 / (d * n));
output.elapsed_time = toc;
end