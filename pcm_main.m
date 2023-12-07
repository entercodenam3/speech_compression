clc 
clear all
[speech, fs] = audioread("C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Speech Coding\Recording (2).wav");

% Quantization levels
b = 8; %Bits
L = 2^b; % Number of quantization levels

% Quantization step size
delta = (max(speech) - min(speech)) / (L - 1);

% Quantized speech signal
quantized_speech = round(speech / delta);

% Dequantized speech signal
dequantized_speech = quantized_speech * delta;

%Signal-to-Noise Ratio 
snr = 10 * log10(mean(speech.^2) / mean((speech - dequantized_speech).^2));

%Saving new file
audiowrite("C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Speech Coding\pcm_test2.wav", dequantized_speech, fs);

% Plots (Original and Compressed)
subplot(2,1,1)
plot(speech);
title('Original vs. Compressed Speech Signal');
xlabel('Sample index');
ylabel('Amplitude');
subplot(2,1,2)
plot(dequantized_speech);
xlabel('Sample index');
ylabel('Amplitude');


sound(dequantized_speech,fs)