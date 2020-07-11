% http://www.mathaware.org/mam/06/Kaliski.pdf
% regarding the negative 'd' parameter: https://www2.informatik.uni-hamburg.de/wsv/teaching/sonstiges/EwA-Folien/Sohst-Paper.pdf

clc
clear
close all

Text            = '7';
Message         = int32(Text);

fprintf('-Input-\n')
fprintf('Original message:       ''%s''\n', Text)
fprintf('Integer representation: %s\n', num2str(Message))

%% Generate Key Pair

[Modulus, PublicExponent, PrivateExponent] = RSA_GenerateKeyPair;

fprintf('\n-Key Pair-\n')
fprintf('Modulus:                '), fprintf('%5d\n', Modulus)
fprintf('Public Exponent:        '), fprintf('%5d\n', PublicExponent)
fprintf('Private Exponent:       '), fprintf('%5d\n', PrivateExponent)

%% Encrypt / Decrypt
disp(Message);
Ciphertext      = RSA_Encrypt(Modulus, PublicExponent, Message);
RestoredMessage	= RSA_Decrypt(Modulus, PrivateExponent, Ciphertext);

fprintf('\n-Encryption-\n')
fprintf('Ciphertext:             %s [ %s ]\n', num2str(Ciphertext), char(Ciphertext))
fprintf('Restored Message:       ''%s''\n', char(RestoredMessage))

%% Sign / Validate

Signature       = RSA_Sign(Modulus, PrivateExponent, Message);
IsVerified      = RSA_Verify(Modulus, PublicExponent, Message, Signature);

fprintf('\n-Signing-\n')
fprintf('Signature:              %s [ %s ]\n', num2str(Signature), char(Signature))
fprintf('Is Verified:            %d\n', IsVerified)
