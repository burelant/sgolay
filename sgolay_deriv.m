function y = sgolay_deriv(obj,order)

    % SGOLAY_DERIV returns the Nth derivative of a signal embedded in an
    % object generated from SGOLAY_COEFFS. The order of the derivative can
    % be specified using the order optional input argument.

    % Example:
    % mdl = sgolay_coeffs(input,5,2) ;
    % d1 = sgolay_deriv(mdl) ;
    % d2 = sgolay_deriv(mdl,2) ;

    arguments
        obj struct
        order (1,1) {mustBeReal,mustBePositive} = 1
    end

    if mod(order,1) ~= 0
        order = round(order) ;
        warning("The specified derivation order is not an integer. " ...
            +"Rounding to nearest integer.") ;
    end

    testObj = isfield(obj,"input") && isfield(obj,"coeffs") ;
    if ~ testObj
        error("The input SGOLAY_COEFFS object is not valid.") ;
    end

    testType = isnumeric(obj.input) && isnumeric(obj.coeffs) ;
    if ~ testType
        error("The input SGOLAY_COEFFS object is not valid" ... 
            + " (type mismatch).") ;
    end

    testSize = iscolumn(obj.input) && ...
        [numel(obj.input) == size(obj.coeffs,1)] ;
    if ~ testSize
        error("The input SGOLAY_COEFFS object is not valid" ... 
            + " (size mismatch).") ;
    end

    input = obj.input ;

    polynomial_order = size(obj.coeffs,2) ;
    if order > polynomial_order-1
        error("The requested derivation order cannot be larger than "+ ...
            num2str(polynomial_order-1)+".") ;
    end

    N = numel(input) ;

    y = 0*input ;

    for i = 1:N
        p = obj.coeffs(i,:) ;
        for o = 1:order
            p = polyder(p) ;
        end
        y(i) = polyval(p,i) ;
    end

end