close all 
clc

EbNo_dB = [0:10]; %Different Eb/No 0-15 dB

EbNo_dB_desired_bpsk = 4.3; %to attain theoretical 10^-2 symbol error rate
%BPSK%
    bits = randi(2,1,12000)-1;
    [bpsk_symbols, Eb_bpsk] = bpskmap(bits);
    EbNo_raw = 10^(EbNo_dB_desired_bpsk/10);
    No = Eb_bpsk/EbNo_raw;
    variance_bpsk = No/2
    [receive_input_bpsk, receive_output_bpsk] = channel(bpsk_symbols, No);
    
    %With MF%
    channel_and_noise_MF = receive_output_bpsk;
    fix_GD_MF = channel_and_noise_MF(47:end-46);
    recovered_MF = downsample(fix_GD_MF, 4);
    
    figure;
    plot(real(recovered_MF), imag(recovered_MF), 'b.');
    title('Decision Statistics for BPSK')
    xlabel('Real Part')
    ylabel('Imag Part')
    
    recovered_MF(recovered_MF < 0) = 0;
    recovered_MF(recovered_MF > 0) = 1;
    errors_MF = nnz(recovered_MF.'-bits);
    Pe_bpsk = errors_MF/length(bits)
    
%End BPSK%
    
EbNo_dB_desired_qpsk = 5.2; %to attain theoretical 10^-2 symbol error rate    
%QPSK%
    bits_qpsk = randi(2,1,12000)-1; 
    [qpsk_symbols, Eb_qpsk] = qpskmap(bits_qpsk);
    EbNo_raw = 10^(EbNo_dB_desired_qpsk/10);
    No = Eb_qpsk/EbNo_raw;
    variance_qpsk = No/2
    [receive_input_qpsk, receive_output_qpsk] = channel(qpsk_symbols, No);
    
    %With MF%
    fix_GD_qpsk = receive_output_qpsk(47: end-46);
    recovered_qpsk = downsample(fix_GD_qpsk, 4);
    
    figure;
    plot(real(recovered_qpsk), imag(recovered_qpsk), 'b.');
    title('Decision Statistics for QPSK')
    xlabel('Real Part')
    ylabel('Imag Part')
   
    %QPSK Map Symbol -> bits
    recovered_bits = qpskDemap(recovered_qpsk);
    errors_qpsk = nnz(recovered_bits - bits_qpsk);
    Pe_qpsk = errors_qpsk/length(bits_qpsk)
    
EbNo_dB_desired_16qam = 9.6; %to attain theoretical 10^-2 symbol error rate   

%16QAM%
    bits_16_qam = randi(2,1,12000)-1;
    [sixteenqam_symbols, Eb_16qam] = sixteenqam_map(bits_16_qam);
    EbNo_raw = 10^(EbNo_dB_desired_16qam/10);
    No = Eb_16qam/EbNo_raw;
    variance_16 = No/2
    [receive_input_16qam, receive_output_16qam] = channel(sixteenqam_symbols, No);
    
    %With MF%
    fix_GD_16 = receive_output_16qam(47: end-46);
    recovered_16 = downsample(fix_GD_16, 4);
    
    figure;
    plot(real(recovered_16), imag(recovered_16), 'b.');
    title('Decision Statistics for 16QAM')
    xlabel('Real Part')
    ylabel('Imag Part')
    
    recovered_bits_16 = sixteenqam_Demap(recovered_16, 3.37);
    errors_16 = nnz(recovered_bits_16 - bits_16_qam);
    Pe_16 = errors_16/length(bits_16_qam)