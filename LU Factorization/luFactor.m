function [L, U, P] = luFactor(A)
% luFactor(A)
%	LU decomposition with pivotiing
% inputs:
%	A = coefficient matrix
% outputs:
%	L = lower triangular matrix
%	U = upper triangular matrix
%       P = the permutation matrix

% Insure matrix is square
[m, n] = size(A);
if m ~= n
    error('Square matricies only');
end

% Initialize L, U, and P
L = eye(n);
U = A;
P = eye(n);

% Partial pivoting implementation

for k = 1:n-1
    % Find the index of the largest absolute value in the kth column
    [~, pivot_index] = max(abs(U(k:n, k)));
    pivot_index = pivot_index + k - 1;

    % Swap rows in U and P
    U([k, pivot_index], k:n) = U([pivot_index, k], k:n);
    P([k, pivot_index], :) = P([pivot_index, k], :);

    % Swap elements in L
    if k > 1
        L([k, pivot_index], 1:k-1) = L([pivot_index, k], 1:k-1);
    end

    % Emlimination of values
    for i = k+1:n
        multiplier = U(i,k)/U(k,k);
        L(i,k) = multiplier;
        U(i,k:n) = U(i,k:n) - multiplier*U(k,k:n);
    end


end