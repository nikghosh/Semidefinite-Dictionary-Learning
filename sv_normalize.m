function [ X ] = svnormalize( X )
%SVNORMALIZE normalize columns of X
[~, n] = size(X);
for i = 1:n
    X(:, i) = X(:, i) / norm(X(:, i));
end
end

