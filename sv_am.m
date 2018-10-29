function [A, X, output] = sv_am(Y, A, r, df, ls, sc_iters, parmode)
% One step of the alternating minimization algorithm for recovering A

% Usage
% Y is data matrix. Data arranged in columns
% A is the initial estimate
% r is sparsity of lifted represented
% parmode: Set to 1 to run the variety constrained optimization step in
% parallel, otherwise set to 0
% ls 0 for pinv, 1 for gradient descent

% Tunable parameters
% Damp factor
% 1 for no damping, Choose a value in (0,1]

% Begin algorithm
[~, n] = size(Y);
[~, q] = size(A);

% Solve optimization instance
X = zeros(q, n);              % Optimal X

% Start Timer
tic
if parmode == 1
    % PARALLEL FOR LOOP % % % % % % % % % %
    parfor j = 1 : n
        X(:, j) = sv_iht(A, Y(:, j), r, sc_iters);
    end
    % % % % % % % % % % % % % % % % % % % %
else
    % SERIAL FOR LOOP % % % % % % % % % %
    for j = 1 : n
        X(:, j) = sv_iht(A, Y(:, j), r, sc_iters);
    end
    % % % % % % % % % % % % % % % % % % % %
end
 
% Pseudo-inverse + Damp + Normalize % % % % % % % % % % % % % % % % % % %
if ls == 0
    Aint = Y/X;
    Anew = (1-df) * Aint + df * A;
else
    Anew = grad_descent(A, X, Y);
end

% Normalize columns
Anew = sv_normalize(Anew);
A = Anew;

output.mse = immse(Y, A*X);
output.elapsed_time = toc;
end