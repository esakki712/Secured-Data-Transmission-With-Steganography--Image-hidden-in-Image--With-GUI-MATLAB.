clc;
clear all;
close all;
message=input('Enter the text message sequence: ');
source=unique(message)
counts=zeros(1,length(source));
for i=1:length(source)
    counts(i)=length(strfind(message,source(i)));   
end
counts
seq=zeros(1,length(message));
for i=1:length(message)
    seq(i)=strfind(source,message(i));
end
seq
code = arithenco(seq, counts) 
dseq=arithdeco(code,counts,length(seq))
dec_mess=zeros(1,length(dseq));
for i=1:length(dseq)
    a=dseq(i);
    dec_mess(i)=source(a);
end
char(dec_mess)
