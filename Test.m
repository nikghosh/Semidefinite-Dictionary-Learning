clear; clc
d = 50; q = 10; r = 4; n = 200;
[q, r] = convert_params(q, r);
% Y = generate_lrm_instance(d, q, r, n);
Y = generate_sv_instance(d, q, r, n);
options = setoptions('sv_am', 'am_iters', 10, 'sc_iters', 50, 'parmode', 1);
[A, X, output] = learn_dict(Y, q, r, options);
plot(1:length(output.mse), output.mse)