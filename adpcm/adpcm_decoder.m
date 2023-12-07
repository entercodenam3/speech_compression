function [out] = decoder(x,B0,B1,B2,B3)
%ADPCM Decoder.
Ml_values_table = [-1,-1,-1,-1,2,4,6,8];
step_sizes_table = [16,17,19,21,23,25,28,31,34,37,41,45,50,55,60,66,73,80,88,97,107,118,130,143,157,173,190,209,230,253,279,307,337,371,408,449,494,544,598,658,724,796,876,963,1060,1166,1282,1411,1552];
ss = step_sizes_table;

% Initialization 
index = 0;
current_sample = 0;
out = zeros(size(x));

for i = 1:length(x),
    diff = fix(ss(index+1)/8) + fix(B0(i)*ss(index+1)/4) + fix(B1(i)*ss(index+1)/2) + fix(B2(i)*ss(index+1));
    if B3(i) == 1,
        diff = -diff;
    end
   
    current_sample = current_sample + diff; 
    if current_sample>32767,
        output = 32767;
    elseif current_sample<-32768, 
        output = -32768;
    else
        output = current_sample;
    end
    
    out(i) = output;
    
    index = index + Ml_values_table(4*B2(i) + 2*B1(i) + 1*B0(i) + 1); 
    if (index<0),
        index=0;             
    elseif (index>48),
        index=48;       
    end

end

end