function [ X ] = lrm_ht( X, r )

% Matrix Hard Thresholding
[U,S,V] = svd(X);
X = U(:,1:r)*S(1:r,1:r)*V(:,1:r)';

end

