function [ options ] = setoptions(method, varargin)
p = inputParser;

isboolean = @(x) isnumeric(x) && (x == 0 || x == 1);

validMethods = {'sv_am', 'lrm_am'};
checkMethod = @(x) any(validatestring(x, validMethods));

addRequired(p, 'method', checkMethod);
addParameter(p, 'quiet', 0, isboolean);
addParameter(p, 'am_iters', 20, @isnumeric);
addParameter(p, 'sc_iters', 20, @isnumeric);
addParameter(p, 'least_squares', 0, isboolean);
addParameter(p, 'damping_factor', 0.5, @isnumeric);
addParameter(p, 'parmode', 0, isboolean);
parse(p, method, varargin{:})

options = p.Results;
end

