% https://en.wikibooks.org/wiki/Algorithm_Implementation/Mathematics/Extended_Euclidean_algorithm
% ax + by = g = gcd(a, b)
function [gcd, x, y] = RSA_ExtendedEuclideanAlgorithm(a, b)
    a = int32(a);
    b = int32(b);
    x = int32(0);
    y = int32(1);
    u = int32(1);
    v = int32(0);
    while a ~= 0
        q = idivide(b, a);
        r = mod(b, a);
        m = x - u*q;
        n = y - v*q;
        b = a;
        a = r;
        x = u;
        y = v;
        u = m;
        v = n;
    end
    gcd = b;
end
