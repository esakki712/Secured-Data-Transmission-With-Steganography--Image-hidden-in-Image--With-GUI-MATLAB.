% https://en.wikipedia.org/wiki/Modular_exponentiation
% ftp://ftp.rsasecurity.com/pub/pdfs/tr201.pdf

function Result = RSA_ModularExponentiation(Base, Exponent, Modulus)

    Result          = 1;
    TempExponent    = 0;

    while true

        TempExponent    = TempExponent + 1;
        Result          = mod((Base .* Result), Modulus);

        if TempExponent == Exponent
            break
        end

    end

end
