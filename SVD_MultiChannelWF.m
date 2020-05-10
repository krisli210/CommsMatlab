%For EE360K HW10 Question 2 On SVD OFDM System
SNR_dB = 10;
gap_dB = 0;
E_s_d = 1;
N = 8;
L = 1; 
T = 1;

SNR = 10^(SNR_dB/10);
gap = 10^(gap_dB/10);

E_s = (N + L)*E_s_d; 

channel = (1/sqrt(T))*[1 .8];
n_var = norm(channel)^2*E_s_d/SNR;

C = cat(2, channel, zeros(1, N+L-length(channel)));
R = zeros(1, N);
R(1) = C(1); 

P = toeplitz(C,R);
[U, S, V] = svd(P);
lam = diag(S)'

g_n = lam.^2/n_var;
g_inv = 1./g_n;

level = (E_s + gap*sum(g_inv))/N;
E_n = level - g_inv;
N_p = N;

while any(E_n < 0) %update steps
    for i = length(E_n):-1:1
       if E_n(i) < 0 
          N_p = N_p-1;
          g_n(i) = []; %remove power negative channel from consideration 
          g_inv(i) = [];
          level = (E_s + gap*sum(g_inv))/N_p;
          E_n = level - g_inv     
       end
    end
end

%r_n = (log2(level*g_n/gap))/2;
r_n = (log2(1+(E_n.*g_n)/gap))/2 %same as above
efficiency = sum(r_n)/(N+L);
SNR_svd = 10*log10(gap*(2^(2*efficiency)-1))


