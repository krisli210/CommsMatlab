function [bpsk_symbols, Eb] = bpskmap(bit)
    bpsk_symbols = 2*bit-1;
    Eb = 1;
end

