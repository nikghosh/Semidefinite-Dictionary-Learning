function [ A, X, output ] = learn_dict( Y, q, r, options)
%LEARN_DICT Learns dictionary

% Unpack options
names = fieldnames(options);
for i = 1:length(names)
    eval([names{i} '=options.' names{i} ';'])
end

[d, ~] = size(Y);
if strcmp(method, 'sv_am')
    A = sv_normalize(randn(d, q));
else
    A = lrm_osi(randn(d, q, q));
end

mse = zeros(1, am_iters);

for i = 1:am_iters
    if strcmp(method, 'sv_am')
        [A, X, am_output] = sv_am(Y, A, r, ...
            damping_factor, least_squares, sc_iters, parmode);
    else
        [A, X, am_output] = lrm_am(Y, A, r, ...
            damping_factor, sc_iters, parmode);
    end
    
    if ~quiet
        fprintf('Iter: %d, Err: %f, Time: %f\n', ... 
            i, am_output.mse, am_output.elapsed_time) 
    end
    
    mse(i) = am_output.mse;
end
output.mse = mse;
end

