function encrypt = aes_simple_encryption(msg,key)
    global keydec
    [s_box, inv_s_box, w, poly_mat, inv_poly_mat] = aes_init(key);
    msg_hex=dec2hex(msg);
    plaintext = hex2dec(msg_hex);
    plaintext_len=length(plaintext);
    if(mod(length(plaintext),16)~=0)
        for i=1:16-mod(length(plaintext),16)
            plaintext(plaintext_len+i)=0;
        end
    end
    arr_size=length(plaintext)/16;
    start=1;
    stop=16;
    plaintextarray=[];
    for i=1:arr_size
        plaintextarray(i,1:16)=plaintext(start:stop);%16*n array
        start=stop+1;
        stop=stop+16;
    end
    start=1;
    stop=8;
    ciphertextarray=[];
    for i=1:arr_size
        start1=1;
        stop1=8;
        ciphertext = cipher (plaintextarray(i,:), w, s_box, poly_mat, 1);
        %fprintf('Cipher: '), disp(char(ciphertext));
        ciphertextarray(i,:)=ciphertext(1,:);
    end
    encrypt='';
    for i=1:arr_size
        for j=1:16
            encrypt=horzcat(encrypt,char(ciphertextarray(i,j)));
        end
    end 
end
