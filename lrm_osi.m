% Normalizes a linear map from q by q matrices to d-dimensional space via
% Operator Sinkhorn Scaling
%
% The input of A should be a [d,q,q] array
% The output is a normalized linear map with the same dimensions

function [ normA ] = lrm_osi( A )

% Grab dimensions and reshape
[d, q, ~] = size(A);
normA = permute(A,[2,3,1]);

% Termination criteria
tol = 10^(-3);
err = 1;

while (err > tol)    
    % Row scaling
    CRI = zeros(q,q);
    for j = 1:d
        CRI = CRI + normA(:,:,j)*normA(:,:,j)';
    end
    CRInv = inv(sqrtm(CRI)) * q^(1/2);
    for j = 1:d
        normA(:,:,j) = CRInv*normA(:,:,j);
    end

    % Column scaling
    CSI = zeros(q,q);
    for j = 1:d
        CSI = CSI + normA(:,:,j)'*normA(:,:,j);
    end
    CSInv = inv(sqrtm(CSI)) * q^(1/2);
    for j = 1:d
        normA(:,:,j) = normA(:,:,j) * CSInv;
    end
    
    % Check termination criteria
    err = norm(CRI - q * eye(q)) + norm(CSI - q * eye(q));
    err = err / q;
end

% Reshaping the output
normA = permute(normA,[3,1,2]) * q;

end