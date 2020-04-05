function [sixteenqam_symbols] = sixteenqam_map(bits)
    M = 16; k = log2(M); N = length(bits)/k;
    bits_reshape = reshape(bits, k, N).';
    map = [-3 -1 1 3];
    
    %Real%
    r_part = bits_reshape(:, [1:(k/2)]);
    dec_r = bi2de(r_part, 'left-msb');
    r_index = bitxor(dec_r, floor(dec_r/2));
    r_amp = map(r_index+1);
    
    %Imag%
    i_part = bits_reshape(:,[(k/2)+1:k]);
    dec_i = bi2de(i_part, 'left-msb');
    i_index = bitxor(dec_i, floor(dec_i/2));
    i_amp = map(i_index+1);
   
    sixteenqam_symbols = r_amp+1j*i_amp;
    
end