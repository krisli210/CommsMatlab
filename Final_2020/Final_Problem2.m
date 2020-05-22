clear all 
%EE360K Final Exam%
%Written by Kris Li - ksl842%
%Problem 2%
h = [1 -.323 1.25 -.74];
E_s_dim = 1;
n_var = .25;
L = 13;

%Part A%
R = cat(2, h, zeros(1, L-1));
C = cat(2, 1, zeros(1, L-1));
U = toeplitz(C,R);

%Part B%
e = zeros(1,length(h)+L-1);
e(7) = 1; %Corresponds to b[0] decision 
u_o = U*e';
c_ZF = (U*U')^-1*u_o;

%Part C%
o_response = c_ZF'*U; %b[0] @ index 7
desired = o_response(7); 
%removing desired energy from sum of overall response
interference = sum(o_response.^2)-desired^2

C_w = (1/norm(h)^2)*(U*U')*n_var;
n_var_ZF = c_ZF'*C_w*c_ZF
SINR = desired^2*E_s_dim/(interference*E_s_dim+n_var_ZF);
SINR_dB = 10*log10(SINR)
predicted_P_e = qfunc(sqrt(SINR)) %For 2PAM at given SINR 

%Part D%
n = 1e4;
bits = 2*(randi(2,1,n)-1)-1;
response = conv(h,bits);
noise = sqrt(n_var)*randn(1,length(response));
eq = conv(response+noise, c_ZF); %equalizing step
e_symbols = eq(7:end-9); %Fix GD (3+13-1)
    e_symbols(e_symbols > 0) = 1; %quantization
    e_symbols(e_symbols < 0) = -1;
measured_P_e = nnz(e_symbols-bits)/n 
measured_SNR_dB = 10*log10(qfuncinv(measured_P_e)^2)