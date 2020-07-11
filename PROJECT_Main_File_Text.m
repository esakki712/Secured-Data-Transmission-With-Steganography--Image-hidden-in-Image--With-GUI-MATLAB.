% Main File to Run the Project!
% Making Use of RSA, SHA512, AES, PVD Steganography Algorithms!

% Creation of public and private key pairs
warning('off','all');
clearvars;
tic;
[Modulus, PublicExponent, PrivateExponent] = RSA_GenerateKeyPair;
[Modulus2, PublicExponent2, PrivateExponent2] = RSA_GenerateKeyPair;
clc;
fprintf('\n<===========================================>')
fprintf('\n<== Hybrid Cryptography and Steganography ==>')
fprintf('\n<===========================================>')
fprintf('\n<== Public and Private KeyPair Generation ==>')
fprintf('\n<===========================================>\n')
fprintf('Modulus:(Receiver) '), fprintf('%5d\n', Modulus)
fprintf('Public Key:(Receiver) '), fprintf('%5d\n', PublicExponent)
fprintf('Private Key:(Receiver) '), fprintf('%5d\n', PrivateExponent)
fprintf('\n<==========================================>\n')
fprintf('\n<==========================================>\n')
fprintf('Modulus:(Sender) '), fprintf('%5d\n', Modulus2)
fprintf('Public Key:(Sender) '), fprintf('%5d\n', PublicExponent2)
fprintf('Private Key:(Sender) '), fprintf('%5d\n', PrivateExponent2)
public_key = PublicExponent;
private_key = PrivateExponent;
modulus_key = Modulus;

% Generating Random Value X WRT public key!
fprintf('\n<===============================>')
fprintf('\n<== Random Value X Generation ==>')
fprintf('\n<===============================>\n')
randomvalue_x = 300;
fprintf('Random Value X: '), fprintf('%5d\n', randomvalue_x)

% Generating Value Y from X using RSA Algorithm!
Message_demo1 = int32(randomvalue_x);
Message = Message_demo1 + 48;
generated_Y = RSA_Encrypt(Modulus, PublicExponent, Message);
%generated_Y = char(generated_Y_demo);
fprintf('\n<========================>')
fprintf('\n<== Value Y Generation ==>')
fprintf('\n<========================>\n')
fprintf('Generated Y: ');disp(generated_Y);

% Sender Message Encryption using AES Algorithm!
fprintf('\n<========================>')
fprintf('\n<== Message Encryption ==>')
fprintf('\n<========================>\n')
plain_demo = 'VIRAT_KOHLI_WEDS_ANUSHKA_SHARMA';
fprintf('Plain Text: '), disp(plain_demo);
len_plain_demo = length(plain_demo);
init_vector = randi(255);
plain_ = [];
plain = [];
plain_ = bitxor(int32(plain_demo(1)),init_vector);
plain = bitxor(plain_(1),randomvalue_x);
for j = 2:len_plain_demo
    plain_(j) = bitxor(int32(plain_demo(j)),plain(j-1));
    plain(j) = bitxor(plain_(j),randomvalue_x);
end
%plain = '_VIRAT_KOHLI_';
plain = char(plain);
fprintf('Plain Text(CBC): '), disp(plain);
%fprintf('Plain Text: '), disp(plain);
%AES_preallocations;
%plaintext = AES_zerofill(plain);
%key = randomvalue_x;
%key = AES_zerofill(key);
%round_keys = AES_key_schedule(double(key));
ciphertext = aes_simple_encryption(plain,char(randomvalue_x));
%ciphertext = char(ciphertext_demo);
fprintf('\n<=======================>')
fprintf('\n<== Encrypted Message ==>')
fprintf('\n<=======================>\n')
disp(char(ciphertext));
len_cipher_text = length(ciphertext);

% Creating Digest for Sender Message!
digest = hash(plain,'SHA-512');
fprintf('\n<=================================>')
fprintf('\n<== Digest of Encrypted Message ==>')
fprintf('\n<=================================>\n')
disp(digest);

% Creating Digital Signature!
signature_demo = int32(digest);
digital_signature = RSA_Encrypt(Modulus2, PrivateExponent2, signature_demo);
%digital_signature = char(digital_signature_demo);
fprintf('\n<=====================================>')
fprintf('\n<== Generation of Digital Signature ==>')
fprintf('\n<=====================================>\n')
disp(char(digital_signature));

