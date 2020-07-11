function decrypt = aes_simple_decryption(msg,key)
    global keydec
    [s_box, inv_s_box, w, poly_mat, inv_poly_mat] = aes_init(key);
    arr_size=length(msg)/16;
    start=1;
    ciphertextarray=[];
    for i=1:arr_size
        plaintext(1:16)=msg(start:(start+15));
        start = start + 16;
        %disp(plaintext);
        ciphertext = inv_cipher (double(plaintext), w, inv_s_box, inv_poly_mat, 1);
        %disp(char(ciphertext));
        re_plaintextarray(i,1:16)=ciphertext(1:16);
        %fprintf('DeCipher: '), disp(char(ciphertext));
        %ciphertextarray(i,:)=ciphertext(1,:);
    end
    decrypt='';
    for i=1:arr_size
        for j=1:16
            decrypt=horzcat(decrypt,char(re_plaintextarray(i,j)));
        end
    end
end