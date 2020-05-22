clear all 

%EE360K Final Exam%
%Written by Kris Li - ksl842%
%Problem 1%
h = [1 -.323 1.25 -.74];
E_s_dim = 1;
n_var = .25;

%Part A%
q = h; %Since we use suboptimal receive filter 
freqz(q, 1);

%Part B%
SNR_MFB = E_s_dim*norm(h)^2/n_var;
SNR_MFB_dB = 10*log10(SNR_MFB)

%Part C%
P_e = 1e-4;
gap_dB = 6.6;
gap = 10^(gap_dB/10);
efficiency = log2(1+SNR_MFB/gap)

%Part D%
I = E_s_dim*sum(abs(h(2:end)).^2);
SINR = norm(h)^2*E_s_dim/(n_var + I);
SINR_dB = 10*log10(SINR)
predicted_P_e = qfunc(sqrt(SINR))
gap_P_e = qfunc(sqrt(SINR/gap))

%Part E%
n = 1e4;
bits = 2*(randi(2,1,n)-1)-1;
noise = sqrt(n_var)*randn(1,n);
response = conv(q,bits);
output = response(1:end-3) + noise; %Fix Group Delay
    output(output > 0) = 1; %Symbol Detection 
    output(output < 0) = -1;
measured_P_e = nnz(output-bits)/n



