function Message = RSA_Decrypt(Modulus, PrivateExponent, Ciphertext)
    Message = RSA_ModularExponentiation(Ciphertext, PrivateExponent, Modulus);
end
