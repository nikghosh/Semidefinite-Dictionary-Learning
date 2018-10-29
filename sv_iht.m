function [ X ] = sv_iht( A, b, r, sc_iters )
% Iterative Hard Thresholding
% Initialization
[~,q] = size(A);

b_norm = norm(b);   % Normalize b
b = b / b_norm;
X = zeros(q,1);     % Initialize at the origin

for ii = 1 : sc_iters
    
    % Compute gradient
    GRADSTEP = A'*(A*X-b);
    
    % Perform an exact line search
    ETA = 0.001;
    curr_err = norm(b - A * X );
    new_err = norm(b - A * ( X - ETA * GRADSTEP ) );
    while new_err < curr_err
        ETA = ETA * 2;
        curr_err = new_err;
        new_err = norm(b - A * ( X - ETA * GRADSTEP ) );
    end
    Xnew = X - 0.5 * ETA * GRADSTEP;
    % disp(ETA/2)
    
    % Project on to the set of r-sparse vectors
    X = sv_ht(Xnew, r);

end

% Output X
X = X * b_norm;

end

