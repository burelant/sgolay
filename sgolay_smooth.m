function y = sgolay_smooth(obj)

    input = obj.input ;

    N = numel(input) ;

    y = 0*input ;

    for i = 1:N
        p = obj.coeffs(i,:) ;
        y(i) = polyval(p,i) ;
    end

end