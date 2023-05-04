function [root, fx, ea, iter] = falsePosition(func, xl, xu, es, maxit, varargin)
%falsePosition finds the root of a function using false position method
% Inputs:
%   - func: the function being evaluated
%   - xl: the lower guess
%   - xu: the upper guess
%   - es: the desired relative error (should default to 0.0001%)
%   - maxit: the maximum number of iterations to use (should default to 200)
%   - varargin: any additional parameters used by the function
% Outputs:
%   - root: the estimated root location
%   - fx: the function evaluated at the root location
%   - ea: the approximate relative error (%)
%   - iter: how many iterations were performed

% Check inputs
if nargin < 3
    error('At least 3 inputs are required.');
end
if nargin < 4 || isempty(es)
    es = 0.0001; % Default value
end
if nargin < 5 || isempty(maxit)
    maxit = 200; % Default value
end

% Initialize variables
iter = 0;
xr = xl;
ea = 100; % Initial value
fxr = func(xr, varargin{:});
test = fxr * func(xu, varargin{:});

% Check if the initial guesses bracket the root
if test > 0
    error('The initial guesses do not bracket the root.');
end

% Loop until the desired relative error is achieved or the maximum number
% of iterations is reached
while ea > es && iter < maxit
    xrold = xr;
    iter = iter + 1;
    xr = xu - (func(xu, varargin{:}) * (xl - xu)) / (func(xl, varargin{:}) - func(xu, varargin{:}));
    fxr = func(xr, varargin{:});
    test = fxr * func(xu, varargin{:});
    if test < 0
        xl = xr;
    elseif test > 0
        xu = xr;
    else
        ea = 0;
    end
    if iter > 1
        ea = abs((xr - xrold) / xr) * 100;
    end
end

% Set outputs
root = xr;
fx = fxr;
end
