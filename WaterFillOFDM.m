%For EE360K HW 10 Question 3

E_s_dim = 1;

P1 = [1 .8];
N = 8;
gap_dB = 0;
n_var = .181; 
[r_n, efficiency, opt_E_n] = WaterFillOFDM_Cyclic(P1, n_var, E_s_dim, N, gap_dB)


P2 = [1 .5 1 -1]; 
n_var = .1; 
gap_dB = 3;

% k = 8;
% efficiencies = zeros(1, k);
% for i = 1:k
%     N = 2^i;
%     [r_n, efficiency, opt_E_n] = WaterFillOFDM_Cyclic(P2, n_var, E_s_dim, N, gap_dB);
%     efficiencies(i) = efficiency;
% end
% plot(1:8, efficiencies)
% title('k vs. Efficiency(N = 2^k)');
% xlabel('k')
% ylabel('Efficiency [bits/Hz]')

N = 8;
[r_n, efficiency, opt_E_n] = WaterFillOFDM_ZeroP(channel, n_var, E_s_dim, N, gap_dB);
