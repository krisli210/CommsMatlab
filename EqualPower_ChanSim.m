%Q1.A, B
N = 8;
P = [1 .8];
h = freqz(P,1);
n = N/2;
n_var = .181;    
gap = 1;

abs_H_n = abs(cat(1, h(1:length(h)/n:end), h(end)));

num_real = 2*ones(1, n+1);
num_real(1) = 1; num_real(end) = 1; %First and last subchannels are real, rest complex
SNR_n = (abs_H_n.^2)./n_var
r_n = ((log2(1+(SNR_n/gap)))/2)'.*num_real
r = sum(r_n);
efficiency = r/N
SNR = gap*(2^(2*efficiency)-1);
SNR_dB = 10*log10(SNR)

N = 16; 
n = N/2;
abs_H_n = abs(cat(1, h(1:length(h)/n:end), h(end)));

num_real = 2*ones(1, n+1);
num_real(1) = 1; num_real(end) = 1; %First and last subchannels are real, rest complex
SNR_n = (abs_H_n.^2)./n_var
r_n = ((log2(1+(SNR_n/gap)))/2)'.*num_real
r = sum(r_n);
efficiency = r/N
SNR = gap*(2^(2*efficiency)-1);
SNR_dB = 10*log10(SNR)
