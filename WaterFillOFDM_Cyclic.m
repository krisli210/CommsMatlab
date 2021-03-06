function [r_n, efficiency, opt_E_n] = WaterFillOFDM_Cyclic(channel, n_var, E_s_dim, N, gap_dB)

    h = channel;   % the channel
    h_rev = fliplr(h);   % the time reversed channel
    v = length(h)-1;     % # of ISI taps
    P = toeplitz([h zeros(1,N-1)], [h(1) zeros(1,N-1)]);   % For my matrix vector definition, assuming zero prefix
    H_OFDM =  toeplitz([h zeros(1,N-v-1)], [h(1) zeros(1,N-v-1) h_rev(1:v)]);    % for OFDM, assuming cyclic prefix
    
    gap = 10^(gap_dB/10);
    E_s = E_s_dim*(N);
    
    %lam = abs(fft(P, N))
    lam = abs(eig(H_OFDM));
    lam = sort(lam, 'descend');
    g_n = lam.^2/n_var;
    g_inv = 1./g_n;
    
    level = (E_s + gap*sum(g_inv))/N;
    opt_E_n = level - g_inv;
    N_p = N;
    
    while any(opt_E_n < 0) %update steps
        for i = length(opt_E_n):-1:1
           if opt_E_n(i) < 0 
              N_p = N_p-1;
              g_n(i) = []; %remove power negative channel from consideration 
              g_inv(i) = [];
              level = (E_s + gap*sum(g_inv))/N_p;
              opt_E_n = level - g_inv;     
           end
        end
    end
    r_n = (log2(level*g_n/gap))/2;  
    %r_n = (log2(1+(E_n.*g_n)/gap))/2; %same as above
    efficiency = sum(r_n)/(N+v); %Penalty for cyclic prefix
    SNR_OFDM = 10*log10(gap*(2^(2*efficiency)-1))
end