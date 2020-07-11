% Main File to Run the Project!
% Making Use of RSA, SHA512, AES, PVD Steganography Algorithms!

% Creation of public and private key pairs
warning('off','all');
tic;
clearvars;
clear all
tic;
[Modulus, PublicExponent, PrivateExponent] = RSA_GenerateKeyPair;
[Modulus2, PublicExponent2, PrivateExponent2] = RSA_GenerateKeyPair;
clc;
pixel = 64;
fprintf('\n<===========================================>')
fprintf('\n<== Hybrid Cryptography and Steganography ==>')
fprintf('\n<===========================================>')
fprintf('\n<== Public and Private KeyPair Generation ==>')
fprintf('\n<===========================================>\n')
fprintf('Modulus:(Receiver) '), fprintf('%d\n', Modulus)
fprintf('Public Key:(Receiver) '), fprintf('%d\n', PublicExponent)
fprintf('Private Key:(Receiver) '), fprintf('%d\n', PrivateExponent)
fprintf('\n<==========================================>\n')
fprintf('\n<==========================================>\n')
fprintf('Modulus:(Sender) '), fprintf('%d\n', Modulus2)
fprintf('Public Key:(Sender) '), fprintf('%d\n', PublicExponent2)
fprintf('Private Key:(Sender) '), fprintf('%d\n', PrivateExponent2)
public_key = PublicExponent;
private_key = PrivateExponent;
modulus_key = Modulus;

% Generating Random Value X WRT public key!
fprintf('\n<===============================>')
fprintf('\n<== Random Value X Generation ==>')
fprintf('\n<===============================>\n')
randomvalue_x = randi(public_key);
fprintf('Random Value X: '), fprintf('%d\n', randomvalue_x)

% Generating Value Y from X using RSA Algorithm!
Message_demo1 = int32(randomvalue_x);
Message = Message_demo1 + 48;
generated_Y = RSA_Encrypt(Modulus, PublicExponent, Message);
%generated_Y = char(generated_Y_demo);
fprintf('\n<========================>')
fprintf('\n<== Value Y Generation ==>')
fprintf('\n<========================>\n')
fprintf('Generated Y: ');disp(generated_Y);

fprintf('\n<========================>')
fprintf('\n<== Message Encryption ==>')
fprintf('\n<========================>\n')
input = imread('dogie64.bmp');
crypted = imread('dogie64.bmp');
result_recov = imread('dogie64.bmp');
b = 1;
subimage = {1:pixel};
init_vector = [];
for j = 1:pixel
    init_vector(j) = randi(255);
end
init_vector = int32(init_vector);
for j = 1:pixel
    subimage{j} = char(input((b):(b+(pixel-1))));
    b = b + pixel;
end
key = char(randomvalue_x);
encrypt = {1:pixel};
row = {1:pixel};
row{1} = bitxor(int32(subimage{1}),init_vector);
%disp(row{1});
encrypt{1} = aes_simple_encryption(row{1},key);
crypted(1:pixel) = double(encrypt{1});
enc = [];
k = pixel+1;
enc(1:pixel) = int32(encrypt{1});
for j = 2:pixel
     row{j} = bitxor(int32(subimage{j}),int32(encrypt{j-1}));
     encrypt{j} = aes_simple_encryption(row{j},key);
     crypted((k):(k+(pixel-1))) = double(encrypt{j});
     enc((k):(k+(pixel-1))) = int32(encrypt{j});
     k = k + pixel;
end
imwrite(crypted,'encrypted.bmp');
fprintf('\n<=============================>')
fprintf('\n<== Encrypted Image Created ==>')
fprintf('\n<=============================>\n')

% Creating Digest for Sender Message!
digest = hash(char(enc),'SHA-512');
fprintf('\n<=================================>')
fprintf('\n<== Digest of Encrypted Message ==>')
fprintf('\n<=================================>\n')
disp(digest);
%fprintf('Enc: ') ,disp(enc);
%fprintf('Enc Length'), disp(length(enc));

signature_demo = int32(digest);
digital_signature = RSA_Encrypt(Modulus2, PrivateExponent2, signature_demo);
%digital_signature = char(digital_signature_demo);
fprintf('\n<=====================================>')
fprintf('\n<== Generation of Digital Signature ==>')
fprintf('\n<=====================================>\n')
disp(char(digital_signature));

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
fun2 = fprintf(fid,'%d\n',int32(enc));
fclose(fid);
fprintf('\n<===============================>')
fprintf('\n<== Complete Message Created! ==>')
fprintf('\n<===============================>\n')

% Actual Steganography Embedding Process!
PVD_Embed;
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
result_init_vector = B(130:(130+pixel-1));
ciphertext2 = B((130+pixel):((130+pixel)+((pixel*pixel)-1)));
fprintf('DIGI SIGN: ');disp(char(digital_signature2));
fprintf('CIPHER: ');disp(char(ciphertext2));
fprintf('Y: ');disp(generated_Y2);
fprintf('\bIV: ');disp(result_init_vector);
fprintf('\n<==========================================>')
fprintf('\n<== Demux of Complete Message Completed! ==>')
fprintf('\n<==========================================>\n')

% RSA Decryption to find X
RestoredMessage_demo = RSA_Decrypt(Modulus, PrivateExponent, generated_Y);
RestoredMessage = RestoredMessage_demo - 48;
fprintf('\n<===========================>')
fprintf('\n<== Value of X Decrypted! ==>')
fprintf('\n<===========================>\n')
disp(RestoredMessage);

% Message Decryption
fprintf('\n<========================>')
fprintf('\n<== Message Decryption ==>')
fprintf('\n<========================>\n')
pubimage = {1:pixel};
b = 1;
for j = 1:pixel
    pubimage{j} = char(ciphertext2((b):(b+pixel-1)));
    b = b + pixel;
end
dec = [];
decrypt2 = {1:pixel};
recovery = {1:pixel};
decrypt2{1} = aes_simple_decryption(pubimage{1},key);
recovery{1} = bitxor(int32(decrypt2{1}), int32(result_init_vector));
result_recov(1:pixel) = double(recovery{1});
k = pixel+1;
dec(1:pixel) = int32(decrypt2{1});
for j = 2:pixel
     decrypt2{j} = aes_simple_decryption(pubimage{j},key);
     recovery{j} = bitxor(int32(decrypt2{j}),int32(pubimage{j-1}));
     result_recov((k):(k+pixel-1)) = double(recovery{j});
     dec((k):(k+pixel-1)) = int32(decrypt2{j});
     k = k + pixel;
end
imwrite(result_recov,'decrypted.bmp');
fprintf('\n<==========================================>')
fprintf('\n<== Plain Image Decrypted! =================>')
fprintf('\n<==========================================>\n')

% Digest of Decrypted Message
%fprintf('Dec: ') ,disp(dec);
%fprintf('Dec Length'), disp(length(dec));
recovery = char(ciphertext2);
digest2 = hash(recovery,'SHA-512');
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