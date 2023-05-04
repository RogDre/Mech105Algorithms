function I = Simpson(x,y)
%calculates the definite integral of a set of equidistant data points
%takes two input vectors x and y, which represent the independent and dependent variables
%returns the definite integral I of the data using the Simpson's 1/3 rule.
%

    %check size of x and y
    [m,X]=size(x);
    [m,Y]=size(y);
    if X ~= Y
        error('x and y have different lengths');
    end

    %check for sufficient data
    if (X < 2)
        error('input data not have sufficient length');
    end

    %check for equally spacing data
    h = x(2) - x(1);
    for i=3:X
        if (x(i)-x(i-1)) ~= h
            error('x data is not equally spaced');
        end
    end
    %Simpson 1/3 rule
    %initialise sum
    sum = y(1);
    for i=2:(X-2)
        if mod(i,2)==0
            sum=sum+4*y(i);
        else
            sum=sum+2*y(i);
        end
    end
    %use trapezoidal rule for the last interval
    if mod(X,2) == 0
        warning('Trapezoidal rule is used for last interval');
        sum = sum + y(X-1);
        I = (sum*h/3) + ((y(X) + y(X-1))*h/2);
    else
        sum = sum + 4*y(X-1) + y(X);
        I=sum*h/3;
    end
    %print the result
    fprintf('Integral is:')
end