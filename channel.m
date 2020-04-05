function [receive_input, receive_output] = channel(symbols) 
    %%%%%%%%%%%%%TRANSMIT FILTER SPECIFICATION%%%%%%%%%%%%%%%%
    %FILTER IS IMPLEMENTED AT RATE m/T, where m = oversampling factor
    oversampling_factor = 4;%%%default choice
    m=4; %oversampling facrtor
    T=m;

    %CHOICE OF TRANSMIT FILTER FOR LAB 1
    %first specify half of the filter
    hhalf = [-0.025288315;-0.034167931;-0.035752323;-0.016733702;0.021602514;
    0.064938487;0.091002137;0.081894974;0.037071157;-0.021998074;-0.060716277 ;
    -0.051178658;0.007874526;0.084368728;0.126869306;0.094528345;-0.012839661;
    -0.143477028;-0.211829088;-0.140513128;0.094601918;0.441387140;0.785875640;
    1.0];
    transmit_filter = [hhalf;flipud(hhalf)];

    %%%%%%%%%%TYPICAL CHOICE OF RECEIVE FILTER%%%%%%%%%%%%%
    %OPTIMAL FILTER SHOULD BE MATCHED TO CASCADE OF
    %TRANSMIT FILTER AND CHANNEL, BUT IF CHANNEL IS UNKNOWN,
    %WE TYPICALLY IMPLEMENT RECEIVE FILTER MATCHED TO TRANSMIT FILTER
    receive_filter = flipud(transmit_filter); %%filter matched to transmit filter

    %%%%%%%%%%%%%TRIVIAL CHANNEL FILTER FOR LAB 1%%%%%%%%%%%%%
    channel_filter = 1;
    %%%%%%%RESPONSE TO ONE SYMBOL AT RECEIVE FILTER INPUT%%%%%%%%%%%
    received_response = conv(transmit_filter,channel_filter);
    %%%%%%%RESPONSE TO ONE SYMBOL AT RECEIVE FILTER OUTPUT%%%%
    overall_response = conv(received_response,receive_filter);

    %%%%%%%%UPSAMPLING THE SYMBOL SEQUENCE%%%%%%%%%%%%%%%%%%%%
    m = oversampling_factor;
    %zeropadded symbol sequence, starting and ending with nonzero symbols
    Lpadded = m*(length(symbols) -1)+1; %%length of zeropadded sequence
    symbolspadded = zeros(Lpadded,1); %%initialize
    symbolspadded (1:m:Lpadded) = symbols; %%fill in bit values every m entries

    %%%%%%%NOISELESS RECEIVER INPUT%%%%%%%%%%%%
    receive_input = conv(symbolspadded,received_response);
    %%%%%%%NOISELESS RECEIVE FILTER OUTPUT%%%%%%%
    receive_output = conv(receive_input,receive_filter);
end