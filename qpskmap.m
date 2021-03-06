function [qpsk_symbols, Eb] = qpskmap(bits)
    qpsk_symbols = zeros(1,length(bits)/2);
    amps = bits*2-1;
    dbl_ind = 0;
    for i=1:length(amps)/2
        r_part = amps(i+dbl_ind);
        c_part = amps(i+dbl_ind+1)*1j;
        qpsk_symbols(i) = r_part+c_part;
        dbl_ind = dbl_ind + 1;
    end
    Eb = 1;
end


