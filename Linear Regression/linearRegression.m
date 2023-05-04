function [fX, fY, slope, intercept, Rsquared] = linearRegression(x,y)
%linearRegression Computes the linear regression of a data set
%   Compute the linear regression based on inputs:
%     1. x: x-values for our data set
%     2. y: y-values for our data set
%
%   Outputs:
%     1. fX: x-values with outliers removed
%     2. fY: y-values with outliers removed
%     3. slope: slope from the linear regression y=mx+b
%     4. intercept: intercept from the linear regression y=mx+b
%     5. Rsquared: R^2, a.k.a. coefficient of determination


% Removes outliers from data
% also determines quartile range
q = quantile(y,[0.25 0.75]); 
iqr = q(2)-q(1);
lower_bound = q(1) - 1.5*iqr;
upper_bound = q(2) + 1.5*iqr;
idx = (y >= lower_bound) & (y <= upper_bound); 
fX = x(idx);
fY = y(idx);

% Sort filtered data
[fY, idx_sort] = sort(fY);
fX = fX(idx_sort);

% Makes sure them arrays be matching iykyk
if numel(fX) ~= numel(fY) % Checks element numbers utilizing numel function
    error('fX and fY must have the same size stoopid');
end

% linear regression Calc
p = polyfit(fX,fY,1); % Fit a first-degree polynomial (i.e., a line) to the data
slope = p(1);
intercept = p(2);

% R-squared value calc
y_hat = p(1)*fX + p(2); % Predicted y values
SST = sum((fY-mean(fY)).^2); % Total sum of squares
SSE = sum((fY-y_hat).^2); % Sum of squared errors
Rsquared = 1 - SSE/SST;

end