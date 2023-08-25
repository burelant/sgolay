function obj = sgolay_coeffs(input,frame_half_length,order,options)

    % SGOLAY_COEFFS determines the local coefficients of a smoothing
    % polynom of specified order and frame half length.

    arguments
        input double {mustBeVector,mustBeReal}
        frame_half_length (1,1) double {mustBePositiveInteger(frame_half_length)}
        order (1,1) double {mustBePositiveInteger(order)}
        options.useParallel (1,1) logical = false
        options.regularize (1,1) logical = false
    end

    isColumn = iscolumn(input) ;

    if ~isColumn
        input = transpose(input) ;
    end

    N = size(input,1) ;

    if N <= order 
        error('The input vector has less elements than the polynomial order value.') ;
    end

    obj.coeffs = zeros(N,order+1) ;

    for i = 1:N

        i1 = max(1,i-frame_half_length) ;
        i2 = min(N,i+frame_half_length) ;

        xx = transpose(i1:i2) ;
        yy = input(i1:i2) ;

        if options.regularize == false
            p = polyfit(xx,yy,order) ;
        else
            X = repmat(xx,1,order+1).^[order:-1:0] ;
            p = pinv(X)*yy ;
            p = transpose(p) ;
        end

        obj.coeffs(i,:) = p ;
        
    end

    obj.input = input ;

end

function y = mustBePositiveInteger(x)

    rem = mod(x,1) ;

    if rem == 0 && x >= 0
        y = true ;
    else
        y = false ;
    end

end