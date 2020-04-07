function [bits] = qpskDemap(qpsk_symbols)
    bits = zeros(1, 2*length(qpsk_symbols));
    r_part = real(qpsk_symbols);
        r_part(r_part < 0) = 0;
        r_part(r_part > 0) = 1;
    i_part = imag(qpsk_symbols);
        i_part(i_part < 0) = 0;
        i_part(i_part > 0) = 1;
    dbl_ind = 0;
    for i=1:length(qpsk_symbols)
        bits(i+dbl_ind) = r_part(i);
        bits(i+dbl_ind+1) = i_part(i);
        dbl_ind = dbl_ind+1;
    end
end
