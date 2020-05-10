%HW10 Q1.C
function [rate, r_n, E_n, efficiency, SNR_n, SNR] = WaterFillMultiChannel(N, channel, T, gap_dB, SNR_dB, E_s_d)
    SNR = 10^(SNR_dB/10);
    E_s = N*E_s_d;
    n_var = E_s_d*norm(channel)^2/SNR;
    gap = 10^(gap_dB/10);
    
    h = freqz(channel,1);
    n = N/2;
    
    num_real = 2*ones(1, n+1);
    num_real(1) = 1; num_real(end) = 1; %First and last subchannels are real, rest complex
    abs_H_n = abs(cat(1, h(1:length(h)/n:end), h(end)));
    SNR_n = (abs_H_n.^2)./n_var;
    g_n = abs_H_n.^2./n_var;
    g_inv = 1./g_n;
    
    
    level = (E_s + gap*sum(g_inv))/N;
    E_n = level*num_real' - gap*g_inv;
    
    N_p = N;
    
    while any(E_n < 0)
        for i = length(E_n):-1:1
           if E_n(i) < 0
              N_p = N_p-1;
              g_n(i) = [];
              g_inv(i) = [];
              num_real(i) = [];
              level = (E_s + gap*sum(g_inv))/N_p; %new level 
              E_n = level*num_real' - gap*g_inv; %update powers
           end      
        end    
    end
    
    r_n = (log2(level*g_n/gap)/2)'.*(num_real);
    rate = sum(r_n); 
    efficiency = rate/N;
    SNR = gap*(2^(2*efficiency)-1);
end