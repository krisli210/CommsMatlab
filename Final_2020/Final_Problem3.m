clear all 
%EE360K Final Exam%
%Written by Kris Li - ksl842%
%Problem 3%
h = [1 -.323 1.25 -.74];
n_var = .25;
N = 16; n = N/2;
E_s_dim = 1; E_s = E_s_dim*N;
gap = 1; %Assumption from previous HWs

num_real = 2*ones(1, n+1);
num_real(1) = 1; num_real(end) = 1; %First and last subchannels are real, rest complex
%Part A%
H = freqz(h, 1);
H_n = cat(1, H(1:length(H)/n:end), H(end)); %Frequency response values
abs_H_n = abs(H_n);
g_n = abs_H_n.^2./n_var;
g_inv = 1./g_n;

level = (E_s + gap*sum(g_inv))/N;
E_n = level*num_real' - gap*g_inv;
N_p = N;
while any(E_n < 0) %Waterfilling steps
    for i = 1:length(E_n)
       if E_n(i) < 0
          disp('Remove n = ', num2str(i), 'th channel')
          N_p = N_p - 1; 
          g_n(i) = [];
          g_inv(i) = [];
          num_real(i) = [];
          level = (E_s + gap*sum(g_inv))/N_p;
          E_n = level*num_real' - gap*g_inv; 
       end
    end
end
n = [1:9]';
r_n = ((log2(level*g_n/gap)/2)'.*(num_real))';
rate = sum(r_n); 
efficiency = rate/N
SNR = gap*(2^(2*efficiency)-1);
SNR_MC_dB = 10*log10(SNR)

T = table(n, g_n, E_n, r_n) %Already scaled E_n and r_n by 2 on complex channels 
    
%Part B%
E_n = num_real; %now set powers to equal allocation
v = 4; 
n = 1.6e4;
%bits = 2*(randi(2,1,n)-1)-1;

errors = zeros(1,9);
subchannel_errors = zeros(1,9);

for i = 1:n/N 
   %TRANSMIT%
   %Seperate into n/N blocks of N symbols each
   data = 2*(randi(2,1,9)-1)-1;
   
   input = [fliplr(data(2:end)) data];
   pre_CP = ifft(input, 16);
   CP = pre_CP(end-v+1:end); %Defining cyclic prefix
   add_CP = [CP pre_CP];
   noise = sqrt(n_var)*randn(1,length(add_CP)+3);
   
   %RECEIVE%
   y = conv(h, add_CP) + noise;
   remove_GD = y(1:end-3);
   remove_CP = remove_GD(v+1:end);
   Y = fft(remove_CP, 16);
   
   P_m = fft(h, 16);
   scaled = Y./P_m;
    
   reconstructed = fliplr(scaled(1:9)); %1 Nyquist + 6 complex + 1 nyquist
   estimate = real(reconstructed); 
    estimate(estimate > 0) = 1;
    estimate(estimate < 0) = -1;
   
   %ERROR CALCULATIONS%
   errors = abs(data-estimate)/2;
   subchannel_errors = subchannel_errors + errors; 
   
end
P_e_per_channel = (subchannel_errors/(n/N));
average_P_e = sum(subchannel_errors)/n
SNR_OFDM_dB = 10*log10(qfuncinv(average_P_e)^2)
fixed_P_e = fliplr(P_e_per_channel);