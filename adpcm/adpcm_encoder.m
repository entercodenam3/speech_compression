function [out,B0,B1,B2,B3] = encoder(x)
%ADPCM Encoder.

Ml_values_table = [-1,-1,-1,-1,2,4,6,8];
step_sizes_table = [16,17,19,21,23,25,28,31,34,37,41,45,50,55,60,66,73,80,88,97,107,118,130,143,157,173,190,209,230,253,279,307,337,371,408,449,494,544,598,658,724,796,876,963,1060,1166,1282,1411,1552];
ss = step_sizes_table;

% Initialization
index = 0;
pre_data = 0;
B0=zeros(size(x));
B1=zeros(size(x)); 
B2=zeros(size(x)); 
B3=zeros(size(x));
% L=0;
out = zeros(size(x));

for i = 1:length(x),
    current_data = x(i);                
    diff = current_data - pre_data;     

    if diff<0,
        diff = abs(diff); 
        B3(i) = 1; 
    end
    
    if diff < ss(index+1)/4,
        B2(i) = 0; B1(i) = 0; B0(i) = 0;
    elseif diff > ss(index+1)/4 && diff < ss(index+1)/2,
        B2(i) = 0; B1(i) = 0; B0(i) = 1;
    elseif diff > ss(index+1)/2 && diff < ss(index+1)*3/4,
        B2(i) = 0; B1(i) = 1; B0(i) = 0;
    elseif diff > ss(index+1)*3/4 && diff < ss(index+1),
        B2(i) = 0; B1(i) = 1; B0(i) = 1;
    elseif diff > ss(index+1) && diff < ss(index+1)*5/4,
        B2(i) = 1; B1(i) = 0; B0(i) = 0;
    elseif diff > ss(index+1)*5/4 && diff < ss(index+1)*3/2,
        B2(i) = 1; B1(i) = 0; B0(i) = 1;
    elseif diff > ss(index+1)*3/2 && diff < ss(index+1)*7/4,
        B2(i) = 1; B1(i) = 1; B0(i) = 0;
    elseif diff > ss(index+1)*7/4,
        B2(i) = 1; B1(i) = 1; B0(i) = 1;
    end

    L = 8*B3(i) + 4*B2(i) + 2*B1(i) + B0(i);
    out(i) = L;
    
    diff = fix(ss(index+1)/8) + fix(B0(i)*ss(index+1)/4) + fix(B1(i)*ss(index+1)/2) + fix(B2(i)*ss(index+1));
    diff = (-1)^B3(i)*diff;
    pre_data = pre_data + diff; 
    
    index = index + Ml_values_table(4*B2(i) + 2*B1(i) + 1*B0(i) + 1); 
    if (index<0),
        index=0;
    elseif (index>48),
        index=48;     
    end
    
end
end