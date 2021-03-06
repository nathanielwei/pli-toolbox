function D = pli_pw_minkowski(X, Y, p)
%PLI_PW_MINKOWSKI Pairwise cityblock distances
%
%   D = PW_MINKOWSKI(X, [], p);
%
%       Evaluates pairwise minkowski distances (of order p) between 
%       columns in X.
%
%   D = PW_MINKOWSKI(X, Y, p);
%
%       Evaluates pairwise cityblock distances (of order p) between 
%       columns in X and Y.
%

%% argument checking

if ~(ismatrix(X) && isfloat(X) && isreal(X))
    error('pli_pw_minkowski:invalidarg', 'X must be a real matrix.');
end

if ~isempty(Y)
    if ~(ismatrix(Y) && isfloat(Y) && isreal(Y))
        error('pli_pw_minkowski:invalidarg', 'Y must be a real matrix.');
    end
    if size(Y, 1) ~= size(X, 1)
        error('pli_pw_minkowski:invalidarg', ...
            'The dimensions of X and Y are inconsistent.');
    end
end

if ~(isscalar(p) && isreal(p) && p >= 0)
    error('pli_pw_minkowski:invalidarg', ...
        'p should be a non-negative scalar.');        
end

    
%% main

if ~(isempty(Y) || isa(Y, class(X)))
    Y = cast(Y, class(X));
end

if p == 2
    D = pli_pw_euclidean(X, Y);
elseif p == 1
    D = pli_pw_cityblock(X, Y);
elseif p == 0
    D = pli_pw_hamming(X, Y);
elseif isinf(p)
    D = pli_pw_chebyshev(X, Y);
else
    D = pw_minkowski_cimp(double(p), X, Y);
end


