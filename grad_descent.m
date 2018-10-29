function [A, epochs] = grad_descent(A, X, Y)
% Dictionary Update using gradient descent
[~, n] = size(Y);
epochs = 0;
max_epochs = 100;
epoch_size = 10;

% 16 x 16
eta = (5e-6)/n; 

% 8 x 8
% eta = 0.001;

err0 = norm(A * X - Y, 'fro');
% disp(err0)
delta = inf;
d0 = inf;

while epochs < max_epochs && delta >= 0.1 * d0  
    for i = 1:epoch_size
        A = A - eta * (A * X - Y) * X';
    end
    
    err1 = norm(A * X - Y, 'fro');
   % disp(err1)

    delta = err0 - err1;
   % disp(delta)

    if d0 == inf
        d0 = delta;
    end
    err0 = err1;
    
    epochs = epochs + 1;
end

disp(epochs)