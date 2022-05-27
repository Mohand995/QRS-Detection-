data=xlsread("ECG_SR360hz.xlsx");
signal=data(:,1);

%%%draw data
t=1:1:897;
fs=360; 
time=t/fs;
subplot(6,1,1);
plot(time,signal);
title('Original signal');
%%%lowpassfilter%%%%
l_p=lowfilt; 
lpf_filtered_ECG = filter(l_p,signal);
subplot(6,1,2);
plot(lpf_filtered_ECG);
title('After LPF');
%%%%%%%%%%%%%%%%%%%%%%%%
%%%%high pass filter
H_p=highfilt; 
hpf_filtered_ECG = filter(H_p,lpf_filtered_ECG);
subplot(6,1,3);
plot(hpf_filtered_ECG);
title('After HPF');
%%%%%%%%%%%%differentiation%%%%%%%%%%%%%%
DF_filtered_ECG=diff(hpf_filtered_ECG);
subplot(6,1,4);
plot(DF_filtered_ECG);
title('After differentiation');
%%%%%%%%%%%%%%squaring%%%%%%%%%%%%%%%%%%%
Sq_filtered_ECG=DF_filtered_ECG.^2;
subplot(6,1,5);
plot(Sq_filtered_ECG);
title('After squaring');
%%%%%%%%%%moving av%%%%%%%%%%
window= 1/32*ones(32,1);
AV_filtered_ECG = filter(window,1,Sq_filtered_ECG);
subplot(6,1,6);
plot(AV_filtered_ECG);
title('After moving average');
%%%freq component of signal%%%
n=length(signal);
y=fft(signal);
f=(0:n-1)*(fs/n);
plot(f,abs(y));
title('After LPF');
%%%%%%%%%%%%%%%%freq component after LPF%%%%%%%%%%%%%
n=length(lpf_filtered_ECG);
y=fft(lpf_filtered_ECG);
f=(0:n-1)*(fs/n);
plot(f,abs(y));
axis([0 200 0 25])