% Combining Digital Signature, Generated Y and ciphertext!
fid = fopen('PVD_Embed.txt','w');
fun = fprintf(fid,'%d\n',digital_signature);
fclose(fid);
fid = fopen('PVD_Embed.txt','a+');
fun2 = fprintf(fid,'%d\n',generated_Y);
fclose(fid);
fid = fopen('PVD_Embed.txt','a+');
fun2 = fprintf(fid,'%d\n',init_vector);
fclose(fid);
fid = fopen('PVD_Embed.txt','a+');
fun2 = fprintf(fid,'%d\n',ciphertext);
fclose(fid);
fprintf('\n<===============================>')
fprintf('\n<== Complete Message Created! ==>')
fprintf('\n<===============================>\n')

% Actual Steganography Embedding Process!
PVD_Embed('PVD_baboon.bmp');
fprintf('\n<====================================>')
fprintf('\n<== Steganographic Embedding Done! ==>')
fprintf('\n<====================================>\n')

% Sender Side Process Completed!
fprintf('\n<===================================>')
fprintf('\n<== Sender Side Process Completed ==>')
fprintf('\n<===================================>\n')

% Actual Steganography Extraction Process!
ch_final_msg = PVD_Extract;
fprintf('\n<===================================>')
fprintf('\n<== Steganographic Extraction Done! ==>')
fprintf('\n<===================================>\n')

% Demuxing Complete Message!
fid = fopen('PVD_Extract.txt','r');
A = fscanf(fid,'%d');
B = transpose(A);
digital_signature2_demo = B(1:128);
digital_signature2 = int32(digital_signature2_demo);
generated_Y2 = B(129);
result_init_vector = B(130);
ciphertext2 = B(131:(131 + len_cipher_text - 1));
fprintf('DIGI SIGN: ');disp(char(digital_signature2));
fprintf('CIPHER: ');disp(char(ciphertext2));
fprintf('Y: ');disp(generated_Y2);
fprintf('\bIV: ');disp(result_init_vector);
fprintf('\n<==========================================>')
fprintf('\n<== Demux of Complete Message Completed! ==>')
fprintf('\n<==========================================>\n')

% RSA Decryption to find X
RestoredMessage_demo = RSA_Decrypt(modulus_key, private_key, generated_Y);
RestoredMessage = RestoredMessage_demo - 48;
fprintf('\n<===========================>')
fprintf('\n<== Value of X Decrypted! ==>')
fprintf('\n<===========================>\n')
disp(RestoredMessage);

% Message Decryption
fprintf('\n<========================>')
fprintf('\n<== Message Decryption ==>')
fprintf('\n<========================>\n')
recovery = aes_simple_decryption(char(ciphertext2), char(randomvalue_x));
fprintf('Recovered Message(CBC): '), disp(char(recovery));
recov_ = [];
plaintext_recov_ = [];
plaintext_recov = [];
recov_(1) = bitxor(int32(recovery(1)),randomvalue_x);
plaintext_recov(1) = bitxor(recov_(1),result_init_vector);
for j = 2:len_plain_demo
    recov_(j) = bitxor(int32(recovery(j)),randomvalue_x);
    plaintext_recov(j) = bitxor(recov_(j),int32(recovery(j-1)));
end
plaintext_recov = char(plaintext_recov);
plaintext_recov_ = recovery(1:len_plain_demo);
fprintf('Recovered Plain Text: '), disp(plaintext_recov);
%fprintf('Recovered Plain Text: '), disp(char(recovery));
fprintf('\n<==========================================>')
fprintf('\n<== Plain Text Decrypted! ================z=>')
fprintf('\n<==========================================>\n')

% Digest of Decrypted Message
recovery = char(plaintext_recov_);
digest2 = hash(plaintext_recov_,'SHA-512');
fprintf('\n<=================================>')
fprintf('\n<== Digest of Decrypted Message ==>')
fprintf('\n<=================================>\n')
disp(digest2);

% Digest Generation from Digital Signature
digest3_demo = RSA_Decrypt(Modulus2, PublicExponent2, digital_signature2);
digest3 = char(digest3_demo);
fprintf('\n<===========================================>')
fprintf('\n<== Digest From Digital Signature Created ==>')
fprintf('\n<===========================================>\n')
disp(digest3);

% Integrity Verification
if digest2 == digest3
    fprintf('Integrity is Verified!');
else
    fprintf('Integrity is Not Verified!');
end
fprintf('\n');
toc
fprintf('\n');
