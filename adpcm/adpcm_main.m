clc, clear;
filename = "C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Speech Coding\Recording (2).wav";
[x,fs] = audioread(filename);
x = x(1:100000,1)'*100;   % Crop a piece of audio as input
t = (1:length(x));

%sound(x,fs)
subplot(311);
plot(t,x,'g');title('original audio');hold on;

subplot(312);
[x1,B0,B1,B2,B3] = encoder(x);
x2 = decoder(x1,B0,B1,B2,B3);
plot(t,x2,'b');title('encoded-decoded audio');hold on;
%sound(x2,fs)
audiowrite("C:\Users\Srinath\Documents\NITK\SEM 5\EE386\Speech Coding\pcm_test2.wav",x2,fs)
subplot(313);
plot(t,x,'g','LineWidth',2);hold on;
plot(t,x2,'b','LineWidth',1);hold on
title('Comparison between original and encoded-decoded audio');
figure(2);
x3 = (x-x2);
plot(t,x3);
title('error between original and encoded-decoded audio');