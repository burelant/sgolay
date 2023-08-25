function y = sgolay_deriv(obj,order)

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