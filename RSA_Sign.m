function Signature = RSA_Sign(Modulus, PrivateExponent, Message)
    Signature = RSA_ModularExponentiation(Message, PrivateExponent, Modulus);
end
