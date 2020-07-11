function Ciphertext = RSA_Encrypt(Modulus, PublicExponent, Message)
    Ciphertext = RSA_ModularExponentiation(Message, PublicExponent, Modulus);   
end
