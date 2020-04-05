EbNo_dB = [0:10]; %Different Eb/No 0-15 dB

%BPSK%
for ii = 1:length(EbNo_dB)
    bits = randi(2,1,12000)-1;
    [bpsk_symbols, Eb_bpsk] = bpskmap(bits);
    filtered_bpsk = channel(bpsk_symbols);
    EbNo_raw = 10^(EbNo_dB(ii)/10);
    No = Eb_bpsk/EbNo_raw;
    noisevec = sqrt(No/2)*randn(1,length(filtered_bpsk));
    
end
%D%