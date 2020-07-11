function [Modulus, PublicExponent, PrivateExponent] = RSA_GenerateKeyPair
    %prime_nos = primes(1023);
    %len_value = length(prime_nos);
    %p = prime_nos(len_value-1);
    %q = prime_nos(len_value);
    % 1. Generate a pair of large, random primes p and q
   % p = int32(randseed(randseed, 1, 1, 10, 200));
   % q = int32(randseed(randseed, 1, 1, 10, 200));
     a = primes(randi([140,210],1,1));
     p = a(length(a));
     q = a(length(a)-1);
    % 2. Compute the modulus n = pq
    n = p * q;

    % 3. Calculate Phi using Eulers totient function
    Phi         = (p - 1) * (q - 1);

    % 4. Find e that is relatively prime to Phi
    e = NaN;
    k = 1;
    for i = 3 : 2 : Phi - 1
        if gcd(i, Phi) == 1
            e(k) = int32(i);
            k = k + 1;
        end
    end

    if isnan(e)
        error('No relative prime between p - 1 and q - 1 was found.')
    end

    % 5. Compute the private exponent d from e, p and q.
    [~, d, ~]   = RSA_ExtendedEuclideanAlgorithm(e(length(e)-1), Phi);

    if d < 0
        d = Phi + d;
    end

    % 6. Output (n, e) as the public key and (n, d) as the private key
    Modulus         = n;
    PublicExponent  = e(length(e)-1);
    PrivateExponent = d;

end
