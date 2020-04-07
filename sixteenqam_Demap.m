function [bits] = sixteenqam_Demap(sixteenqam_symbols, amp)
    bits = zeros(1,length(sixteenqam_symbols)*4);
    r_part = real(sixteenqam_symbols)/amp;
    i_part = imag(sixteenqam_symbols)/amp;
    for ii = 1:length(sixteenqam_symbols)
        if(r_part(ii) > 0)
           bits(ii*4-3) = 1; 
        end
        if(i_part(ii) > 0)
           bits(ii*4-1) = 1; 
        end
        if(abs(r_part(ii)) < 2)
           bits(ii*4-2) = 1; 
        end
        if(abs(i_part(ii)) < 2)
           bits(ii*4) = 1; 
        end
    end
end

