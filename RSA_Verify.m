function IsVerified = RSA_Verify(Modulus, PublicExponent, Message, Signature)
    IsVerified = all(Message == RSA_ModularExponentiation(Signature, PublicExponent, Modulus));
end
