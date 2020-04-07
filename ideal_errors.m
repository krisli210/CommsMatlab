EbNo_dB = [0:1/10:10];
EbNo_raw = 10.^(EbNo_dB/10);

%BPSK%
BPSK_Pe = qfunc(sqrt(2*EbNo_raw));
figure;
plot(EbNo_dB, BPSK_Pe);
title('BPSK Ideal P_e');
xlabel('Eb/No (dB)')
ylabel('Probability of Error')

%QPSK%
QPSK_Pe = 2*qfunc(sqrt(2*EbNo_raw));
figure;
plot(EbNo_dB, QPSK_Pe);
title('QPSK Ideal P_e');
xlabel('Eb/No (dB)')
ylabel('Probability of Error')

%16QAM%
sixteenqam_Pe = 3*qfunc(sqrt(.8*EbNo_raw));
figure;
plot(EbNo_dB, sixteenqam_Pe);
title('16QAM Ideal P_e');
xlabel('Eb/No (dB)')
ylabel('Probability of Error')