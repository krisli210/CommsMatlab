function [opt_powers] = WaterFilling_nChannels(channels, N_per_chan, power)
    n = length(channels);
    gam = abs(channels).^2./N_per_chan
    gam_inv = 1./gam;
    opt_powers = zeros(1, n)-1;
    
    while any(opt_powers < 0)
        level = (power + sum(gam_inv))/n;
        opt_powers = level - gam_inv; 
        for i = 1:n
           if opt_powers(i) < 0
                gam_inv(i) = 0 ; % discard channel
           end
        end
    end
end