clear all

h1 = 1+1j;
h2 = -3j;
N1 = 1;
N2 = 2;

gam1 = abs(h1)^2/N1;
gam2 = abs(h2)^2/N2;
gam1_inv = 1/gam1;
gam2_inv = 1/gam2;

P = 2;
rate_eq = zeros(1,length(P));
rate_opt = zeros(1,length(P));

%equal power%
P1_eq = P/2;
P2_eq = P/2;
rate_eq_1 = log2(1+P1_eq*gam1);
rate_eq_2 = log2(1+P2_eq*gam2);
rate_eq = rate_eq_1+rate_eq_2;

%opt power%
for i = 1:length(P)
    a = (P(i)+(gam1_inv+gam2_inv))/2;
    P1_opt = max(a - gam1_inv, 0);
    P2_opt = max(a - gam2_inv, 0);
    if P1_opt == 0 
       P2_opt = P(i);
    end
    rate_opt_1 = log2(1+P1_opt*gam1);
    rate_opt_2 = log2(1+P2_opt*gam2);
    rate_opt(i) = rate_opt_1 + rate_opt_2;
end

figure;
plot(P, rate_eq);
hold;
plot(P, rate_opt);
title('Rate of Equal vs Optimal Power Allocation');
xlabel('Power [W]');
ylabel('Rate [bits/second]');
legend('Equal', 'Optimal');